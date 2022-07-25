function W = completed_W(W,t,l,k)
    cos_theta = 1/sqrt(1+t*t);
    sin_theta = t *  cos_theta;
    W(l,l) = cos_theta;
    W(k,k) = cos_theta;
    W(l,k) = sin_theta;
    W(k,l) = -sin_theta;
end