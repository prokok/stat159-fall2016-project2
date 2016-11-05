source("../functions/ols-regression-functions.R")

context("Test for residual_sum_squares") 
test_that("residual_sum_squares", {
  reg = lm(mpg ~ disp + hp, data = mtcars)
  regsum = summary(reg)
  
  expect_equal(residual_sum_squares(reg), sum(reg$residuals^2))
  expect_length(residual_sum_squares(reg), 1)
  expect_gte(residual_sum_squares(reg), 0)
  expect_type(residual_sum_squares(reg), 'double')
})

context("Test for residual_std_error") 
test_that("residual_std_error", {
  reg = lm(mpg ~ disp + hp, data = mtcars)
  regsum = summary(reg)
  
  expect_equal(residual_std_error(reg), regsum$sigma)
  expect_length(residual_std_error(reg), 1)
  expect_gte(residual_std_error(reg), 0)
  expect_type(residual_std_error(reg), 'double')
})
