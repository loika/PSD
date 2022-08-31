source("pgd.R")


Cuta<-function(Pi,w=1/Pi,X,R,K=pgd(Pi,TRUE)){
  
  C<-C(K,X,w)
  N<- length(Pi)
  for(r in 1:R){
    K_prev=K
    for (k in 1:(N-1)){
      flag=0
      for (l in (k+1):N){
        dif<- K[k,k]-K[l,l]
        if (dif!=0){
          
          t<-2*Re(K[k,l])/dif
          cosinus<- 1/sqrt(1+t^2)
          sinus<- t*cosinus
          
          W<- diag(N)
          W[k,k]<- cosinus
          W[l,l]<- cosinus
          W[k,l]<- sinus
          W[l,k]<- -sinus
          
          
          K_next=W%*%K%*%t(W)
          new_C=C(K_next,X,w)
          if (new_C<C){
            K=K_next
            C=new_C
          }
          
        }
        
        
        else{
          
          flag=flag+1
        }
        
      }
      
      if(flag==N-k){
        
        break
      }
      
    }
    if(identical(K_prev,K)){
      break
    }
    
  }
  
  return(K)
  
}




C <-function(K,X,w){
  Q<- ncol(X)
  I<- diag(nrow(K))
  result<-0
  Pi=diag(K)
  
  if(prod(w==1/Pi)==1){
    
  for (k in 1:Q){
    z<- round(X[,k]*w,7)
    result<- result+round((t(z)%*%((I-K)*Conj(K))%*%z),7)+round(sum((K*I)%*%z-X[,k])^2,7)
    print("dam")
    }
  }
  
  
  else{
    for (k in 1:Q){
      
      z<- round(X[,k]*w,7)
      result<- result+round((t(z)%*%((I-K)*Conj(K))%*%z),7)
      
    }
  }
  
  return (result)
  
}


#example

Cuta(Pi=c(1/2,3/4,3/4,1/5,2/5,3/5,4/5),X=diag(7),R=5)

