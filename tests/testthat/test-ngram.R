test_that("multiplication works", {
  d <- data.frame(x = intToUtf8(c(12377L, 12418L, 12418L, 12418L, 12418L,
                                  12418L, 12418L, 12418L, 12418L, 12398L,
                                  12358L, 12385L)))
  res <-
    d %>%
    ngram_df(x)
  expect_is(res, "data.frame")
  expect_is(res, "tbl_df")
  expect_equal(dim(res),
               c(7L, 7L))
  res <-
    d %>%
    ngram_df(x, n = 3)
  expect_identical(res$ngram %>%
                     lapply(utf8ToInt),
                   list(
                     c(12377L, 12418L, 12418L, 32L, 12418L, 32L, 12418L, 12418L),
                     c(12418L, 32L, 12418L, 12418L, 32L, 12418L),
                     c(12418L, 12418L,
                       32L, 12418L, 32L, 12418L, 12418L),
                     c(12418L, 32L, 12418L, 12418L,
                       32L, 12398L),
                     c(12418L, 12418L, 32L, 12398L, 32L, 12358L, 12385L),
                     c(12398L, 32L, 12358L, 12385L),
                     c(12358L, 12385L)
                   ))
  expect_error(
    d %>%
      ngram_df(x, n = 0)
  )
})
