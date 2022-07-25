function W = reset_W(W,k,l)
    W(l,l) = 1;
    W(k,k) = 1;
    W(l,k) = 0;
    W(k,l) = 0;
end