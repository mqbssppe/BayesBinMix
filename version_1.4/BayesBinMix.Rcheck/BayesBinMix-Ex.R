pkgname <- "BayesBinMix"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "BayesBinMix-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('BayesBinMix')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("coupledMetropolis")
### * coupledMetropolis

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: coupledMetropolis
### Title: Metropolis-coupled Markov chain Monte Carlo sampler
### Aliases: coupledMetropolis

### ** Examples

#generate dataset from a mixture of 2 ten-dimensional Bernoulli distributions.
set.seed(1)
d <- 10 # number of columns
n <- 50 # number of rows (sample size)
K <- 2 	 # true number of clusters
p.true <- myDirichlet(rep(10,K)) # true weight of each cluster
z.true <- numeric(n) # true cluster membership
z.true <- sample(K,n,replace=TRUE,prob = p.true)
#true probability of positive responses per cluster:
theta.true <- array(data = NA, dim = c(K,d)) 
for(j in 1:d){
    theta.true[,j] <- rbeta(K, shape1 = 1, shape2 = 1)
}
x <- array(data=NA,dim = c(n,d)) # data: n X d array
for(k in 1:K){
        myIndex <- which(z.true == k)
        for (j in 1:d){
                x[myIndex,j] <- rbinom(n = length(myIndex), 
			size = 1, prob = theta.true[k,j])   
        }
}
#	number of heated paralled chains
nChains <- 2
heats <- seq(1,0.8,length = nChains)
## Not run: 
##D cm <- coupledMetropolis(Kmax = 10,nChains = nChains,heats =  heats,
##D 	binaryData = x, outPrefix = 'BayesBinMixExample',
##D 	ClusterPrior = 'poisson', m = 1100, burn = 100)
##D #	print summary using:
##D print(cm)
## End(Not run)
# it is also advised to use z.true = z.true in order to directly compare with 
# the true values. In general it is advised to use at least 4 chains with 
#	heats <- seq(1,0.3,length = nChains)






base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("coupledMetropolis", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
