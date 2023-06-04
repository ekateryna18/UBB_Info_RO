function practic(N = 1000)
  pkg load statistics
  %vector cu N valori din distributia exponentiala cu lambda = 1/1
  x=exprnd(1,1,N);

  %xx - vector cu mijloacele barelor
  [~,xx]=hist(x,12);

  %afisam histograma frcventelor relative cu 12 bare
  hist(x,xx,12/(max(x)-min(x)));

  hold on;

  %vector cu N puncte egal distantate intre min(x) si max(x)
  t=linspace(min(x),max(x),N);

  %exppdf calculeaza f(x) - functia de densitate in toate punctele vectorului t
  plot(t,exppdf(t,1),'-r','LineWidth',3);
endfunction
