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
                       panel.grid.major.x = ggplot2::element_blank()),
        ggplot2::theme(...))
}

#' Den-style geom for line or dot plots
#' @description
#' Meta ggplot parameter for line or dot plots that sets all den-relevant style
#' elements to defaults

#' @param pal override default den secondarydark palette
#'
#' @export
#' @examples
#' library(ggplot2)
#' # Create a sequence of years
#' years <- seq(2014, 2023)
#'
#' # Create series
#' series <- LETTERS[1:6]
#'
#' # Create data frame
#' df <- data.frame(year = rep(years, each = length(series)),
#'                  series = rep(series, times = length(years)),
#'                  value = (runif(length(years) * length(series))+1)*1:6)
#'
#' # plot df using ggplot
#' df |> ggplot(aes(year, value, color = series)) +
#'   ggden_line()
#'
ggden_line<-function(pal="secondarydark") {
  list(theme_den(),
       scale_color_den(palette=pal),
       ggplot2::geom_line(size=1.5))
}


#' Den-style elements for filled plots
#' @description
#' Meta ggplot parameter for filled plots that sets all den-relevant style
#' elements to defaults, including theme.  Still needs a geom.

#' @param pal override default den secondarydark palette
#'
#' @export
#' @examples
#' library(ggplot2)
#' dt = data.frame(Category = LETTERS[1:6], values = runif(6)*10)
#' dt |> ggplot(aes(Category, values,fill = Category)) + geom_col() +
#'   ggden()
ggden<-function(pal="secondarydark") {
  list(theme_den(),
       scale_fill_den(palette=pal))
}


