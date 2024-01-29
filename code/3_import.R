con <- DBI::dbConnect(duckdb::duckdb())

dbWriteTable(con, "mpg", ggplot2::mpg)
dbWriteTable(con, "diamonds", ggplot2::diamonds)

dbListTables(con)
#> [1] "diamonds" "mpg"

con |> 
  dbReadTable("diamonds") |> 
  as_tibble()

sql <- "
  SELECT carat, cut, clarity, color, price 
  FROM diamonds 
  WHERE price > 15000
"
as_tibble(dbGetQuery(con, sql))

######
library(arrow)

dir.create("data", showWarnings = FALSE)

curl::multi_download(
  "https://r4ds.s3.us-west-2.amazonaws.com/seattle-library-checkouts.csv",
  "data/seattle-library-checkouts.csv",
  resume = TRUE
)




