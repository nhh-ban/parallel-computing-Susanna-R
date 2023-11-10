# Timer script

# Installing and loading necessary packages
install.packages("tictoc")
library(tictoc)

# Create a function for printing out time results in a data frame:
printTicTocLog <-
  function() {
    tic.log() %>%
      unlist %>%
      tibble(logvals = .) %>%
      separate(logvals,
               sep = ":",
               into = c("Function type", "log")) %>%
      mutate(log = str_trim(log)) %>%
      separate(log,
               sep = " ",
               into = c("Seconds"),
               extra = "drop")
  }

tic.clearlog()

tic("Test")
Sys.sleep(1)
toc(log = TRUE)

printTicTocLog() %>%
  knitr::kable()

# Time method 1 ----------------------------------------------------------------
source("scripts/method_1.R")

tic.clearlog()
tic("Method 1")
df %>%
  ggplot2::ggplot(aes(x = log(N), y = share_reject, col = type)) +
  geom_line() +
  geom_hline(yintercept = 0.05) +
  theme_bw()
toc(log = TRUE)

printTicTocLog() %>%
  knitr::kable()


# Time method 2 ----------------------------------------------------------------
source("scripts/method_2.R")

tic("Method 2")
df %>%
  ggplot2::ggplot(aes(x = log(N), y = share_reject, col = type)) +
  geom_line() +
  geom_hline(yintercept = 0.05) +
  theme_bw()
toc(log = TRUE)

printTicTocLog() %>%
  knitr::kable()


# Time method 3 ----------------------------------------------------------------
source("scripts/method_3.R")

tic("Method 3")
df %>%
  ggplot2::ggplot(aes(x = log(N), y = share_reject, col = type)) +
  geom_line() +
  geom_hline(yintercept = 0.05) +
  theme_bw()
toc(log = TRUE)

printTicTocLog() %>%
  knitr::kable()


# Results ----------------------------------------------------------------------
# The results show that method 2 is the fastest and method 3 is almost as fast.
# Method 1 is the slowest because it only utilizes a single core for its computations,
# while method 2 and 3 use parallel computing to distribute tasks across multiple cores.