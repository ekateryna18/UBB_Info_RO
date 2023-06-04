function out=aranjamente(v, k)
c=nchoosek(v, k);

row=c(1,:);
mat=perms(row);

for el=2:length(c)
    row=c(el,:);
    new=perms(row);
    mat=[mat;new];
end
out=mat;
end