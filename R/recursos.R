# Variables accesorias ----
alto <- 100
ptop <- sample(seq(50,700, by=20), 30)
pleft <- sample(seq(100,1350, by=25), 30)
ttext <- '1.2rem'
sample_files <- list.files(
  "www/samples",
  pattern = "\\.(png|jpg|jpeg)$",
  full.names = FALSE
)