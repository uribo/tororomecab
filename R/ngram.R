#' N-gram data.frame
#' @inheritParams mecab_token_df
#' @param ngram N-gram count. Default is set 2 (bi-gram).
#' @param collapse an optional character string to separate the tokens.
#' @export
#' @examples
#' \dontrun{
#' d <- data.frame(x = intToUtf8(c(12377L, 12418L, 12418L, 12418L, 12418L,
#'                                 12418L, 12418L, 12418L, 12418L, 12398L,
#'                                 12358L, 12385L)))
#' d %>%
#'   ngram_df(x)
#' # Tri-gram
#' d %>%
#'   ngram_df(x, n = 3)
#' # Uni-gram
#' d %>%
#'   ngram_df(x, n = 1)
#' }
#' @rdname ngram_df
ngram_df <- function(data, sentence, ngram = 2L, collapse= " ", ...) {
  if (is.numeric(ngram) & ngram >= 1) {
    token <- NULL
    data %>%
      dplyr::pull({{ sentence }}) %>%
      tibble_pos(...) %>%
      dplyr::mutate(ngram = slider::slide_chr(token,
                                              paste,
                                              collapse = collapse,
                                              .after = ngram - 1))
  } else {
    rlang::abort("The ngram argument must be an integer of 1 or more.")
  }
}
