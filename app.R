library(data.table)
library(plotly)
library(lubridate)
library(modules)

load <- modules::use("load.R")
clean <- modules::use("clean.R")


sales <- load$load_sales()
items <- load$load_items()

data <- clean$clean(sales, items)
data <- data[, revenue := item_price * item_cnt_day]
grouped <- data[, .(day_revenue = sum(revenue)/1000), by = date]

series <- as.ts(grouped$day_revenue)

chart_series <- function(data) {
  dt <- as.data.table(data)
  dt <- dt[, date := rownames(dt)]
  print(dt)
  fig <- plot_ly( type = 'scatter', mode = 'lines')
  fig <- add_trace(fig, data = dt, x = ~date, y = ~x, name = "Daily revenue")
  fig
}
chart_series(series)
arr <- predict(arima(series, order=c(3,0,0)), n.ahead = 100)
names(arr)[1] <- "x" 
chart_series(arr)
