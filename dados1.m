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

m = 150;
for i = 1:m
  xnr(i,:) = rand(1,2)*6 - 3;
endfor

s = -0.4;
C = 2.597;
CC = 0.3;
gamma = 0.03;
X = [xr y'];
indn = y < 0;
indp = y > 0;

plot(X(indn,1),X(indn,2),'g.','markersize',12,X(indp,1),X(indp,2),'r.','markersize',12)
hold on
plot(xnr(:,1),xnr(:,2),'k.','markersize',12)
