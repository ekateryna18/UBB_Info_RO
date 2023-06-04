function out=desene(n)
hold on

rectangle('Position', [0 0 1 1]);

fr_cerc=0;

centru = 0.5;

for i=1:n

    pctx=rand;
    pcty=rand;

    plot(pctx, pcty, '*r','MarkerSize',5)
end


end
