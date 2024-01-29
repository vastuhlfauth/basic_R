
install.packages("tidyverse")
install.packages(
  c("arrow", "babynames", "curl", "duckdb", "gapminder", 
    "ggrepel", "ggridges", "ggthemes", "hexbin", "janitor", "Lahman", 
    "leaflet", "maps", "nycflights13", "openxlsx", "palmerpenguins", 
    "repurrrsive", "tidymodels", "writexl")
)


#1 Data visualization

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)+
  geom_point(mapping=aes(color=species, shape = species))+
  geom_smooth(method="lm")+
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  )


## Exercices


ggplot(
  data=penguins,
  mapping=aes(x=bill_depth_mm , y=bill_length_mm,color=species)
)+
  geom_point()+
  geom_smooth(method = "lm")


ggplot(
  data=penguins,
  mapping=aes(x=bill_depth_mm , y=species,color=species)
)+
  geom_point()+
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(penguins, aes(x = species)) +
  geom_bar()

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)


#3  Data transformation
# if flights is a tibble (in dplyr)
install.packages("rflights")

View(flights)

flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

flights |> 
  filter(month %in% c(1, 2))

f1<-flights
f2<-flights |> 
  distinct()
f3<-flights |> 
  distinct(origin, dest)

####

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )


#5  Data tidying

df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)

df |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )

students <- read_csv("https://pos.it/r4ds-students-csv")



