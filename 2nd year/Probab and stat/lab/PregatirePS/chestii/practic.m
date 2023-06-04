function practic(N = 10000)
  pkg load statistics
  nr = 0;
  for i= 1:N
    % valoare din distributia exponentiala cu lambda = 1/1
    x = exprnd(1);
    % nr cazuri favorabile
    if x > 0.5
      nr++;
    endif
  endfor
  pA = nr/N
  % expcdf calculeaza P(X<0.5), deci ne trebuie 1-P(X>0.5)
  pA_teoretic = 1 - expcdf(0.5,1)

endfunction
