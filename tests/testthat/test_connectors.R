testthat::context("Test OSI connectors")

testthat::test_that("All licenses can be retrieved", {
  field_names <- c("id", "identifiers", "links", "name", "other_names", "superseded_by",
                   "keywords", "text")
  licenses <- license_list()
  testthat::expect_true(is.list(licenses))
  testthat::expect_true(all(field_names == names(licenses[[1]])))
})

testthat::test_that("Keyword retrieval works", {
  field_names <- c("id", "identifiers", "links", "name", "other_names", "superseded_by",
                   "keywords", "text")
  licenses <- license_by_keyword("copyleft")
  testthat::expect_true(is.list(licenses))
  testthat::expect_true(all(field_names == names(licenses[[1]])))
})

testthat::test_that("ID retrieval works", {
  field_names <- c("id", "identifiers", "links", "name", "other_names", "superseded_by",
                   "keywords", "text")
  licenses <- license_by_id("GPL-2.0")
  testthat::expect_true(is.list(licenses))
  testthat::expect_true(all(field_names == names(licenses[[1]])))
})

testthat::test_that("Content retrieval works", {
  cnames <- c("license", "content", "retrieved_from")
  licenses <- license_by_id("GPL-2.0")
  license_content <- license_text(licenses)
  testthat::expect_true(is.data.frame(license_content))
  testthat::expect_equal(nrow(license_content), 1)
  testthat::expect_equal(ncol(license_content), 3)
  testthat::expect_true(all(cnames == names(license_content)))

})