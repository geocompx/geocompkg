# Extracts R code from each chapter and dumps it in the code folder
#
generate_chapter_code = function(dir = ".", out_dir  = "code/chapters/") {
        rmd_files = list.files(path = dir, pattern = ".Rmd")
        r_files = paste0(out_dir, rmd_files)
        r_files = gsub(pattern = "Rmd", replacement = "R", r_files)
        for(i in seq_along(rmd_files)) {
                knitr::purl(input = rmd_files[i], output = r_files[i])
        }
}

# Generate a data frame of book statistics per chapter
generate_book_stats = function(dir = ".") {
        rmd_files = list.files(path = dir, pattern = ".Rmd")
        chapters = lapply(rmd_files, readLines)
        chapters = lapply(chapters, function(x) tibble::tibble(line = 1:length(x), text = x))
        tidytext::unnest_tokens(chapters[[1]], words, text)
        n_words = sapply(chapters, function(x) nrow(tidytext::unnest_tokens(x, words, text)))
        chapter = 1:length(n_words)
        date = Sys.Date()
        tibble::tibble(n_words, chapter, date)
}
