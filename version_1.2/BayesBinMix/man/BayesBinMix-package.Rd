\name{BayesBinMix-package}
\alias{BayesBinMix-package}
\alias{BayesBinMix}
\docType{package}
\title{
Bayesian Estimation of Mixtures of Multivariate Bernoulli Distributions
}
\description{
Fully Bayesian inference for estimating the number of clusters and related parameters to heterogeneous binary data.
}
\details{

This package can be used in order to cluster multivariate binary data. The main function of the package is \code{\link{coupledMetropolis}}.

The input is an \eqn{n \times d} binary array where \eqn{n} and \eqn{d} denote the number of observations and dimension of the data. The underlying model is a mixture of independent multivariate Bernoulli distributions with an unknown number of components:
\deqn{x_i\sim\sum_{k=1}^{K}\pi_k\prod_{j=1}^{d}f(x_{ij};\theta_{kj}),}
with \eqn{x_i = (x_{i1},\ldots,x_{id})}; \eqn{d>1}, independent for \eqn{i = 1,\ldots,n}. The term \eqn{f(x_{ij};\theta_{kj})} denotes the probability density function of the Bernoulli distribution with parameter \eqn{\theta_{kj}\in(0,1)}. The number of clusters \eqn{K} is a random variable with support \eqn{\{1,\ldots,K_{\mbox{max}}\}}, where \eqn{K_{max}} is an upper bound for the number of clusters. The model uses the following prior assumptions:
\deqn{K\sim \mbox{discrete}\{1,\ldots,K_{\mbox{max}}\}}
\deqn{(\pi_1,\ldots,\pi_K)|K \sim \mbox{Dirichlet}(\gamma,\ldots,\gamma)}
\deqn{\theta_{kj}|K \sim \mbox{Beta}(\alpha,\beta);\quad \mbox{independent for}\quad k = 1,\ldots,K; j =1,\ldots,d.}
The discrete distribution on the number of clusters it can be a truncated Poisson(1) or Uniform distribution. The model uses data augmentation by also considering the (latent) allocation variable \eqn{z_i}, which a priori assigns observation \eqn{i} to cluster \eqn{k = 1,\ldots,K} with probability \eqn{P(z_i = k|K, \pi_1,\ldots,\pi_K) = \pi_k} independently for \eqn{i=1,\ldots,n}.

In order to infer the parameters of the model, a Markov chain Monte Carlo (MCMC) approach is adopted. Given \eqn{K}, the component-specific parameters \eqn{\pi_k} and \eqn{\theta_{kj}} are integrated out and a collapsed allocation sampler which also updates the number of clusters (Nobile and Fearnside, 2007) is implemented. In order to improve the mixing of the simulated chain, a Metropolis-coupled MCMC sampler (Altekar et al., 2004) is incorporated. In particular, various heated chains are run in parallel and swaps are proposed between pairs of chains. The number of chains should be equal to the number of available cores. Each chain runs in parallel using the packages \code{foreach} and \code{doParallel}. 

After inferring the most probable number of clusters, the simulated parameters which correspond to this specific value of \eqn{K} are post-processed in order to undo the label switching problem. For this purpose the \code{label.switching} package (Papastamoulis, 2016; see also Papastamoulis and Iliopoulos 2010, 2013 and Papastamoulis, 2014) is used.
}
\author{
Panagiotis Papastamoulis

Maintainer: Panagiotis Papastamoulis
}
\references{
Altekar G, Dwarkadas S, Huelsenbeck JP, Ronquist F. (2004): Parallel Metropolis coupled Markov chain Monte Carlo for Bayesian phylogenetic inference. Bioinformatics 20(3): 407-415.

Nobile A and Fearnside A (2007): Bayesian finite mixtures with an unknown number of components: The allocation sampler. Statistics and Computing, 17(2): 147-162.

Papastamoulis P. and Iliopoulos G. (2010). An artificial allocations based solution to the label switching problem in Bayesian analysis of mixtures of distributions. Journal of Computational and Graphical Statistics, 19: 313-331.

Papastamoulis P. and Iliopoulos G. (2013). On the convergence rate of Random Permutation Sampler and ECR algorithm in missing data models. Methodology and Computing in Applied Probability, 15(2): 293-304.

Papastamoulis P. (2014). Handling the label switching problem in latent class models via the ECR algorithm. Communications in Statistics, Simulation and Computation, 43(4): 913-927.

Papastamoulis P (2016): label.switching: An R package for dealing with the label switching problem in MCMC outputs. Journal of Statistical Software, 69(1): 1-24.
}
\keyword{ package }
\seealso{
\code{\link{coupledMetropolis}}
}

