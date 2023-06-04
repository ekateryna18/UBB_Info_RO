function out=lab2_p2(N = 500)
  clf;hold on;axis equal;
  grid on;
  rectangle('Position',[0,0,1,1]);
  cnt = 0;
  for i = 1:N
    x = rand;
    y = rand;
    p = [x,y];
    #plot(x,y,'*r');
    o = [0.5,0.5];
    if sqrt((x-0.5)^2 + (y-0.5)^2) < sqrt((x)^2 + (y)^2) &...
      sqrt((x-0.5)^2 + (y-0.5)^2) < sqrt((x)^2 + (y-1)^2) &...
      sqrt((x-0.5)^2 + (y-0.5)^2) < sqrt((x-1)^2 + (y)^2) &...
      sqrt((x-0.5)^2 + (y-0.5)^2) < sqrt((x-1)^2 + (y-1)^2)
      plot(x,y,'*r');
      #cnt++;
    endif
  endfor
  #out = 4*cnt/N;
  out = cnt/N;
end


