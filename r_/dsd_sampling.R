#' dsd_sampling
#'
#' @description \code{dsd_sampling} samples from fixed size determinantal sampling designs.
#'
#' @param v a matrix. See 'Details.'
#' @param s a positive number, the number of samples to take.
#' @param B logical indicating which model of vector should be returned. See 'Value'
#' @param C a logical vector of length \code{n} (the number of elements sampled), indicating for each of the n draw if the probabilities for the next draw should be plotted. See 'Details.'
#' @param seed a single value, interpreted as an integer, or NULL. See ‘Details’.
#'
#' @details
#' The sampling design is described by \code{v}, a matrix of size \code{Nxn} (where \code{N} is the number of elements to choose from and \code{n} the size of the sample) such that \code{vv*} is the kernel matrix of your sampling design. Two functions of this package provides such matrices. The function pgd provides real matrices with a vector of first order inclusion probabilities as only argument. The function \code{periodic_dsd} provides complex matrices with fixed size, equal first order probabilities, that exhibit some periodic behavior. Both models suit the function. See the examples.
#' 
#' If \code{s = 1}, the function returns a vector of length \code{n} of elements sampled.
#'
#' If \code{s > 1}, the functions returns a dataframe of s columns in which the ith column contains the ith sample.
#'
#' For \code{dsd_sampling}, the default for \code{s} is \code{1}.
#' 
#' If the user wants to follow the evolution of the probabilities of each element to be drawn at the next step of the sampling selection, the input C is there for. This vector of boolean must be of length n and the ith element indicates if the probabilities after the selection of the 10th element of the sampling should be plotted (C\[11]=TRUE) or not (C\[11]=FALSE). By default, C is full of FALSE.
#'
#' The function let also the possibility to the user to initialize the random number generator with a \code{seed}. If the user enters two times the same \code{seed} for a same matrix \code{v}, \code{dsd_sampling} will return the same sampling both times.
#'
#' @details See the vignette of the package for more information.
#'
#' @return For \code{B = TRUE}, a vector of ones and zeros of length \code{N} (the number of elements to choose from), where ones indicate the elements drawn.
#' @return For \code{B = FALSE}, a vector of length \code{n} (the number of elements sampled) with elements drawn.
#'
#' @export
#'
#' @importFrom stats runif
#' @import ggplot2
#' @importFrom rlang abort
#'
#' @examples
#' #dsd_sampling is suited to the output of the two other functions of the package.
#' V <- pgd(c(0.5, 0.75, 0.75, 0.2, 0.4, 0.6, 0.8))
#' Vc <- periodic_dsd(15, 1, 365)
#' #These matrices are examples of input for the function dsd_sampling.
#' 
#' 
#' #dsd_sampling used with a V matrix
#' dsd_sampling(V)
#' #returns a vector of 4 elements sampled from 1:7.
#'
#'
#' #several samples drawn with the input s
#' dsd_sampling(Vc, s = 5)
#' #returns a dataframe with 5 columns of 4 elements sampled from 1:7.
#'
#'
#' #first type of output: vector of zeros and ones
#' dsd_sampling(V, B = TRUE)
#' #returns a vector of zeros and ones.
#'
#'
#' #second type of output (default output): vector of elements sampled
#' dsd_sampling(V, B = FALSE)
#' #returns a vector of the elements sampled.
#'
#'
#' #dsd_sampling can also be used with complex matrices of the function periodic_dsd
#' dsd_sampling(Vc)
#'
#'
#' #to obtain the same results for several samplings, dsd_sampling proposes to fix a seed.
#' dsd_sampling(V, seed = 1)
#' #will give the same result everytime it is executed.
#' 
#' @references LOONIS, V. and MARY, X. Determinantal sampling designs. Journal of Statistical Planning and Inference, 2019, vol. 199, p. 60-88.
#' @references Lavancier, F., Møller, J., and Rubak, E., Determinantal point process models and statistical inference. Journal of the Royal Statistical Society: Series B (Statistical Methodology), 2015, 77(4):853–877.
#'
#' @seealso \link{detSampling}, \link{pgd} and \link{periodic_dsd}.
#'
dsd_sampling <- function(v, s = 1, B = FALSE, C = rep(FALSE, 5000), seed = NULL){
  
  if (length(C) < ncol(v)) {
    rlang::abort("Length of the vector C is too small. There are more draws than logicals in C indicating if their probabilities should be plotted or not.")
  }

  
  if (is.numeric(v)) {
    return(.dsd_sampling_mult(v, s, B, C, seed))
  }
  else{ return(.dsd_sampling_mult_complex(v, s, B, C, seed))}
}














#' .dsd_sampling_mult_complex
#'
#' This function is called by \code{dsd_sampling}.
#'
#' @param v a matrix.
#' @param s a positive number, the number of samples to take.
#' @param B logical indicating which model of vector should be returned.
#' @param C a logical vector of length \code{n} (the number of elements sampled and the number of columns of v), indicating for each draw if the probability weights for the next draw should be plotted.
#' @param seed a single value, interpreted as an integer, or NULL. See ‘Details’.
#'
#' @export
#'
#' @return s samples from DSD(vv*)
#'

.dsd_sampling_mult_complex <- function(v, s, B, C, seed){

  if (s == 1) {
    return(.dsd_sampling_01_B_C_complex(v, B, C, seed))
  }

  else{
    echant <- replicate(s, .dsd_sampling_01_B_C_complex(v, B, C, seed))
    colnames(echant) <- paste("Sample", 1:s)
    return(echant)
  }
}














#' .dsd_sampling_mult
#'
#' @param v a real matrix.
#' @param s a positive number, the number of samples to take.
#' @param B logical indicating which model of vector should be returned.
#' @param C a logical vector of length \code{n} (the number of elements sampled and the number of columns of v), indicating for each draw if the probability weights for the next draw should be plotted.
#' @param seed a single value, interpreted as an integer, or NULL. See ‘Details’.
#'
#' @export
#'
#' @return s samples from DSD(vv*)
#'
.dsd_sampling_mult <- function(v = NULL, s, B, C, seed){

  if (s == 1) {
    return(.dsd_sampling_01_B_C(v, B, C, seed))
  }
  else{
    echant <- replicate(s, .dsd_sampling_01_B_C(v, B, C, seed))
    colnames(echant) <- paste("Sample", 1:s)
    return(echant)
  }
}














#' .dsd_sampling_01_B_C_complex
#'
#' This function is called by \code{.dsd_sampling_mult_complex}.
#'
#' @param v a matrix.
#' @param B logical indicating which model of vector should be returned.
#' @param C a logical vector of length \code{n} (the number of elements sampled and the number of columns of v), indicating for each draw if the probability weights for the next draw should be plotted.
#' @param seed a single value, interpreted as an integer, or NULL. See ‘Details’.
#'
#' @export
#'
#' @return A sample from DSD(vv*)

.dsd_sampling_01_B_C_complex <- function(v, B = TRUE, C = rep(FALSE, nrow(v)), seed){

  indices <- .data <- NULL

  N <- nrow(v)
  n <- ncol(v)
  echant <- rep(0, N)

  if (!is.null(seed)) {
    set.seed(seed)
  }
  ref <- stats::runif(n)
  
  #Step 1: Sampling the first element
  w <- v

  total <- 0
  i <- 0
  pi1 <- Re( diag( v %*% t(Conj(v)) ) )
  
  if (length(pi1[pi1 < 0]) != 0 | length(pi1[pi1 >= 1]) != 0) {
    rlang::abort("The matrix v given as input doesn't suit to the input expected (See the functions pgd and periodic_dsd)")
  }
  
  while (total < ref[1]) {
    i <- i + 1
    total <- total + ( pi1[i] / n )
  }
  echant[i] <- 1


  #Graphic representation -------------------------


  if (C[1]) {

    pin <- pi1 / n
    d <- data.frame(c(1:N), pin)
    colnames(d)[1] <- "indices"

    p <- ggplot2::ggplot(data = d, aes(x = indices))
    print(p +
            ggplot2::geom_point (aes(y = .data$pin), colour = "#999999") +
            ggplot2::geom_area(aes(y = .data$pin), colour = "#999999", fill = "#999999", alpha = 0.8) +
            ggplot2::geom_vline(xintercept = i) +
            ggplot2::theme_bw() +
            ggplot2::ylab("Pik,n") +
            ggplot2::xlab("k in U") +
            ggplot2::ggtitle(paste("Inclusion probability weights at 1st draw")))
    #----------------------------------------------------

  }
  else {
    d <- c()
  }

  M <- v[i,]
  e1 <- M / c(Re (sqrt (t(M) %*% Conj(M)) ) )


  #Step 2: Sampling the n-1 others elements
  for (j in 1:(n-1)) {

    r <- n-j
    inter <- v %*% Conj(e1)
    pi1 <- pi1 - t(inter * Conj(inter))
    pi2 <- Re( 1 / r*pi1 )

    
    total <- 0
    i <- 0

    while (total < ref[j+1]) {
      i <- i + 1
      total <- total + pi2[i]
    }
    echant[i] <- 1


    #Graphic representation -----------------


    if (C[j+1]) {

      pk <- t(pi2)

      if(length(d) != 0){
        d <- cbind(d, pk)
        l <- length(d)
      }

      else{
        d <- data.frame(c(1:N), pk)
        colnames(d)[1] <- "indices"
        l <- 2
      }

      colnames(d)[l] <- paste("pi",r)

      p <- ggplot2::ggplot(data = d, aes(x = indices))
      print(p +
              ggplot2::geom_point (aes(y = d[[l]]), colour = "#999999") +
              ggplot2::geom_area(aes(y = d[[l]]), colour = "#999999", fill = "#999999", alpha = 0.8) +
              ggplot2::geom_vline(xintercept = i) +
              ggplot2::theme_bw() +
              ggplot2::ylab(paste("Pik,",r)) +
              ggplot2::xlab("k in U") +
              ggplot2::ggtitle(paste("Inclusion probability weights at",j+1 ,"th draw")))
      #------------------------------------------
    }

    w <- w - t( t(Conj(e1)) %*% t(w) ) %*% t(e1)
    L <- w[i, ]
    e1 <- L / c(Re(sqrt (t(L) %*% Conj(L) )))

  }
  
  if(B) {
    return(echant)
  }
  else {
    return((1:N)[echant==1])
  }

}














#' .dsd_sampling_01_B_C
#'
#' This function is called by \code{.dsd_sampling_mult}.
#'
#' @param v a real matrix.
#' @param B logical indicating which model of vector should be returned.
#' @param C a logical vector of length \code{n} (the number of elements sampled and the number of columns of v), indicating for each draw if the probability weights for the next draw should be plotted.
#' @param seed a single value, interpreted as an integer, or NULL. See ‘Details’.
#'
#' @export
#'
#' @return A sample from DSD(vv*)
#'
.dsd_sampling_01_B_C <- function(v = NULL, B = TRUE, C = rep(FALSE, nrow(v)), seed){

  indices <- .data <- NULL

  N <- nrow(v)
  n <- ncol(v)
  echant <- rep(0, N)
  
  if (!is.null(seed)) {
    set.seed(seed)
  }
  ref <- stats::runif(n)

  #First step: Sampling the first element
  w <- v

  
  total <- 0
  i <- 0
  pi1 <- diag(v  %*% t(v))

  while (total < ref[1]) {
    i <- i + 1
    total <- total + ( pi1[i] / n )
  }
  echant[i] <- 1


  #Graphical representation -------------------------


  if (C[1]) {

    pin <- pi1 / n
    d <- data.frame(c(1:N), pin)
    colnames(d)[1] <- "indices"

    p <- ggplot2::ggplot(data = d, aes(x = indices))
    print(p +
            ggplot2::geom_point (aes(y = .data$pin), colour = "#999999") +
            ggplot2::geom_area(aes(y = .data$pin), colour = "#999999", fill = "#999999", alpha = 0.8) +
            ggplot2::geom_vline(xintercept = i) +
            ggplot2::theme_bw() +
            ggplot2::ylab("Pik,n") +
            ggplot2::xlab("k in U") +
            ggplot2::ggtitle(paste("Inclusion probability weights at 1st draw")))
    #----------------------------------------------------

  }
  else{
    d <- c()
  }

  l <- v[i,]
  e1 <- l / as.numeric( sqrt( t(l) %*% l ) )


  #Step 2: Sampling the n-1 others elements
  for (j in 1:(n-1)) {

    r <- n-j
    inter <- (v %*% e1)
    pi1 <- pi1 - t( inter * inter )
    pi2 <- 1 / r * pi1

    
    total <- 0
    i <- 0

    while (total < ref[j+1]) {
      i <- i + 1
      total <- total + pi2[i]
    }
    echant[i] <- 1


    #Graphic representation -----------------


    if (C[j+1]) {

      pk <- t(pi2)

      if (length(d) != 0) {
        d <- cbind(d, pk)
        l <- length(d)
      }

      else{
        d <- data.frame(c(1:N), pk)
        colnames(d)[1] <- "indices"
        l <- 2
      }

      colnames(d)[l] <- paste("pi",r)

      p <- ggplot2::ggplot(data = d, aes(x = indices))
      print(p +
              ggplot2::geom_point (aes(y = d[[l]]), colour = "#999999") +
              ggplot2::geom_area(aes(y = d[[l]]), colour = "#999999", fill = "#999999", alpha = 0.8) +
              ggplot2::geom_vline(xintercept = i) +
              ggplot2::theme_bw() +
              ggplot2::ylab(paste("Pik,",r)) +
              ggplot2::xlab("k in U") +
              ggplot2::ggtitle(paste("Inclusion probability weights at ",j+1 ,"th draw")))
      #------------------------------------------
    }

    w <- w - (w %*% e1) %*% t(e1)
    L <- w[i,]
    e1 <- L / as.numeric( sqrt( t(L) %*% L ))

  }
  if(B) {
    return(echant)
  }
  else {
    return((1:N)[echant==1])
  }

}


