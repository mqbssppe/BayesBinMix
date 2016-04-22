\name{coupledMetropolis}
\alias{coupledMetropolis}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Metropolis-coupled Markov chain Monte Carlo sampler
}
\description{
Main function of the package. The algorithm consists of the allocation sampler combined with a MC3 scheme.
}
\usage{
coupledMetropolis(Kmax, nChains, heats, binaryData, outPrefix, ClusterPrior,
	 m, alpha, beta, gamma, z.true, ejectionAlpha)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Kmax}{
Maximum number of clusters (integer, at least equal to two).
}
  \item{nChains}{
Number of parallel (heated) chains. Ideally, it should be equal to the number of available threads. 
}
  \item{heats}{
\code{nChains}-dimensional vector specifying the temperature of each chain: the 1st entry should always be equal to 1 and the rest of them lie on the set: \eqn{(0,1]}.
}
  \item{binaryData}{
The observed binary data (array).
}
  \item{outPrefix}{
The name of the produced output folder. An error is thrown if the directory exists.
}
  \item{ClusterPrior}{
Character string specifying the prior distribution of the number of clusters on the set \eqn{\{1,\ldots,K_{max}\}}. Available options: \code{poisson} or \code{uniform}. It defaults to the truncated Poisson distribution.
}
  \item{m}{
The number of MCMC cycles. At the end of each cycle a swap between a pair of heated chains is attempted. Each cycle consists of 10 iterations.
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
  \item{z.true}{
An optional vector of cluster assignments considered as the ground-truth clustering of the observations. Useful for simulations.
}
  \item{ejectionAlpha}{
Probability of ejecting an empty component. Defaults to 0.2.
}
}
\details{
In the case that the most probable number of clusters is larger than 1, the output is post-processed using the label.switching package. 
}
\value{
The final output is written to the directory \code{outPrefix}. It consists of the following files:
	\item{K.allChains.txt}{
		\code{m}\eqn{\times}\code{nChains} matrix containing the simulated values of the number of clusters (\eqn{K}) per chain.
	}
	\item{K.txt}{
		the \code{m} simulated values of the number of clusters (\eqn{K}) of the cold chain (posterior distribution).
	}
	\item{p.varK.txt}{
		the simulated values of the mixture weights (not identifiable).
	}
	\item{rawMCMC.mapK.KVALUE.txt}{
		the raw MCMC output which corresponds to the most probable model (not identifiable).
	}
	\item{reorderedMCMC-ECR-ITERATIVE1.mapK.KVALUE.txt}{
		the reordered MCMC output which corresponds to the most probable model, reordered according to the \code{ECR-ITERATIVE-1} algorithm.
	}
	\item{reorderedMCMC-ECR.mapK.KVALUE.txt}{
		the reordered MCMC output which corresponds to the most probable model, reordered according to the \code{ECR} algorithm.
	}
	\item{reorderedMCMC-STEPHENS.mapK.KVALUE.txt}{
		the reordered MCMC output which corresponds to the most probable model, reordered according to the \code{STEPHENS} algorithm.
	}
	\item{reorderedSingleBestClusterings.mapK.KVALUE.txt}{
		the most probable allocation of each observation after reordering the MCMC sample which corresponds to the most probable number of clusters.
	}
	\item{theta.varK.txt}{
		the simulated values of Bernoulli parameters (not identifiable).
	}
	\item{z-ECR-ITERATIVE1.mapK.KVALUE.txt}{
		the reordered simulated latent allocations which corresponds to the most probable model, reordered according to the \code{ECR-ITERATIVE-1} algorithm.
	}
	\item{z-ECR.mapK.KVALUE.txt}{
		the reordered simulated latent allocations which corresponds to the most probable model, reordered according to the \code{ECR} algorithm.
	}
	\item{z-KL.mapK.KVALUE.txt}{
		the reordered simulated latent allocations which corresponds to the most probable model, reordered according to the \code{STEPHENS} algorithm.
	}
	\item{z.varK.txt}{
		the simulated latent allocations (not identifiable).
	}
	\item{classificationProbabilities.mapK.KVALUE.csv}{
		the reordered classification probabilities per observation after reordering the most probable number of clusters with the \code{ECR} algorithm.
	}

\code{KVALUE} will be equal to the inferred number of clusters. Note that the label switching part is omitted in case that the most probable number of clusters is equal to 1.

}
\references{
Altekar G, Dwarkadas S, Huelsenbeck JP, Ronquist F. (2004): Parallel Metropolis coupled Markov chain Monte Carlo for Bayesian phylogenetic inference. Bioinformatics 20(3): 407-415.

Nobile A and Fearnside A (2007): Bayesian finite mixtures with an unknown number of components: The allocation sampler. Statistics and Computing, 17(2): 147-162.

Papastamoulis P (2016): label.switching: An R package for dealing with the label switching problem in MCMC outputs. Journal of Statistical Software, 69(1): 1-24.
}
\author{
Panagiotis Papastamoulis
}

\examples{
#generate dataset from a mixture of 2 ten-dimensional Bernoulli distributions.
set.seed(1)
d <- 10 # number of columns
n <- 50 # number of rows (sample size)
K <- 2 	 # true number of clusters
p.true <- myDirichlet(rep(10,K)) # true weight of each cluster
z.true <- numeric(n) # true cluster membership
z.true <- sample(K,n,replace=TRUE,prob = p.true)
theta.true <- array(data = NA, dim = c(K,d)) 	#true probability of positive responses per cluster
for(j in 1:d){
    theta.true[,j] <- rbeta(K, shape1 = 1, shape2 = 1)
}
x <- array(data=NA,dim = c(n,d)) # data: n X d array
for(k in 1:K){
        myIndex <- which(z.true == k)
        for (j in 1:d){
                x[myIndex,j] <- rbinom(n = length(myIndex), size = 1, prob = theta.true[k,j])   
        }
}
#	number of heated paralled chains
nChains <- 2
heats <- seq(1,0.8,length = nChains)
# NOTE: only m = 5 iterations are used here (modify to m = 1000 for non-erroneous results)
coupledMetropolis(Kmax = 10,nChains = nChains,heats =  heats,binaryData = x, 
	outPrefix = 'BayesBinMixExample',ClusterPrior = 'poisson',m = 5)
# it is also advised to use z.true = z.true in order to directly compare with the true values.
# in general it is advised to use at least 4 chains with heats <- seq(1,0.3,length = nChains)



}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
