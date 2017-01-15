\name{dealWithLabelSwitchingMissing}
\alias{dealWithLabelSwitchingMissing}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Label switching algorithms for the case of missing data
}
\description{
This is a wrapper for the \code{label.switching} package. It is used to post-process the generated MCMC sample in order to undo the label switching problem. This function is called internally to the \code{coupledMetropolis} command.
}
\usage{
dealWithLabelSwitchingMissing(outDir, reorderModels, binaryData, z.true)
}
\arguments{
  \item{outDir}{
The directory where the output of \code{coupledMetropolis} was previously produced.
}
  \item{reorderModels}{
Boolean value indicating whether to reorder the MCMC corresponding to each distinct generated value of number of clusters or not.
}
  \item{binaryData}{
The input data.
}
  \item{z.true}{
An optional vector of cluster assignments considered as the ground-truth clustering of the observations. Useful for simulations.
}
}
\details{
See the \code{label.switching} package.
}
\references{
Papastamoulis P. and Iliopoulos G. (2010). An artificial allocations based solution to the label switching problem in Bayesian analysis of mixtures of distributions. Journal of Computational and Graphical Statistics, 19: 313-331.

Papastamoulis P. and Iliopoulos G. (2013). On the convergence rate of Random Permutation Sampler and ECR algorithm in missing data models. Methodology and Computing in Applied Probability, 15(2): 293-304.

Papastamoulis P. (2014). Handling the label switching problem in latent class models via the ECR algorithm. Communications in Statistics, Simulation and Computation, 43(4): 913-927.

Papastamoulis P (2016): label.switching: An R package for dealing with the label switching problem in MCMC outputs. Journal of Statistical Software, 69(1): 1-24.
}
\author{
Panagiotis Papastamoulis
}
