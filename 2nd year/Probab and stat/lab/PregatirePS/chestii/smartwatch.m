function smartwatch(n=1000)
    pkg load statistics;
    clf

    nr=0;
    x=normrnd(100, 20, 1,n);
    for i=1:n
      el=x(i);
      if el>80 && el<140
        nr++;
      endif

    endfor

    prob = nr/n
    teoretica = normcdf(140, 100, 20)-normcdf(80, 100, 20)


    %vector cu N valori din distributia exponentiala cu lambda = 1/1


    %xx - vector cu mijloacele barelor
    [~,xx]=hist(x,13);

    %afisam histograma frcventelor relative cu 12 bare
    hist(x,xx,13/(max(x)-min(x)));

    hold on;


    for v=min(x):0.1:max(x);
      y=normpdf(v, 100, 20);
      plot(v,y, 'r');
    endfor
    %vector cu N puncte egal distantate intre min(x) si max(x)


    %exppdf calculeaza f(x) - functia de densitate in toate punctele vectorului t
    %plot(t,exppdf(t,1),'-r','LineWidth',3);

end
