library(data.table)
library(plotly)
library(lubridate)
library(modules)

load <- modules::use("load.R")
clean <- modules::use("clean.R")


sales <- load$load_sales()
items <- load$load_items()

data <- clean$clean(sales, items)

grouped <- data[, .N, by=date]

series <- as.ts(data)