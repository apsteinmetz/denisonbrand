#'Denison Brand Theme for non-data elements of a plot
#'
#' @param ... override or supplement arguments to pass through to theme()
#'
#' @export
theme_den<- function(...){
  list (ggplot2::theme_bw(),
        ggplot2::theme(legend.title=ggplot2::element_blank(),
                       legend.position="top",
                       panel.grid.minor.y = ggplot2::element_blank(),
                       panel.grid.minor.x = ggplot2::element_blank(),
                       panel.grid.major.x = ggplot2::element_blank(),
                       text = element_text(family = den_fonts["den_display_sans"]),
                       plot.title = element_text(family = den_fonts["den_display_serif1"],
                                                 size = 20,
                                                 face = "bold",
                                                 color = den_colors["red"])
                       ),
        ggplot2::theme(...))
}

#' Den-style geom for line or dot plots
#' @description
#' Use to set line style and theme with one call.  Meta ggplot parameter for line or dot
#' plots that sets all den-relevant style
#' elements to defaults, including theme.

#' @param pal override default den secondarydark palette
#'
#' @export
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(showtext)
#' load_fonts()
#` #plot ranking over time for Denison, Colgate and Lafayette
#' rank_data |>
#'  filter(college %in% c("Denison University","Colgate University","Lafayette College")) |>
#'   filter(year > 2002) |>
#'   ggplot(aes(x = year, y = rank, color = college)) +
#'   ggden_line() +
#'   scale_y_reverse() +
#'   labs(title = "U.S. News & World Report Liberal Arts College Rankings",
#'        subtitle = "Denison, Colgate and Lafayette",
#'        caption = 'Source: Andrew G. Reiter, “U.S. News & World Report
#'        Historical Liberal Arts College and University Rankings,”
#'        \navailable at: http://andyreiter.com/datasets/',
#'        x = "Year",
#'        y = "Rank (lower is better)",
#'        color = "College")
#'
ggden_line<-function(pal="secondarydark") {
  list(theme_den(),
       scale_color_den(palette=pal),
       ggplot2::geom_line(size=1.5))
}


#' Den-style elements for filled plots
#' @description
#' Use to set data element style and theme with one call.
#' Meta ggplot parameter for filled plots that sets all den-relevant style
#' elements to defaults, including theme.  Still needs a geom.

#' @param pal override default den secondarydark palette
#'
#' @export
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(showtext)
#' load_fonts()
#' pell_grants |>
#'   filter(college %in%
#'     c("Denison University","Colgate University","Lafayette College","Bucknell University")) |>
#'   ggplot(aes(college,pell_frac,fill = college)) +
#'   labs(title = "U.S. News & World Report\nLiberal Arts College Rankings",
#'        subtitle = "Denison, Bucknell, Colgate and Lafayette",
#'        caption = 'Source: U.S. News & World Report, available at:
#'        https://www.usnews.com/best-colleges/rankings/
#'        national-liberal-arts-colleges/economic-diversity',
#'        y = "Fraction of Students Receiving Pell Grants") +
#'   ggden() +
#'   geom_col()
#'

ggden<-function(pal="secondarydark") {
  list(theme_den(),
       scale_fill_den(palette=pal))
}


