function out=lab5_p1(nr_sim = 10,x = [0,1,2,3], p = [0.46,0.4,0.1,0.04])
  vector = []
  for j = 1:nr_sim
    random = rand;
    suma = 0;
    rez = 0;
    for i = 1:length(x)
      if(random > suma && random < suma + p(i))
        vector(j) = x(i);
      endif
      suma = suma + p(i);
    endfor

  endfor
out = vector;
a = hist(vector,x);
b = a/nr_sim;
bar(x,b,'facecolor','b');
end

