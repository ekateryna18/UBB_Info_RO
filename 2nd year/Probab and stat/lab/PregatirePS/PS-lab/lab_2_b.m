function out=lab3_2_b(nr_sim=5000)
clf; grid on; hold on;
p=1/6;
n=5;
m=nr_sim;
x=binornd(n,p,1,m);
N=hist(x,0:n);
bar(0:n,N/m,'hist','FaceColor','b');
bar(0:n,binopdf(0:n,n,p),'FaceColor','y');
legend('probabilitatile estimate','probabilitatile teroretice');
set(findobj('type','patch'),'facealpha',0.7);
xlim([-1 n+1]);
