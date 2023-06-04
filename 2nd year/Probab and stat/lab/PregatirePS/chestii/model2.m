% X~unif[1,2] Y~unif[-1,1]
pkg load statistics

%a
n=1000
vx = unifrnd(1,2,1,n);
vy = unifrnd(-1,1,1,n);
zz = 0;

i=1;
x_count = 0;
y_count = 0;
xsiy_count = 0;
xsauy_count = 0;

while i<=n
  if vx(i) >1.5
    x_count = x_count+1;
  endif

  if vy(i) < 0.5
    y_count = y_count+1;
  endif

  if vx(i) >1.5 && vy(i) < 0.5
    xsiy_count=xsiy_count+1;
  endif

  if vx(i) >1.5 || vy(i) < 0.5
    xsauy_count=xsauy_count+1;
  endif

  zz = zz + vx(i) + vy(i);

  i=i+1;
endwhile


printf("prob simulata X > 1.5: %d \n", x_count/n);
printf("prob simulata Y < 0.5: %d \n", y_count/n);
printf("prob simulata X si Y: %d \n", xsiy_count/n);
printf("prob simulata X sau Y: %d \n", xsauy_count/n);
printf("\n");

%b
Y=unifcdf(0.5,-1,1);
X=1-unifcdf(1.5,1,2);

printf("prob teoretica X > 1.5: %d \n", X);
printf("prob teoretica Y < 0.5: %d \n", Y);
printf("prob teoretica X si Y: %d \n", X*Y);
printf("prob teoretica X sau Y: %d \n", X+Y-X*Y);



zz = zz / n;
printf("\nmean value simulated: %d\n",zz);
printf("mean value teoretic: %d\n\n",unifstat(0,3)(1));
