testthat::context("Test OSI extractors")

testthat::test_that("licenses IDs can be retrieved", {
  licenses <- license_list()
  ids <- extract_id(licenses)
  testthat::expect_true(is.vector(ids, mode = "character"))
  testthat::expect_equal(length(ids), length(licenses))
})

testthat::test_that("licenses names can be retrieved", {
  licenses <- license_list()
  ids <- extract_name(licenses)
  testthat::expect_true(is.vector(ids, mode = "character"))
  testthat::expect_equal(length(ids), length(licenses))
})

testthat::test_that("licenses superseded states can be retrieved", {
  licenses <- license_list()
  ids <- extract_superseded(licenses)
  testthat::expect_true(is.vector(ids, mode = "character"))
  testthat::expect_equal(length(ids), length(licenses))
})

testthat::test_that("licenses keywords can be retrieved", {
  licenses <- license_list()
  ids <- extract_keywords(licenses)
  testthat::expect_true(is.list(ids))
  testthat::expect_equal(length(ids), length(licenses))
})
