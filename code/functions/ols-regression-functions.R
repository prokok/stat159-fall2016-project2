#This function calculates RSS. Input is lm object. Output is RSS(numeric).
residual_sum_squares = function(x) {
  return(sum(x$residuals^2))   
}

#This function caculates residual standard error. Input is lm object. Output is RSS(numeric).
residual_std_error = function(x){
  df_residual = x$df.residual
  rse = sqrt(residual_sum_squares(x)/df_residual)
  return(rse)
}
