#' Create tf-idf data.frame
#' @inheritParams mecab_token_df
#' @param id variable name as identifier
#' @param token token variable name
#' @inheritParams dplyr::count
#' @export
#' @rdname token_tfidf
token_tfidf <- function(data, id, token, sort = TRUE) {
  n <- NULL
  res <-
    data %>%
    dplyr::count({{ id }}, {{ token }}, sort = TRUE) %>%
    dplyr::group_by({{ id }}, {{ token }}) %>%
    dplyr::summarise(n = sum(n), .groups = "drop") %>%
    tidytext::bind_tf_idf(document = {{ id }},
                          term = {{ token }},
                          n = n)
  if (sort == TRUE) {
    res %>%
      dplyr::arrange(dplyr::desc(n))
  } else {
    res
  }
}
