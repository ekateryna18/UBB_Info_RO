clf; grid on; hold on;
p = 0.6;
n = 10;
m = 1000;
x = binornd(n , p , 1 , m);
poz_fin = x-(n-x);
N = hist(poz_fin,-n:n);
bar(-n:n,N/m,'hist','FaceColor','b');
set(gca,'xtick',-n:n)
pasi_dr = 0:n;
bar(2*pasi_dr-n,binopdf(pasi_dr,n,p),'FaceColor','y');
#legend('probabilitatile estimate','probabilitatile teroretice');
set(findobj('type','patch'),'facealpha',0.7);
#xlim([-1 n+1]);
