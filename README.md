
<!-- README.md is generated from README.Rmd. Please edit that file -->

tororomecab
===========

<!-- badges: start -->
<!-- badges: end -->

tororomecab
（トロロメカブ）パッケージは、日本語文章の形態素解析エンジンの[MeCab](https://taku910.github.io/mecab/)を利用した解析結果をtidyに扱うためのパッケージです。形態素解析の処理に[RcppMeCab](https://github.com/junhewk/RcppMeCab)を利用しています。

インストール
------------

パッケージのインストールはGitHub経由で行います。remotesパッケージを使いますので別途インストールしてください。次のコマンドで必要なパッケージがインストールされます。

    if (!requireNamespace("remotes"))
      install.packages("remotes")

    remotes::install_github("uribo/tororomecab")

使い方
------

    library(tororomecab)

    d <- 
      data.frame(
        sentence = c("メロスは激怒した。必ず、かの 邪智暴虐の王を除かなければならぬと決意した。",
                   "こんな夢を見た。\n腕組をして枕元に坐すわっていると、仰向あおむきに寝た女が、静かな声でもう死にますと云う。"))

    d_token <- 
      d %>% 
      mecab_token_df(sentence)
    d_token
    #> # A tibble: 61 x 6
    #>    doc_id sentence_id token_id token  pos    subtype   
    #>    <chr>        <int>    <int> <chr>  <chr>  <chr>     
    #>  1 1                1        1 メロス 名詞   一般      
    #>  2 1                1        2 は     助詞   係助詞    
    #>  3 1                1        3 激怒   名詞   サ変接続  
    #>  4 1                1        4 し     動詞   自立      
    #>  5 1                1        5 た     助動詞 <NA>      
    #>  6 1                1        6 。     記号   句点      
    #>  7 1                2        1 必ず   副詞   助詞類接続
    #>  8 1                2        2 、     記号   読点      
    #>  9 1                2        3 かの   連体詞 <NA>      
    #> 10 1                2        4 邪智   名詞   一般      
    #> # … with 51 more rows

    d_token %>% 
      dplyr::filter(pos == "名詞") %>% 
      token_tfidf(doc_id, token)
    #> # A tibble: 12 x 6
    #>    doc_id token      n    tf   idf tf_idf
    #>    <chr>  <chr>  <int> <dbl> <dbl>  <dbl>
    #>  1 1      メロス     1 0.167 0.693  0.116
    #>  2 1      王         1 0.167 0.693  0.116
    #>  3 1      激怒       1 0.167 0.693  0.116
    #>  4 1      決意       1 0.167 0.693  0.116
    #>  5 1      邪智       1 0.167 0.693  0.116
    #>  6 1      暴虐       1 0.167 0.693  0.116
    #>  7 2      女         1 0.167 0.693  0.116
    #>  8 2      声         1 0.167 0.693  0.116
    #>  9 2      静か       1 0.167 0.693  0.116
    #> 10 2      枕元       1 0.167 0.693  0.116
    #> 11 2      夢         1 0.167 0.693  0.116
    #> 12 2      腕組       1 0.167 0.693  0.116
