# Colocando a localização do diretório de trabalho
trab = getwd()
setwd(paste0(dtrab, "/mapa"))

library(pdftools)
download.file("http://arxiv.org/pdf/1403.2805.pdf", "./dados/1403.2805.pdf", mode = "wb")
txt <- pdf_text("./dados/1403.2805.pdf")

# first page text
cat(txt[1])

# second page text
cat(txt[2])

# Table of contents
toc <- pdf_toc("./dados/1403.2805.pdf")

# Show as JSON
jsonlite::toJSON(toc, auto_unbox = TRUE, pretty = TRUE)

# Author, version, etc
info <- pdf_info("./dados/1403.2805.pdf")

# Table with fonts
fonts <- pdf_fonts("./dados/1403.2805.pdf")

# renders pdf to bitmap array
bitmap <- pdf_render_page("./dados/1403.2805.pdf", page = 1)

# save bitmap image
png::writePNG(bitmap, "./dados/page.png")
webp::write_webp(bitmap, "./dados/page.webp")

# Reconstituindo diretório original...
setwd(dtrab)
