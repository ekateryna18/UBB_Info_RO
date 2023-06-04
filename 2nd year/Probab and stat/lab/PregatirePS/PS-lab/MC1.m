function I = MC1(g,a,b,M,nr_sim = 1000)
  x = unifrnd(a,b,1,nr_sim);
  y = unifrnd(0,M,1,nr_sim);
  clf;hold on;
  %plot(x,y,'h','MarkerFaceColor', 'c')
  plot(x(g(x) > y),y(g(x) > y),'h','MarkerFaceColor', 'c')
  fplot(g,[a,b])

  aria = (b-a) * M;
  nr_sub_grafic = mean(g(x) > y);
  integral(g,a,b)
  I = aria*nr_sub_grafic;

