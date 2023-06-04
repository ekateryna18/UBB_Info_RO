function prob_unif(n=1000)
  #A
  x=unifrnd(1, 2, 1, n);
  y=unifrnd(-1, 1, 1, n);
  nrA=0;
  nrO=0;
  for i=1:n
    if x(i)>1.5 && y(i)<0.5
      nrA++;
    endif
    if x(i)>1.5 || y(i)<0.5
      nrO++;
    endif
  endfor

  pa=nrA/n
  po=nrO/n

  #B

  pTA = (1 - unifcdf(1.5,1,2)) * unifcdf(0.5,-1,1)
  pTB =  (1 - unifcdf(1.5,1,2)) + unifcdf(0.5,-1,1) - pTA


  #c val medie + prob teoretica
  # z= min{x, y} + max{x, y} =>z=x+y
  z = x + y;
  val_medie = mean(z)
end
