function I = MC1(g,a,b,M,nr_sim = 1000)
  x = unifrnd(a,b,1,nr_sim);
  y = unifrnd(0,M,1,nr_sim);
  clf;
  plot(x,y,'x')
