spec<- function(omega,M,pi,spectre=100){
  n=sum(pi)
  N=length(pi)
  mat_spectre=matrix(0,M,N)
  pi_up=pi[order(pi)]
  pi_down=pi[order(pi, decreasing = TRUE)]
  
  if (spectre[1]==100){
    spectre=c()
    cumsum_1=0
    lambda=1
    for(j in 1:M){
      A=0
      B=min(lambda,n-cumsum_1)
      if(M>j){
      for(i in 1:(M-j)){
        A=max(A,sum(pi_down[1:(i+j-1)],-cumsum_1)/i)
      }
      }
      A=max(A,(n-cumsum_1)/(M-j+1))
      spectre[j]=A+omega[j,N]*(B-A)
      lambda=spectre[j]
      cumsum_1=cumsum_1+spectre[j]
      
    }
  }
  
  mat_spectre[,N]=rev(spectre)
  for (k in (N-1):1){
    start=max(1,M-k+1)
    lambda1=mat_spectre[,k+1]
    lambda2=mat_spectre[,k]
    for(j in start:M){
      
      A=max(0,lambda1[j-1],sum(lambda1[1:j])-sum(lambda2[0:(j-1)])-pi_down[k+1])
      B_1=c()
      ind=0
      for (i in j:M){
        ind=ind+1
        prem=0
        deux=0
        trois=lambda2[0:(j-1)]
        if ((M-i+1)<=k){
          prem=pi_down[(M-i+1):k]
          
        }
        if (j<=(i-1)){
          deux=lambda1[j:(i-1)]
        }
        B_1[ind]=sum(prem,-deux,-trois)
      }
      B=min(lambda1[j],min(B_1 ))
      mat_spectre[j,k]=A+omega[j,k]*(B-A)
      lambda2[j]=mat_spectre[j,k]
    }
  }
  
  return(mat_spectre)
  
}






#programme fickus

fickus <- function(omega=matrix(0.5,M,length(pi)),rho=matrix(0.5,M,length(pi)-1),M=round(sum(pi),7),pi,spectre=100,U=diag(M),option=TRUE){
  
  
  if (as.integer(M)!=M) {
    rlang::abort("M should be an integer")
  }
  N=length(pi)
  rho=round(rho*3.141593,7)
  mat_spectre=round(spec(omega,M,pi,spectre),7)
  print(mat_spectre)
  pi_up=pi[order(pi)]
  pi_down=pi[order(pi, decreasing = TRUE)]
  phi=round(sqrt(pi_down[1])*U[,1],7)
  ens=1:M
  for (k in 2:N){
    
    V=diag(complex(argument = rho[,k-1],modulus = 1))
    lambda1=mat_spectre[,k]
    lambda2=mat_spectre[,k-1]
    E1=ens
    E2=ens
    for (j in ens){
      if(lambda2[j] %in% lambda1[E1]){
        E2=E2[((E2)!=j)]
        E1=E1[-match(lambda2[j],lambda1[E1])]
      }
    }
    
    E1_=M+1-E1
    E2_=M+1-E2
    r=length(E1)
    E1_c=c()
    E2_c=c()
    
    if (r!=M){
      E1_c=ens[!ens %in% E1_]
      E2_c=ens[!ens %in% E2_]
      
      E1_=c(E1_[order(E1_)],E1_c[order(E1_c)])
      E2_=c(E2_[order(E2_)],E2_c[order(E2_c)])
      
      sigma1=diag(M)[E1_,]
      sigma2=diag(M)[E2_,]
    }
    else{
      
      sigma1=diag(M)
      sigma2=diag(M)
    }

    if(r!=0){
    
    R=diag(r)[r:1,]%*%cbind(lambda2[E2],lambda1[E1])
    
    
    v=c()
    w=c()
    
    for (i in 1:r){
      v_1=R[i,1]-R[,2]
      v_2=R[i,1]-R[,1]
      v_2[i]=1
      v_1=v_1[order(abs(v_1))]
      v_2=v_2[order(abs(v_2))]
      v[i]=round(sqrt(-prod(v_1/v_2)),7)
      
      w_1=R[i,2]-R[,1]
      w_2=R[i,2]-R[,2]
      w_2[i]=1
      w_1=w_1[order(abs(w_1))]
      w_2=w_2[order(abs(w_2))]
      w[i]=round(sqrt(prod(w_1/w_2)),7)
      
      
    }
    
    vect=matrix(0,M,1)
    vect[1:r]=v
    W=(1/(t(matrix(R[,2],r,r))-matrix(R[,1],r,r)))*(v%*%t(w))
    phi=cbind(phi,U%*%V%*%t(sigma2)%*%vect)
    mat1=cbind(W,matrix(0,r,M-r))
    mat2=cbind(matrix(0,M-r,r),diag(M-r))
    U=U%*%V%*%t(sigma2)%*%rbind(mat1,mat2)%*%sigma1
    
    }
  }
  
  if (option ==TRUE){
    
    K=round(t(Conj(phi))%*%phi,7)
    list_data=list(K,mat_spectre)
    names(list_data)=c("K","spectre")
    return(list_data)
    
  }
  
  else{
    list_data=list(phi,mat_spectre)
    names(list_data)=c("phi","spectre")
    return(list_data)
  }
  
  
  
}






#Exemples


omega=matrix(1,4,10)
omega[,10]=matrix(0.5,4,1)
m_pi=c()
for (k in 1:10){
  m_pi[k]=6*(11-k)/110
}

K=fickus(omega,M=4,pi=m_pi)
print(K)
