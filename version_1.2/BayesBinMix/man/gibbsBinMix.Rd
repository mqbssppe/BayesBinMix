\name{gibbsBinMix}
\alias{gibbsBinMix}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Standard Gibbs sampler
}
\description{
This function implements full Gibbs sampling to simulate an MCMC sample from the posterior distribution assuming known number of mixture components.
}
\usage{
gibbsBinMix(alpha, beta, gamma, K, m, burn, data, thinning, z.true, outputDir)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{alpha}{
First shape parameter of the Beta prior distribution (strictly positive). Defaults to 1.
}
  \item{beta}{
Second shape parameter of the Beta prior distribution (strictly positive).  Defaults to 1.
}
  \item{gamma}{
\code{Kmax}-dimensional vector (positive) corresponding to the parameters of the Dirichlet prior of the mixture weights. Default value: \code{rep(1,Kmax)}.
}
  \item{K}{
Number of clusters.
}
  \item{m}{
Number of MCMC iterations.
}
  \item{burn}{
Burn-in period.
}
  \item{data}{
Binary data.
}
  \item{thinning}{
Thinning of the simulated chain.
}
  \item{z.true}{
An optional vector of cluster assignments considered as the ground-truth clustering of the observations. Useful for simulations.
}
  \item{outputDir}{
Output directory.
}
}
\details{
Not really used.
}
\author{
Panagiotis Papastamoulis
}
