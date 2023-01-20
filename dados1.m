%%% Base de dados aleatória em formato de circunferência %%%
n = 200;
for i = 1:n
  xr(i,:) = rand(1,2)*6 - 3;
  if (xr(i,1))^2 + (xr(i,2))^2 <= 2
    y(i) = 1;
  else
    y(i) = -1;
  endif
endfor

% Definindo rótulos dos dados de teste para a comparação: %
m = 150;
for i = 1:m
  xnr(i,:) = rand(1,2)*6 - 3;
  if (xnr(i,1))^2 + (xnr(i,2))^2 <= 2
    yytest(i) = 1;
  else
    yytest(i) = -1;
  endif
endfor

ytest = yytest';
X = [xr y'];
indn = y < 0;
indp = y > 0;

% Plotagem dos pontos %
plot(X(indn,1),X(indn,2),'g.','markersize',12,X(indp,1),X(indp,2),'r.','markersize',12)
hold on
plot(xnr(:,1),xnr(:,2),'k.','markersize',12)
