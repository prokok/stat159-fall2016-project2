source("../functions/test-training-functions.R")


context("Test for test-training functions") 
test_that("test-training dataset", {
  expect_equal(length(scaled_credit), length(scaled_credit_test))
  expect_equal(length(scaled_credit), length(scaled_credit_train))
})
