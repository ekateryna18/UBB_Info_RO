function test(n=1000)
  clf
  ana=[1 1 2 2 2 3 3 3 3 4 6 6]
  radu=[1 2 3 3 4 5]
  nrEqual=0;
  nrSmall=0;
  sums=zeros(1,n);
  for i=1:n
    pozi=randi(12);
    pozr=randi(6);

    eli=ana(pozi);
    elr=radu(pozr);

    sums(i)=eli+elr;

    if eli==elr
      nrEqual++;
    endif

    if eli > elr
      nrSmall++;
    endif

  endfor
  #A
  #prob-estimari
  proEqEstimare=nrEqual/n
  #prob-teoretica


  #B
  probSmall=nrSmall/n

  #C

  e=mean(sums)

  [~, xx] = hist(sums, 10);
  limits=10/(max(sums)-min(sums));
  hist(sums,xx, limits)


endfunction
