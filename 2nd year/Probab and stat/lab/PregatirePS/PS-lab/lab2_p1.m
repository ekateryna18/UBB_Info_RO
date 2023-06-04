function frel=lab2_p1(nrSim = 1000, n = 23)
rez = 0;
for i = 1:nrSim
  if(length(unique(randi(365,1,n))) < n)
    rez++;
    endif
  endfor
  frel = rez/nrSim
end
