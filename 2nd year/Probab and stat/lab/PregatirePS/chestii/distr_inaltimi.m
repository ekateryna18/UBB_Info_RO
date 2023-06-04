function distr_inaltimi(n)
  m=165;
  sigma=10;
  rez = normrnd(m, sigma, 1, n);

  [_, xx] = hist(rez);

  vmin = min(rez);
  vmax = max(rez);
  step = 0.1;

  dif = 10/(vmax-vmin+1);

  hist(rez, xx, dif);

  hold on
  for x=vmin:step:vmax;
    y=normpdf(x, m, sigma);
    plot(x,y, 'r');
  endfor

  mean(rez)
  std(rez)
  med = mean((rez>=160) & (rez <=170))

  adv=normcdf(170, m, sigma) - normcdf(160, m, sigma)

end
