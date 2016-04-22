\name{allocationSamplerBinMix}
\alias{allocationSamplerBinMix}
\title{
The allocation sampler algorithm.
}
\description{
This function implements the collapsed allocation sampler of Nobile and Fearnside (2007) at the context of mixtures of multivariate Bernoulli distributions. 
}
\usage{
allocationSamplerBinMix(Kmax, alpha, beta, gamma, m, burn, data, 
thinning, z.true, ClusterPrior, ejectionAlpha, Kstart, outputDir, 
metropolisMoves, reorderModels, heat, zStart, LS)
}
\arguments{
  \item{Kmax}{
Maximum number of clusters (integer, at least equal to two).
}
  \item{alpha}{
First shape parameter of the Beta prior distribution (strictly positive). Defaults to 1.
}
  \item{beta}{
Second shape parameter of the Beta prior distribution (strictly positive).  Defaults to 1.
}
  \item{gamma}{
\code{Kmax}-dimensional vector (positive) corresponding to the parameters of the Dirichlet prior of the mixture weights. Default value: \code{rep(1,Kmax)}.
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
  \item{ClusterPrior}{
Character string specifying the prior distribution of the number of clusters on the set \eqn{\{1,\ldots,K_{max}\}}. Available options: \code{poisson} or \code{uniform}. It defaults to the truncated Poisson distribution.
}
  \item{ejectionAlpha}{
Probability of ejecting an empty component. Defaults to 0.2.
}
  \item{Kstart}{
Initial value for the number of clusters. Defaults to 1. 
}
  \item{outputDir}{
The name of the produced output folder. 
}
  \item{metropolisMoves}{
A vector of character strings with possible values \code{M1}, \code{M2}, \code{M3}, \code{M4}. Each entry specifies Metropolis-Hastings type moves on the latent allocation variables.
}
  \item{reorderModels}{
Character string specifying whether to post-process the MCMC sample of each distinct generated value of \code{K}. The default setting is \code{onlyMAP} and in this case only the part of the MCMC sample that corresponds to the most probable number of clusters is reordered.
}
  \item{heat}{
The temperature of the simulated chain, that is, a scalar in the set \eqn{(0,1]}.
}
  \item{zStart}{
\eqn{n}-dimensional integer vector of latent allocations to initialize the sampler.
}
  \item{LS}{
Boolean indicating whether to post-process the MCMC sample using the label switching algorithms.
}
}
\details{
The output is reordered according to the following label-switching solving algorithms: ECR, ECR-ITERATIVE-1 and STEPHENS. In most cases the results of these different algorithms are identical. 
}
\references{
Nobile A and Fearnside A (2007): Bayesian finite mixtures with an unknown number of components: The allocation sampler. Statistics and Computing, 17(2): 147-162.

Papastamoulis P (2016): label.switching: An R package for dealing with the label switching problem in MCMC outputs. Journal of Statistical Software, 69(1): 1-24.
}
\author{
Panagiotis Papastamoulis
}
\note{
This function is recursively called inside the \code{\link{coupledMetropolis}} function. 
}
\seealso{
\code{\link{coupledMetropolis}}
}
