function out=lab3_1_d(nr_sim = 5000)
rez = 0;
for i = 1:nr_sim
  extr = randsample('RRRRRAAAVV',3,replacement=false);
  if(extr(1) == 'R' || extr(2) == 'R' || extr(3) == 'R')
    rez++;
  endif
endfor
a = rez/nr_sim
rez = 0;
for i = 1:nr_sim
  extr = randsample('RRRRRAAAVV',3,replacement=false);
  if(extr(1) == 'R' && extr(2) == 'R' && extr(3) == 'R')
    rez++;
  endif
endfor
 b = rez/nr_sim
 out = b/a;
end
