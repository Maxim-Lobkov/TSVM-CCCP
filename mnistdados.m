%% Dados MNIST com classificação "5" ou "não 5" %%
d = load('mnist.mat');
%% Dados: %%
xr = d.trainX;
xnr = d.testX;

yy = d.trainY;
y5 = yy';
y = ones(length(y5),1);

ytest = d.testY;
y5test = ytest';
yytest = ones(length(y5test),1);

for i = 1:(length(y5)) %% Definindo rótulos %%
  if (y5(i) == 5)
    y(i) = 1;
  else
    y(i) = -1;
  endif
endfor

%% Definindo rótulos dos dados de teste para a comparação: %%
for i = 1:(length(y5test))
  if (y5test(i) == 5)
    yytest(i) = 1;
  else
    yytest(i) = -1;
  endif
endfor

%% Saída de dados %%
xr = im2double(xr);
y = im2double(y);
xnr = im2double(xnr);
yytest = im2double(yytest);
