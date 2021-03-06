setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source('../h2o-runit.R')

test.PCA.australia <- function(conn) {
  Log.info("Importing AustraliaCoast.csv data...\n")
  australia.data = read.csv(locate("smalldata/pca_test/AustraliaCoast.csv"), header = TRUE)
  australia.hex = h2o.importFile(conn, locate( "smalldata/pca_test/AustraliaCoast.csv",))
  australia.sum = summary(australia.hex)
  print(australia.sum)
  
  Log.info("H2O PCA on Australia coastline data:\n")
  australia.pca = h2o.prcomp(australia.hex, center = TRUE, scale. = TRUE)

  Log.info("H2O PCA on Australia coastline data returning a maximum of 2 components:\n")
  australia.pca2 = h2o.prcomp(australia.hex, k = 2, center = TRUE, scale. = TRUE)
  
  expect_equal(ncol(australia.pca@model$eigenvectors), 8)
  expect_equal(ncol(australia.pca2@model$eigenvectors), 2)
  testEnd()
}

doTest("PCA: Australia Data", test.PCA.australia)

