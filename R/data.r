#' Dataframe of official Denison palettes, their color names and naming codes
#'
#' @description
#' Dataframe of official Denison palettes, their color names and naming codes
#'
#' @format A data frame of official Denison colors with hex, CMYK and
#' Pantone codes
#' \describe{
#'    \item{group}{palette group}
#'    \item{name}{color name}
#'    \item{hex}{hex values of colors in that palette}
#'    \item{cmyk}{CMYK code}
#'    \item{pms}{Pantone code}
#' }
#' @source <https://denison.edu/offices/communications/branding/color-palette>
"den_colors_df"

#' List of official Denison palettes and their colors
#'
#' @description
#' List of official Denison palettes and their colors
#'
#' @format A grouped list of official Denison palettes with hex values  of the colors
#' @source <https://denison.edu/offices/communications/branding/color-palette>
"den_palettes"

#' Set of hex values of official Denison colors
#'
#' @description
#' Set of hex values of official Denison colors
#'
#' @format A named character vector of hex values
#' @source <https://denison.edu/offices/communications/branding/color-palette>
"den_colors"


#' Names of open source fonts that are similar to the official Denison fonts.
#' @description
#' These are open source fonts from Google Fonts that are similar to
#' the official Denison fonts.
#' @format A data frame of font names
#' \describe{
#'    \item{purpose}{place to use font}
#'    \item{denison_font}{Offical font, usually closed source Adobe}
#'    \item{denison_alt}{Sanctioned Alternative}
#'    \item{google_substitute}{Open source Google font used in this package}
#' }
#' @source <https://denison.edu/offices/communications/branding/typography>
"den_font_map"

#' Google Substitute Names of Denison  fonts
#'
#' @description
#' Set of  Google Substitute Names and aliases of Denison  fonts
#'
#' @format A named character vector of font names
#' @source <https://denison.edu/offices/communications/branding/color-palette>
"den_fonts"

#' Top 100 Liberal Arts College and University Rankings
#' @description
#' U.S. News & World Report Historical Liberal Arts College and University Rankings.
#' A subset of the data from Andy Reiter's College Scorecard Data.
#' Available at: http://andyreiter.com/datasets/
#' @format A data frame
#' \describe{
#'    \item{college}{College Name}
#'    \item{ipeds_id}{IPEDS ID}
#'    \item{state}{State}
#'    \item{year}{Year}
#'    \item{rank}{Rank}
#' }
#' @source <http://andyreiter.com/datasets/>
"rank_data"

#' Fraction of Students Receiving Pell Grants
#' @description
#' U.S. News & World Report Liberal Arts College and University Rankings.
#' This table shows the percentage of undergraduates receiving federal Pell Grants.
#' Students from households that earn less than $50,000 annually typically qualify for Pell.
#' The proportion of students receiving Pell Grants isn't a perfect measure of an
#' institution's efforts to achieve economic diversity: A college might enroll a
#' large number of students just above the Pell cutoff, for instance. Still,
#' many experts say that Pell figures are the best available gauge of how many
#' low-income undergrads there are on a given campus. Pell Grant percentages
#' were calculated using fall 2022 data reported to U.S. News on all degree-seeking
#' undergraduates. In some cases, 2020-2021 data from the IPEDS Student
#' Financial Aid survey was used.
##' @format A data frame
#' \describe{
#'    \item{college}{College Name}
#'    \item{city}{City}
#'    \item{state}{State}
#'    \item{pell_frac}{Fraction of Students Receiving Pell Grants}
#' }
#' @source <https://www.usnews.com/best-colleges/rankings/national-liberal-arts-colleges/economic-diversity>
"pell_grants"

#' List of Denison peer schools
#' @description
#' List of Denison peer schools
#'
#' @format List chr [1:20]
#'
"peer_schools_list"
