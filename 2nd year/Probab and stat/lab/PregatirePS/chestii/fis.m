function fis()

fileID = fopen('keywords_spam.txt','r');
spam=textscan(fileID,'%s');
fclose(fileID);

fileID = fopen('keywords_ham.txt','r');
ham=textscan(fileID,'%s');
fclose(fileID);

cs=numel(spam{1});
ch=numel(ham{1});

suma=cs+ch;

ps=cs/suma
ph=ch/suma

w=unique(spam{1});
n=length(w);

email="invite your friend today to click here";
email2="call your friend today it’s urgent thank you";

probham=1;
probspam=1;

for k=1:n
  s=sum(strcmp(w{k}, spam{1}));
  pspam=s/cs;
  h=sum(strcmp(w{k}, ham{1}));
  pham=h/ch;

  if ismember(w{k}, email2)
    probspam=probspam*pspam;
    probham=probham*pham;
  else
    probspam=probspam*(1-pspam);
    probham=probham*(1-pham);
  endif
end

probham=probham*ph
probspam=probspam*ps

if probham>probspam
  fprintf("E ham!")
else
  fprintf("E spam!")
endif

