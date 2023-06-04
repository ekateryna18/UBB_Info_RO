function out=lab4_p2(nr_sim = 20, p = 0.5)
final = []
for j=1:nr_sim
  poz = 0
  for i = 1:nr_sim
    x=binornd(1,p);
    step = 2*x-1;
    poz += step;
  endfor
  final(j) = poz;
end
out = final;
