#' Convenience demo function
#'@description
#'Display color bars for submitted hex codes
#'
#' @param col color hex values
#' @export
#' @examples
#' color_bars(den_colors)
#' color_bars(den_colors[c("red","neutralblue")])
#' color_bars(den_palettes$secondarydark)
#'
color_bars <- function(col = den_colors){
  graphics::barplot(rep(1, length(col)), col = col)
}



#' Extract den_colors as hex codes
#' @description
#' Function to extract den_colors as hex codes
#'
#' @param ... Vector of character names of den_colors
#'
#' @export
#' @examples
#' den_cols("tasseldarkgold")
#'
den_cols <- function(...) {
  #data("den_colors",envir = environment())
  cols <- c(...)

  if (is.null(cols))
    return (as.character(den_colors))

  as.character(den_colors[cols])
}


#' Change brightness value of a hex color.
#' @description
#' Function to change brightness value of a hex color.
#' Using this will create colors not from the official palette.
#'
#' @param hex_col hex color
#' @param val_fact brightness percentage change
#'
#' @export
#' @examples
#' # make brighter
#' den_palettes$secondarydark |> change_brightness(-.5) |> color_bars()
#' # make darker
#' den_palettes$secondarydark |> change_brightness(-.5) |> color_bars()
#'
change_brightness<-function(hex_col,val_fact=0.25){
  hsv_col<-hex_col %>% col2rgb() %>% rgb2hsv()
  if (val_fact>0) {
    hsv_col[3,]<-hsv_col[3,]+((1-hsv_col[3,])*val_fact)
  } else {
    hsv_col[3,]<-hsv_col[3,]*(1+val_fact)
  }
  return(hsv(hsv_col[1,],hsv_col[2,],hsv_col[3,]))
}

#' Interpolate colors of a `den` color palette
#' @description
#' Function to interpolate a den color palette
#' Mainly for internal use.
#' Using this will create colors not from the official palette.
#'
#' @param palette Character name of palette in den_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
#' @export
den_pal <- function(palette = "primary", reverse = FALSE, ...) {
  #data("den_palettes",envir = environment())
  pal <- den_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

#' Color scale constructor for den colors in ggplot2
#'
#' @param palette Character name of palette in den_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @details
#' The default palette is "secondarydark" which produces sensible results in most cases.  Use
#' scale_color_manual(values=den_cols(<color name(s)>) for finer control.
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
#' df |> ggplot(aes(year, value, color = series)) +
#'   geom_line(linewidth = 1) +
#'   scale_color_den(palette = "secondarydark") +
#'   theme_den()
#'
scale_color_den <- function(palette = "secondarydark", discrete = TRUE, reverse = FALSE, ...) {
  pal <- den_pal(palette = palette, reverse = reverse)
  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("den_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for den colors in ggplot2
#'
#' @param palette Character name of palette in den_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @details
#' The default palette is "secondarydark" which produces sensible results in most cases.  Use
#' scale_color_manual(values=den_cols(<color name(s)>) for finer control.
#' @export
#' @examples
#' library(ggplot2)
#' dt = data.frame(Category = LETTERS[1:6], values = runif(6)*10)
#' dt |> ggplot(aes(Category, values,fill = Category)) + geom_col() +
#' scale_fill_den() +
#' theme_den()
#'
scale_fill_den <- function(palette = "secondarydark", discrete = TRUE, reverse = FALSE, ...) {
  pal <- den_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("den_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}
