#'Denison Brand Theme for non-data elements of a plot
#'
#' @param ... override or supplement arguments to pass through to theme()
#'
#' @export
theme_den <- function(...) {
  list(
    ggplot2::theme_bw(),
    ggplot2::theme(
      legend.title = ggplot2::element_blank(),
      legend.position = "top",
      panel.grid.minor.y = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      text = element_text(family = den_fonts["den_display_sans"]),
      plot.title = element_text(
        family = den_fonts["den_display_serif1"],
        size = 20,
        face = "bold",
        color = den_colors["red"]
      )
    ),
    ggplot2::theme(...)
  )
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
#' # plot ranking over time for Denison, Colgate and Lafayette
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
ggden_line <- function(pal = "secondarydark") {
  list(
    theme_den(),
    scale_color_den(palette = pal),
    ggplot2::geom_line(linewidth = 1.5)
  )
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

ggden <- function(pal = "secondarydark") {
  list(theme_den(), scale_fill_den(palette = pal))
}


#' Add Denison logo or image to a ggplot
#' @description
#' Annotate a ggplot with a Denison brand image (logo, etc.) from the package's
#' image folder. The image is placed at the specified coordinates with optional scaling.
#'
#' @param image Character string specifying the image filename. Available images:
#'   "denison_logo.png", "denison_brick.png". Default is "denison_logo.png".
#' @param x Numeric x-coordinate for the center of the image in data coordinates.
#' @param y Numeric y-coordinate for the center of the image in data coordinates.
#' @param scale Numeric scaling factor for the image size. Default is 1.
#'   Values greater than 1 enlarge the image, values less than 1 shrink it.
#' @param hjust Horizontal justification (0 = left, 0.5 = center, 1 = right). Default is 0.5.
#' @param vjust Vertical justification (0 = bottom, 0.5 = center, 1 = top). Default is 0.5.
#'
#' @return A ggplot2 annotation layer that can be added to a plot.
#'
#' @details
#' The function reads PNG images from the package's inst/img directory and
#' creates an annotation layer using ggplot2's annotation_custom(). The image
#' dimensions are calculated based on the original aspect ratio and the scale parameter.
#'
#' @export
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(showtext)
#' load_fonts()
#'
#' # Add Denison logo to a plot
#' rank_data |>
#'   filter(college %in% c("Denison University", "Colgate University")) |>
#'   filter(year > 2010) |>
#'   ggplot(aes(x = year, y = rank, color = college)) +
#'   geom_line(linewidth = 1) +
#'   scale_y_reverse() +
#'   labs(title = "College Rankings") +
#'   theme_den() +
#'   scale_color_den() +
#'   annotate_den_image("denison_logo.png", x = 2020, y = 60, scale = 0.15)
#'
annotate_den_image <- function(
  image = "denison_logo.png",
  x,
  y,
  scale = 1,
  hjust = 0.5,
  vjust = 0.5
) {
  # Get the path to the image file
  img_path <- system.file("img", image, package = "denisonbrand")

  if (img_path == "") {
    available <- list.files(
      system.file("img", package = "denisonbrand"),
      pattern = "\\.png$"
    )
    stop(paste0(
      "Image '",
      image,
      "' not found. Available images: ",
      paste(available, collapse = ", ")
    ))
  }

  # Read the PNG image
  img <- png::readPNG(img_path)

  # Get image dimensions
  img_height <- nrow(img)
  img_width <- ncol(img)
  aspect_ratio <- img_width / img_height

  # Create a raster grob
  img_grob <- grid::rasterGrob(img, interpolate = TRUE)

  # Calculate half-widths for positioning based on scale
  # Base size is roughly 10 units, adjusted by scale
  base_size <- 10 * scale
  half_width <- base_size * aspect_ratio / 2
  half_height <- base_size / 2

  # Adjust for justification
  x_offset <- (hjust - 0.5) * 2 * half_width
  y_offset <- (vjust - 0.5) * 2 * half_height

  # Return an annotation_custom layer
  ggplot2::annotation_custom(
    grob = img_grob,
    xmin = x - half_width - x_offset,
    xmax = x + half_width - x_offset,
    ymin = y - half_height - y_offset,
    ymax = y + half_height - y_offset
  )
}
