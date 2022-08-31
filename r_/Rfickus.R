source("fickus.R")



 cnorm<-function(x){
   
   return(sqrt(sum(Re(t(Conj(x))%*%x))))
 }
 

  
 
 
 Rfickus<-function(K){
   
   n=Re(sum(diag(K)))
   pi_up=Re(diag(K)[order(diag(K))])
   Pi=Re(diag(K)[order(diag(K), decreasing = TRUE)])
   N=length(Pi)
   spectre=eigen(K)$values
   M=match(0,round(spectre,1))-1
   if(is.na(M)){
     M=N
   }
   psi=Conj(t(eigen(K)$vectors))[1:M,]
   U=matrix(psi[,1]/Pi[1])
   Y=matrix(runif(M*(M-1),0,1000),M,M-1)
   U_chap=matrix(0,M,M)
   omega=matrix(0,M,N)
   rho=matrix(0,M,N-1)
   for (j in 2:M){
     vect=(diag(M)-U%*%diag(1/diag(t(Conj(U))%*%U),j-1)%*%t(Conj(U)))%*%Y[,j-1]
     U=cbind(U,vect)
   }
   U=t(t(U)/sqrt(Re(colSums(Conj(U)*U))))
   
   
   lambda1=matrix(0,M,1)
   lambda1[M]=K[1,1]
   mat_spectre=lambda1
   for (k in 2:N){
     U_chap=matrix(0,M,M)
     mat=psi[,1:(k-1)]%*%t(Conj(psi[,1:(k-1)]))
     vp=eigen(mat)$vect
     spectre=rev(lambda1)
     lambda2=lambda1
     occ=tabulate(match(spectre,unique(spectre)))
     spectre=unique(spectre)
     r=length(spectre)
     pos=1
     vect=matrix(rnorm(M),M,1)
     for (i in  1:r){
     prev_pos=pos
     pos=pos+occ[i]
     P=vp[,prev_pos:(pos-1)]
     Z=(P%*%t(Conj(P)))%*%psi[,k]
     if(prod(round(Z,7)==0)==1){
       Z=(P%*%t(Conj(P)))%*%matrix(rnorm(M),M,1)
     }
     U_chap[,prev_pos]=Z/cnorm(Z)
     if(occ[i]>1){
       if(pos<=M){
        X=cbind(U_chap[,0:(prev_pos-1)],U[,pos:M])
       }
       else{
         X=U_chap[,0:(prev_pos-1)]
       }
        for (j in 1:(occ[i]-1)){
          X=cbind(U_chap[,(prev_pos+j-1)],X)
          U_chap[,prev_pos+j]=(diag(M)-X%*%solve(t(Conj(X))%*%X)%*%t(Conj(X)))%*%matrix(rnorm(M),M,1)
          U_chap[,prev_pos+j]=U_chap[,prev_pos+j]/cnorm(U_chap[,prev_pos+j])
        }
         
     }
       
     }

     lambda1=matrix(0,M,1)
     lambda1[1:min(k,M)]=eigen(K[1:k,1:k])$value[1:min(k,M)]
     lambda1=round(rev(lambda1),7)
     mat_spectre=cbind(mat_spectre,lambda1)
     ens=1:M
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
    
     
     W=(1/(t(matrix(R[,2],r,r))-matrix(R[,1],r,r)))*(v%*%t(w))
     mat1=cbind(W,matrix(0,r,M-r))
     mat2=cbind(matrix(0,M-r,r),diag(M-r))
     
     V=t(Conj(U))%*%U_chap
     rho[,k-1]=atan(Im(diag(V))/Re(diag(V)))
     U=U%*%V%*%t(sigma2)%*%rbind(mat1,mat2)%*%sigma1
     
   }
   
  
   mat_spectre=Re(mat_spectre)
   spectre=rev(mat_spectre[,N])
   cumsum_1=0
   lambda=1
   for(j in 1:M){
     A=0
     B=min(lambda,n-cumsum_1)
     if(M>j){
     for(i in 1:(M-j)){
       A=max(A,sum(Pi[1:(i+j-1)],-cumsum_1)/i)
     }
     }
     A=max(A,(n-cumsum_1)/(M-j+1))
     if(round(A-B,7)!=0){
     omega[j,N]=(spectre[j]-A)/(B-A)
     }
     lambda=spectre[j]
     cumsum_1=cumsum_1+spectre[j]
     
   }
   
   for (k in (N-1):1){
     
     start=max(1,M-k+1)
     lambda1=mat_spectre[,k+1]
     lambda2=mat_spectre[,k]
     for(j in start:M){
       
       A=max(0,lambda1[j-1],sum(lambda1[1:j])-sum(lambda2[0:(j-1)])-Pi[k+1])
       B_1=c()
       ind=0
       for (i in j:M){
         ind=ind+1
         prem=0
         deux=0
         trois=lambda2[0:(j-1)]
         if ((M-i+1)<=k){
           prem=Pi[(M-i+1):k]
           
         }
         if (j<=(i-1)){
           deux=lambda1[j:(i-1)]
         }
         B_1[ind]=sum(prem,-deux,-trois)
       }
       B=min(lambda1[j],min(B_1 ))
       if(round(A-B,7)!=0){
       omega[j,k]=(mat_spectre[j,k]-A)/(B-A)
       }
     }
   }
   omega=round(omega,7)
   rho=round(rho/3.141593,7)
  list_data=list(omega,rho,mat_spectre)
  names(list_data)=c("omega","rho","spectre")
  return(list_data)
  
 }
 
 

 #Exemples
 
 
 omega=matrix(0.5,7,10)
 rho=matrix(0.25,7,9)
 
 m_pi=c()
 for (k in 1:10){
   m_pi[k]=6*(11-k)/110
 }
 
 fic=fickus(omega,rho,M=7,pi=m_pi)
 
 Rfickus(fic$K)
 