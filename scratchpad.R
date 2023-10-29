library(ggplot2)
library(showtext)

showtext_auto()
load_fonts()

gg <- ggplot(NULL, aes(x = 1, y = 1)) + ylim(0.5, 1.5) + theme_void()
for (n in 1:length(den_fonts)){
  gg <- gg + annotate("text", 1, 1.4 - (0.1 * n),
                      family = den_fonts[n], size = 15,
                      label = paste(names(den_fonts[n]),": ",den_fonts[n]))

}
gg
showtext_auto(enable = FALSE)

# Install necessary packages
install.packages(c("readxl", "httr"))

# Load necessary libraries
library(readxl)
library(httr)

# URL of the excel file
url <- "https://andyreiter.com/wp-content/uploads/2023/09/US-News-Rankings-Liberal-Arts-Colleges-Through-2024.xlsx"

# Download the file and store it in a temporary location
temp <- tempfile(fileext = ".xlsx")
download.file(url, temp, mode = "wb")

rank_trend_source <- "Andrew G. Reiter, “U.S. News & World Report Historical Liberal Arts College and University Rankings,” available at: http://andyreiter.com/datasets/
"
# Read the Excel file
rank_trend_raw <- read_excel(temp,skip = 1, col_names = TRUE, col_types = "text")


ranktrlibrary(tidyverse)

# Print the data
rank_data <-
  rank_trend_raw |>
  mutate(across(matches("[[:digit:]]+"),  as.numeric)) |>
  mutate(state = as.factor(State)) |>
  select(-State) |>
  rename(college = `College Name`) |>
  rename(ipeds_id = `IPEDS ID`) |>
  filter(`2024` < 101) |>
  pivot_longer(cols = matches("[[:digit:]]+"), names_to = "year", values_to = "rank") |>
  mutate(year = as.numeric(year))


library(ggplot2)
library(showtext)
# plot ranking over time for Denison, Colgate and Lafayette
rank_data |>
  filter(college %in% c("Denison University","Colgate University","Lafayette College")) |>
  filter(year > 2002) |>
  ggplot(aes(x = year, y = rank, color = college)) +
  ggden_line() +
  scale_y_reverse() +
  labs(title = "U.S. News & World Report\nLiberal Arts College Rankings",
       subtitle = "Denison, Colgate and Lafayette",
       caption = 'Source: Andrew G. Reiter, “U.S. News & World Report Historical Liberal Arts College and University Rankings,”\navailable at: http://andyreiter.com/datasets/',
       x = "Year",
       y = "Rank (lower is better)",
       color = "College")

showtext_auto()
rank_data |>
  filter(college %in% c("Denison University","Colgate University","Lafayette College","Bucknell University")) |>
  filter(year == 2024) |>
  ggplot(aes(college, rank,fill = college)) + geom_col() +
   ggden() +
  labs(title = "Granville, Ohio")

#' @examples
#' library(ggplot2)
#' library(showtext)
#' dt = data.frame(Category = LETTERS[1:6], values = runif(6)*10)
#' dt |> ggplot(aes(Category, values,fill = Category)) + geom_col() +
#'   ggden() +
#'   labs(title = "Denison Brand Colors")
