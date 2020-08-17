import(data.table)

export("load_sales", "load_items")


load_sales <- function() {
  fread("data/sales_train.csv")
}

load_items <- function() {
  fread("data/items.csv")
}