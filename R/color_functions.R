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
#' Convert names of den_colors to hex codes
#'
#' @param ... A Vector of character names of den_colors
#' @return A vector of hex codes
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
#' @returns A modified color value in hex
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
#' @return  Returns a function that takes an integer argument
#' (the required number of colors) and returns a character vector of colors
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
#' library(dplyr)
#' library(showtext)
#' load_fonts()
#` #plot ranking over time for Denison, Colgate and Lafayette
#' rank_data |>
#'  filter(college %in% c("Denison University","Colgate University","Lafayette College")) |>
#'   filter(year > 2002) |>
#'   ggplot(aes(x = year, y = rank, color = college)) +
#'   geom_line(linewidth = 1) +
#'   scale_y_reverse() +
#'   labs(title = "U.S. News & World Report\nLiberal Arts College Rankings",
#'        subtitle = "Denison, Colgate and Lafayette",
#'        caption = 'Source: Andrew G. Reiter, “U.S. News & World Report
#'        Historical Liberal Arts College and University Rankings,”
#'        \navailable at: http://andyreiter.com/datasets/',
#'        x = "Year",
#'        y = "Rank (lower is better)",
#'        color = "College") +
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
#' library(dplyr)
#' library(showtext)
#' load_fonts()
#' pell_grants |>
#'   filter(college %in%
#'     c("Denison University","Colgate University","Lafayette College","Bucknell University")) |>
#'   ggplot(aes(college,pell_frac,fill = college)) +
#'   geom_col() +
#'   labs(title = "U.S. News & World Report\nLiberal Arts College Rankings",
#'        subtitle = "Denison, Bucknell, Colgate and Lafayette",
#'        caption = 'Source: U.S. News & World Report, available at:
#'        https://www.usnews.com/best-colleges/rankings/
#'        national-liberal-arts-colleges/economic-diversity',
#'        y = "Fraction of Students Receiving Pell Grants") +
#'   scale_fill_den(palette = "secondarydark") +
#'   theme_den()
#'
scale_fill_den <- function(palette = "secondarydark", discrete = TRUE, reverse = FALSE, ...) {
  pal <- den_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("den_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}
