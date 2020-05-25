#
# Generic functions to use arithmetic operators with casadi objects
#
# Based on advice in this link
# https://github.com/rstudio/reticulate/issues/170
#

"+.casadi.casadi.MX" = function(a, b) {
  op = import("operator")
  op$add(a, b)
}

"-.casadi.casadi.MX" = function(a, b) {
  op = import("operator")
  op$sub(a, b)
}

"*.casadi.casadi.MX" = function(a, b) {
  op = import("operator")
  op$mul(a, b)
}

"*/.casadi.casadi.MX" = function(a, b) {
  op = import("operator")
  op$truediv(a, b)
}

"^.casadi.casadi.MX" = function(a, b) {
  op = import("operator")
  op$pow(a, b)
}

