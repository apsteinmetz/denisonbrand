#' Denison Brand styles
#'
#' @docType package
#' @name denisonbrand
#' @author Arthur Steinmetz
#' @description Typefaces and Color palettes for ggplot2 using Denison University Branding as of 2023.
#' @section Credit:
#' Branding guildlines at
#' \url{https://brand.denison.edu}
#' Color tools Modeled on
#' \url{https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2}
#'
## usethis namespace: start
#' @import dplyr
#' @import ggplot2
#' @import grDevices
#' @import sysfonts
#' @import showtext
#' @keywords internal
"_PACKAGE"
## usethis namespace: end
NULL

# declare data items as global variables
utils::globalVariables(c("den_colors",
                         "den_palettes",
                         "den_colors_df",
                         "den_font_map",
                         "den_fonts",
                         "pell_grants",
                         "peer_schools_list",
                         "rank_data"))
