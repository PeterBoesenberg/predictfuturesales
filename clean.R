import(data.table)
import(lubridate)

export("clean")


select_columns <- function(data) {
  data <- data[, item_name := NULL]
  data[, date := as_date(date, format = "%d.%m.%Y")]
}

combine_data <- function(sales, items) {
  setkey(sales, item_id)
  setkey(items, item_id)
  
  data <- items[sales]
  data
}


clean <- function(sales, items) {
  data <- combine_data(sales, items)
  data <- select_columns(data)
  
  data[order(date)]
}