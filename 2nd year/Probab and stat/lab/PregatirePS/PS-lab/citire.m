fileID = fopen('keywords_ham.txt','r');
ham = textscan(fileID,'%s');
fclose(fileID);

fileID = fopen('keywords_spam.txt','r');
spam = textscan(fileID,'%s');
fclose(fileID);

fileID = fopen('email2.txt','r');
email = textscan(fileID,'%s');
fclose(fileID);
#fprintf('Al doilea cuvant: %s.\n',email{1}{2});

#words = unique([spam{1};ham{1}])

#prob cuv spam
p_spam = numel(spam{1})/(numel(spam{1})+numel(ham{1}));
p_ham = numel(ham{1})/(numel(spam{1})+numel(ham{1}));

for i = 1: numel(words)
  if ismember(words{i},email{1})
    p_spam *= sum(strcmp(words{i},spam{1}))/numel(spam{1});
    p_ham *= sum(strcmp(words{i},ham{1}))/numel(ham{1});
   else
    p_spam *= 1-sum(strcmp(words{i},spam{1}))/numel(spam{1});
    p_ham *= 1-sum(strcmp(words{i},ham{1}))/numel(ham{1});
  endif
end
if p_spam > p_ham
  disp 'Email-ul este spam'
else
  disp 'Email-ul este ham'
  endif


