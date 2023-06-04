clf; hold on;

m = 165;
sigma = 10;
n = 10000;
x = normrnd(m, sigma, 1, n);

%i)
%hist(x,10)

%ii)
%pt a afla mij barelor
[~, mijl_bare] = hist(x,10)
l = (max(x) - min(x))/10;
hist(x,mijl_bare,1/l)

%iii)
f = @(t) normpdf(t,m,sigma)
fplot(f,[min(x),max(x)],'-r','LineWidth', 4)
%mean = media elem din vectorul x
mean(x)
%sigma
std(x)

% proportia de valori in intervalul [160,170]
mean(160 < x & x < 170)

normcdf(170,m,sigma) - normcdf(160,m,sigma)
