# Aplicativo geral

# Criando as funções
CharacterDataFetcherFactory <- R6::R6Class(
  classname = "CharacterDataFetcherFactory",
  public = list(
    initialize = function(api_url) {
      private$api_url <- api_url
      invisible(self)
    },
    create = function(data_fetcher_type) {
      switch(
        data_fetcher_type,
        paginated = CharacterDataFetcherPaginatedImpl$new(private$api_url),
        in_memory = CharacterDataFetcherInMemoryImpl$new(private$api_url)
      )
    }
  ),
  private = list(
    api_url = NA
  )
)

CharacterDataFetcherInMemoryImpl <- R6::R6Class(
  classname = "CharacterDataFetcherInMemoryImpl",
  inherit = CharacterDataFetcher,
  public = list(
    initialize = function(api_url) {
      private$api_url <- api_url
    },
    fetch_page = function(page_number, filter_settings) {
      private$fetch_data(filter_settings)
      
      data_page <- private$in_memory_data$data %>% 
        head(page_number * 20) %>% 
        tail(20)
      
      list(
        data = data_page,
        total_pages = private$in_memory_data$total_pages
      )
    }
  ),
  private = list(
    api_url = NA,
    current_filter_query = "",
    in_memory_data = NA,
    fetch_single_page = function(page_number, filter_query) {
      url <- glue::glue("{private$api_url}?page={page_number}&{filter_query}")
      api_response <- httr::GET(url = url)
      response_content <- httr::content(api_response)
      
      retrieved_data <- data.table::rbindlist(
        lapply(
          response_content$results,
          function(character) {
            data.frame(
              image = character$image,
              name = character$name,
              gender = character$gender,
              status = character$status,
              species = character$species,
              type = character$type
            )
          }
        )
      )
      
      list(
        total_pages = response_content$info$pages,
        data = retrieved_data,
        total_pages = response_content$info$count,
        next_page_url = response_content$info$`next`
      )
    },
    fetch_data = function(filter_settings) {
      filter_settings <- Filter(function(setting) setting != "", filter_settings)
      filter_query <-  sprintf(
        fmt = "%s=%s",
        names(filter_settings),
        filter_settings
      ) %>% paste(collapse = "&")
      
      if (is.na(private$in_memory_data) || private$current_filter_query != filter_query) {
        private$current_filter_query <- filter_query
        first_page_data <- private$fetch_single_page(
          page_number = 1, filter_query = filter_query
        )
        
        retrieved_data <- lapply(seq_len(first_page_data$total_pages), function(page_number) {
          private$fetch_single_page(page_number, filter_query)$data
        }) %>% data.table::rbindlist()
        
        private$in_memory_data <- list(
          data = retrieved_data,
          total_pages = first_page_data$total_pages
        )
      }
    } 
  )
)

CharacterDataFetcherPaginatedImpl <- R6::R6Class(
  classname = "CharacterDataFetcherPaginatedImpl",
  inherit = CharacterDataFetcher,
  public = list(
    initialize = function(api_url) {
      private$api_url <- api_url
    },
    fetch_page = function(page_number, filter_settings) {
      filter_settings <- Filter(function(setting) setting != "", filter_settings)
      filter_query <-  sprintf(
        fmt = "%s=%s",
        names(filter_settings),
        filter_settings
      ) %>% paste(collapse = "&")
      
      url <- glue::glue("{private$api_url}?page={page_number}&{filter_query}")
      api_response <- httr::GET(url = url)
      response_content <- httr::content(api_response)
      
      retrieved_data <- data.table::rbindlist(
        lapply(
          response_content$results,
          function(character) {
            data.frame(
              image = character$image,
              name = character$name,
              gender = character$gender,
              status = character$status,
              species = character$species,
              type = character$type
            )
          }
        )
      )
      
      list(
        total_pages = response_content$info$pages,
        data = retrieved_data,
        page_count = response_content$info$count,
        next_page_url = response_content$info$`next`
      )
    }
  ),
  private = list(
    api_url = NA
  )
)

CharacterDataFetcher <- R6::R6Class(
  classname = "CharacterDataFetcher",
  public = list(
    fetch_page = function(page_number, filter_settings) {
      
    }
  )
)

mod_characters_table_ui <- function(id, width, height) {
  ns <- shiny::NS(id)
  shiny::tagList(
    reactable::reactableOutput(
      outputId = ns("data_table"),
      width = width, 
      height = height
    ) 
  )
}

mod_characters_table_server <- function(id, current_data) {
  shiny::moduleServer(
    id = id,
    function(input, output, session) {
      output$data_table <- reactable::renderReactable({
        shiny::req(current_data())
        shiny::req(nrow(current_data()$data) > 0)
        
        create_character_table(
          table_data = current_data()$data
        )
      })
    }
  )
}

create_character_table <- function(table_data) {
  reactable::reactable(
    data = table_data,
    height = "70vh",
    defaultColDef = reactable::colDef(
      headerClass = "character-table-header"
    ),
    sortable = FALSE,
    columns = list(
      image = reactable::colDef(
        name = "",
        maxWidth = 88,
        cell = create_character_image
      ),
      name = reactable::colDef(
        name = "Name",
        cell = function(value, row_index) {
          shiny::div(
            shiny::div(
              class = "name-container",
              value
            ),
            shiny::div(
              class = "species-container",
              table_data[row_index, ]$species
            ),
            shiny::div(
              class = "type-container",
              table_data[row_index, ]$type
            )
          )
        }
      ),
      type = reactable::colDef(show = FALSE),
      species = reactable::colDef(show = FALSE),
      gender = reactable::colDef(
        name = "Gender",
        cell = create_gender_column_content
      ),
      status = reactable::colDef(
        name = "Status",
        cell = create_status_badge
      )
    ),
    pagination = FALSE,
    theme = reactable::reactableTheme(
      cellStyle = list(
        display = "flex",
        flexDirection = "column",
        justifyContent = "center"
      )
    )
  )
}

mod_filters_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::div(
    class = "filters-container",
    shiny::textInput(
      inputId = ns("name_filter"),
      label = "Name"
    ),
    shiny::selectInput(
      inputId = ns("gender_filter"),
      label = "Gender", 
      choices = c("", "female", "male", "genderless", "unknown")
    ),
    shiny::selectInput(
      inputId = ns("status_filter"),
      label = "Status",
      choices = c("", "alive", "dead", "unknown")
    )
  )
}

mod_filters_server <- function(id) {
  shiny::moduleServer(
    id = id,
    function(input, output, session) {
      filter_settings <- reactive({
        
        list(
          name = input$name_filter,
          status = input$status_filter,
          gender = input$gender_filter
        )
      })
      
      return(filter_settings)
    }
  )
}

mod_pagination_controls_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::div(
    class = "pagination-container",
    shiny::span(id = ns("pages_text"), class = "pages-text"),
    shiny::actionButton(
      inputId = ns("goto_first_page"), 
      class = "pagination-control", 
      label = "", 
      icon = shiny::icon("angle-double-left")
    ),
    shiny::actionButton(
      inputId = ns("prev_page"),
      class = "pagination-control",
      label = "", 
      icon = shiny::icon("angle-left")
    ),
    shiny::actionButton(
      inputId = ns("next_page"),
      class = "pagination-control",
      label = "",
      icon = shiny::icon("angle-right")
    ),
    shiny::actionButton(
      inputId = ns("goto_last_page"),
      class = "pagination-control", 
      label = "", 
      icon = shiny::icon("angle-double-right")
    )
  )
}

mod_pagination_controls_server <- function(id, page_number, total_pages) {
  shiny::moduleServer(
    id = id,
    function(input, output, session) {
      observeEvent(input$goto_first_page, {
        page_number(1)
      })
      
      observeEvent(input$goto_last_page, {
        page_number(total_pages())
      })
      
      observeEvent(input$prev_page, {
        current_page_number <- page_number()
        page_number(current_page_number - 1)
      })
      
      observeEvent(input$next_page, {
        current_page_number <- page_number()
        page_number(current_page_number + 1)
      })
      
      observeEvent(list(page_number(), total_pages()), {
        shiny::req(page_number())
        shiny::req(total_pages())
        
        left_bound_condition <- page_number() > 1
        shinyjs::toggleState(id = "prev_page", condition = left_bound_condition)
        shinyjs::toggleState(id = "goto_first_page", condition = left_bound_condition)
        
        right_bound_condition <- page_number() < total_pages()
        shinyjs::toggleState(id = "next_page", condition = right_bound_condition)
        shinyjs::toggleState(id = "goto_last_page", condition = right_bound_condition)
      })
      
      observeEvent(list(page_number(), total_pages()), {
        page_number <- page_number()
        total_pages <- total_pages()
        text <- glue::glue("{page_number} of {total_pages} pages")
        shinyjs::html(id = "pages_text", html = text)
      })
    }
  )
}

create_character_image <- function(image_url) {
  shiny::img(
    src = image_url, 
    alt = image_url, 
    class = "character-image"
  )
}

create_gender_column_content <- function(gender_value) {
  icon_name <- switch(
    gender_value,
    Male = "mars",
    Female = "venus",
    Genderless = "genderless",
    unknown = "question"
  )
  
  shiny::div(
    class = "gender-cell-content",
    shiny::icon(icon_name, class = glue::glue_safe("{icon_name}-icon")),
    gender_value
  )
}

create_status_badge <- function(status) {
  style_name <- switch(
    status,
    Alive = "alive",
    unknown = "unknown",
    Dead = "dead"
  )
  
  class_name <- glue::glue_safe("status-badge-{style_name}")
  
  shiny::div(
    shiny::span(status, class = class_name)
  )
}
