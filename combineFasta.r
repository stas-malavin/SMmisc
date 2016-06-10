combineFasta <- function(files = choose.files(), out)
{
  if (missing(out)) stop('Missing output file!')
  if (file.exists(out)) stop('Output file exists!')
  for (file in files) {
    f <- readLines(file)
    write(f, file = out, append = T)
  }
  cat('\nFile',
      if (out==basename(out)) file.path(getwd(), out) else out,
      'successfuly written')
}