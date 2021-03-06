% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main_functions.R
\name{sgsl}
\alias{sgsl}
\title{Fit the sparse group-subgroup lasso (SGSL)}
\usage{
sgsl(
  x,
  y,
  type = c("lasso", "group", "ggroup", "ggroupind", "sgsl")[1],
  index.subgroup,
  tau = 0.94,
  alpha1 = 0.05,
  alpha2 = 0.2,
  alpha3 = 0.1,
  cv.criterion = FALSE,
  nlam = 100,
  delta = 2,
  delta.group = 2,
  delta.subgroup = 2,
  delta.ind = 2,
  standardize = TRUE
)
}
\arguments{
\item{x}{p by N matrix of predictors (N: sample size, p: number of predictors)}

\item{y}{1 by N matrix of response variable}

\item{type}{One of "lasso" (for the standard lasso), "group" (for the group lasso), "ggroup" (for the group lasso among subgroups), "ggroupind" (for the lasso with individual features), "sgsl" (for the sparse-group-subgroup lasso) or "groupsgl (for the sparse group lasso at subgroup level).}

\item{index.subgroup}{index for subgroups}

\item{tau}{multiplier for using a multiplicative grid for penalty parameter lambda, starting at maximal lambda value}

\item{alpha1}{REgularization parameter.}

\item{alpha2}{regularization parameter.}

\item{alpha3}{regularization parameter.}

\item{cv.criterion}{logical indicator.}

\item{nlam}{number of lambda values.}

\item{delta}{Among the lasso solution path, the best descriptive model is the one which minimizes the loss function: (residual sum of squares)/(estimator of the model error variance) - (sample size) + delta*(number of predictors in the selected model). If delta = 2, this loss function is Mallows' Cp.}

\item{delta.group}{delta applied to C_p criterion for group lasso}

\item{delta.subgroup}{delta applied to C_p critierian for group lasso among subgroups}

\item{delta.ind}{delta applied to C_p criterion for lasso with individual features}

\item{standardize}{logical. TRUE for standardizing the data.}
}
\value{
out: indicators of the selected predictors. 1 for selected predictors and 0 for not selected predictors
}
\description{
Fit the sparse group-subgroup lasso (SGSL)
}
\examples{
set.seed(1)
N=30;
L=10;
p.in.group =8;
p=L * p.in.group;
sigma <- sqrt(1);
beta.coef <- matrix(0,nrow=2*L,ncol=(p/L)/2)
beta.coef[1,] <- c(6,6.4,6.6,8)/2
beta.coef[2,] <- c(6,6.4,6.6,8)/2
beta.coef[3,] <- c(6,6.6,6.6,8)/2
beta.coef[5,] <- c(12.5,12.5,0,0)/2
beta.coef <- beta.coef *2
p.group <- rep(p/L,L)
index.subgroup <- matrix(NA,nrow=L,ncol=p)
tmp <- 0
for(k in 1:L){
if(k==1){
index.subgroup[k,1:p.group[k]] <- c(rep(1,(p/L)/2),rep(2,(p/L)/2))
} else {
ind <- 1:p.group[k] + sum(p.group[(k-1):1])
index.subgroup[k,ind] <- c(rep(k+tmp,(p/L)/2),rep(k+tmp+1,(p/L)/2))
}
tmp <- tmp + 1
}
out <- data.group(N,p.group,beta.coef,sigma)
y <- out$y
x <- out$X
out_lasso <- sgsl(x,y,type="lasso",index.subgroup = index.subgroup)
out_group <- sgsl(x,y,type="group",index.subgroup = index.subgroup,tau=0.94)
out_ggroup <- sgsl(x,y,type="ggroup",index.subgroup = index.subgroup,tau=0.94)
out_ggroupind <- sgsl(x,y,type="ggroupind",index.subgroup = index.subgroup,tau=0.94)
out_sgsl <- sgsl(x,y,type="sgsl",index.subgroup=index.subgroup,tau=0.94)
}
