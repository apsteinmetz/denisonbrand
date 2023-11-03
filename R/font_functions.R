# load Google font substitutes for Denison fonts
# make_font_map <- function(){
#   den_font_map <- data.frame(
#     purpose =           c("display",          "display", "display",      "text",         "text"),
#     denison_font =      c("Caslon Graphiqe D","DINOT",   "High Tower",   "FreightSans",  "Caslon"),
#     denison_alt =       c("Lora",             "Oswald",  "Georgia",      "Trebuchet",    "Georgia"),
#     google_substitute = c("Lora",             "Oswald",  "Crimson Text", "Open Sans",    "Libre Caslon")
#   )
#   den_font_map
# }

#' Load Google Fonts
#' @description
#' Load Google versions of Denison Fonts into Environment
#' @format A named character vector of font names ready for use with showtext
#' @source <https://denison.edu/offices/communications/branding/color-palette>
#' @export
#' @examples
#' library(ggplot2)
#' library(showtext)
#' showtext_auto()
#'
#' load_fonts()
#' gg <- ggplot(NULL, aes(x = 1, y = 1)) + ylim(0.5, 1.5) + theme_void()
#' for (n in 1:length(den_fonts)){
#' gg <- gg + annotate("text", 1, 1.4 - (0.1 * n),
#'                      family = den_fonts[n], size = 15,
#'                      label = paste(names(den_fonts[n]),": ",den_fonts[n]))
#' }
#'gg
#'
#' showtext_auto(enable = FALSE)
load_fonts <- function(){
  print("Loading Google Fonts")
  for (n in 1:length(denisonbrand::den_fonts)){
    print(denisonbrand::den_fonts[n])
    sysfonts::font_add_google(denisonbrand::den_fonts[n])
  }
  showtext_auto()
}

