#' pgd
#'
#' @description \code{pgd} constructs a real projection matrix, kernels of fixed size sampling designs with first order inclusion probabilities given by \code{Pi}.
#'
#' @param Pi a vector of first order inclusion probabilities weights.
#' @param K a logical indicating which model of matrix should be returned. See 'Details.'
#'
#' @details It is common in practice to work with fixed size sampling designs with prescribed first order inclusion probabilities. Constructing such a determinantal sampling design is equivalent to constructing a projection matrix with a prescribed diagonal. \code{pgd} constructs this matrix.
#'
#' @details As \code{Pi} is a vector of first order inclusion probabilities, it should be of length N, the number of elements \code{N} the set and should contain only values between 0 and 1 excluded such that the sum of these values is \code{n}, the number of elements to be sampled.
#'
#' @return For \code{K = TRUE}, the kernel matrix of the determinantal sampling design such that the first order inclusion probabilities are the ones given in \code{Pi}.
#' @return For \code{K = FALSE}, the matrix \code{V} such that \code{VV*} is the kernel matrix of the determinantal sampling design such that the first order inclusion probabilities are the ones given in \code{Pi}.
#'
#' @importFrom rlang abort
#'
#' @export
#'
#' @references LOONIS, V. and MARY, X. Determinantal sampling designs. Journal of Statistical Planning and Inference, 2019, vol. 199, p. 60-88.
#'
#' @examples
#' pgd(c(0.5, 0.75, 0.75, 0.2, 0.4, 0.6, 0.8))
#' pgd(c(0.5, 0.75, 0.75, 0.2, 0.4, 0.6, 0.8), TRUE)
#' pgd(rep(36/200, 200))
#'
#' @seealso \link{dsd_sampling} and \link{detSampling}
#'

pgd <- function(Pi, K = FALSE) {
  
  N <- length(Pi)
  
  #SOME ERROR MESSAGES
  if (N < 2) {
    rlang::abort("The sampling designs should be define on a set of more than one element. (length(Pi) > 1)")
  }
  
  for (k in 1:N) {
    if (Pi[k] >= 1 | Pi[k] <= 0) {
      rlang::abort("Pi is not a vector of probabilities (0 <= p < 1)")
    }
  }
  
  if (as.integer(round( sum(Pi) , 9)) - round( sum(Pi) , 9) != 0) {
    rlang::abort("The sum of the first order inclusion probabilities should be an integer")
  }
  
  
  s <- c()
  c <- c()
  kr <- c()
  alpha <-c()
  sum <-0
  r<-1
  r_prev<-0
  
  
  for (k in 1:N) {
    prev_sum<-sum
    sum<-sum+Pi[k]
    if (sum>=r)
    {
      kr[r] <- k
      alpha[k] <-r-prev_sum
      
      int <- sqrt( (1 - Pi[k]) / (1 - alpha[k]) )
      s[k] <- round(int, 8)
      r_prev<-r
      r<-r+1
    }
    
    else {
      inter <- sqrt( Pi[k] / (r_prev + 1 - prev_sum) )
      s[k] <- round(inter, digits = 15)
        }
    
    c[k] <- sqrt(1 - s[k]^2)
    
}

  V <- matrix(0, nrow = N , ncol = r_prev)
  V[1, 1] = 1
  
  if ((r_prev-1) != 0) {
    for (r in 1:(r_prev-1)) {
      V[kr[r] + 1, r + 1] = 1
    }
  }
  
  for (k in 1:(N-1)) {
    L <- V[k, ]
    M <- V[k + 1,]
    V[k, ] <- s[k] * L - c[k] * M
    V[k + 1, ] <- c[k] * L + s[k] * M
  }
  if (!K) {
    return(V)
  }
  else {
    return(V %*% t(V))
  }
  
}


#example
pgd(c(1/2,3/4,3/4,1/5,2/5,3/5,4/5),TRUE)
