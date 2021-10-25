
library(plumber)
source("app.R")

#* @apiTitle Farms API
#* @apiDescription API to send and receive data on farms.

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
    list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a pie chart for different farm types
#* @serializer png
#* @get /pie_plot
function() {
  pie(table(farms_data.frame["farm_type"]))
}

#* Return the data from farms database
#* @param n Enter the number of rows you want to extract from the database (max 10000)
# #* @param b The second number to add
#* @post /data
function(n) {
    farms_data.frame[0:n,]
}

# Programmatically alter your API
#* @plumber
function(pr) {
    pr %>%
        # Overwrite the default serializer to return unboxed JSON
        pr_set_serializer(serializer_unboxed_json())
}
