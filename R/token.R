#' Create token via data.frame
#' @param data data.frame
#' @inheritParams RcppMeCab::pos
#' @export
#' @rdname mecab_token_df
mecab_token_df <- function(data, sentence, sys_dic = "", user_dic = "") {
  subtype <- NULL
  data %>%
    dplyr::rename(input_var = {{ sentence }}) %>%
    dplyr::group_modify(
      ~ RcppMeCab::pos(.x$input_var,
                       format = "data.frame",
                       sys_dic = sys_dic,
                       user_dic = user_dic)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(subtype = dplyr::na_if(subtype, "")) %>%
    tibble::as_tibble()
}
