\name{collapsedGibbsBinMix}
\alias{collapsedGibbsBinMix}
\title{
collapsed Gibbs sampler
}
\description{
This function applied collapsed Gibbs sampling assuming that the number of mixture components is known.
}
\usage{
collapsedGibbsBinMix(alpha, beta, gamma, K, m, burn, 
	data, thinning, z.true, outputDir)
}
\arguments{
  \item{alpha}{
First shape parameter of the Beta prior distribution (strictly positive). Defaults to 1.
}
  \item{beta}{
Second shape parameter of the Beta prior distribution (strictly positive).  Defaults to 1.
}
  \item{gamma}{
\code{K}-dimensional vector (positive) corresponding to the parameters of the Dirichlet prior of the mixture weights. Default value: \code{rep(1,K)}.
}
  \item{K}{
Number of clusters.
}
  \item{m}{
Number of MCMC iterations.
}
  \item{burn}{
The number of initial MCMC iterations that will be discarded as burn-in period.
}
  \item{data}{
Binary data array.
}
  \item{thinning}{
Integer that defines a thinning of the reported MCMC sample. Under the default setting, every 5th MCMC iteration is saved.
}
  \item{z.true}{
An optional vector of cluster assignments considered as the ground-truth clustering of the observations. Useful for simulations.
}
  \item{outputDir}{
The name of the produced output folder. 
}
}
\author{
Panagiotis Papastamoulis
}
\note{
Not really used.
}
