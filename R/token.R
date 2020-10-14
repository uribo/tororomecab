#' Create token via data.frame
#' @param data data.frame
#' @inheritParams RcppMeCab::pos
#' @param ... Additional arguments passed to [RcppMeCab::pos][RcppMeCab::pos]
#' @export
#' @examples
#' \dontrun{
#' data.frame(x = intToUtf8(c(12377L, 12418L, 12418L, 12418L, 12418L,
#' 12418L, 12418L, 12418L, 12418L, 12398L, 12358L, 12385L))) %>%
#'   mecab_token_df(x)
#' }
#' @return [tibble][tibble::tibble]
#' @rdname mecab_token_df
mecab_token_df <- function(data, sentence, ...) {
  data %>%
    dplyr::pull({{ sentence }}) %>%
    tibble_pos(...)
}

tibble_pos <- function(sentence, sys_dic = "", user_dic = "", ...) {
  subtype <- NULL
  RcppMeCab::pos(sentence,
                 format = "data.frame",
                 join = FALSE,
                 sys_dic = sys_dic,
                 user_dic = user_dic) %>%
    dplyr::mutate(subtype = dplyr::na_if(subtype, "")) %>%
    tibble::as_tibble()
}
