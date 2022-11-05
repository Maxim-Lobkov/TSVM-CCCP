%%% Algoritmo de Concave-Convex Procedure para TSVM %%%
%%% xr: dados de treinamento(rotulados); y: rótulos dos dados de treino; xnr: dados não rotulados %%%
%%% Parâmetros: s,C,CC = C*,gamma %%%
function [fn,Xrot,yrot] = cccp(xr,y,xnr,s,C,CC,gamma)
  L = rows(xr); % Número de dados rotulados %
  U = rows(xnr); % Número de dados não rotulados %

  % Matrizes com dados rotulados e não rotulados: %
  ynr = [ones(U,1);-ones(U,1)];
  xnrt = [xnr;xnr];
  X = [xr y;xnrt ynr];
  [m,n] = size(X);
  yt = X(:,n);
  xt = X(:,1:(n-1));

  % SVM nos dados de treinamento: %
  modelo = svmtrain(y,xr,cstrcat("-g ", num2str(gamma)," -c ", num2str(C)));
  [~,~,f0] = svmpredict(-ones(rows(xt),1),xt,modelo); % Obtendo o classificador inicial %

  for i = 1:(L+2*U)
    if (i >= L+1 && yt(i)*f0(i) < s) % Inicializando beta %
      beta0(i) = CC;
    else
      beta0(i) = 0;
    endif
  endfor

  zeta0 = 0;
  for i = 1:L % Obtendo Zeta %
    zeta0 = zeta0 + (1/L)*y(i);
  endfor

  for i = 1:(L+2*U)
    zeta(i) = yt(i);
  endfor
  zt = [zeta0 zeta]'; % Vetor Zeta %

  % Matriz Kernel: %
  for i= 1:(L + 2*U)
    K(i,i) = 1;
    for j = (i+1):(L+2*U)
      K(i,j) = exp(-gamma*((xt(i,:) - xt(j,:))*(xt(i,:) - xt(j,:))'));
      K(j,i) = K(i,j);
    endfor
  endfor

  % Matriz Kernel com o elemento adicionado x0: %
  vec = 0;
  Kt(1,1) = 1;
  for i = 2:(L+2*U+1)
    for j = (L+1):(L+U)
      vec = vec + (1/U)*exp(-gamma*((xt(j,:) - xt(i-1,:))*(xt(j,:) - xt(i-1,:))'));
      Kt(i,1) = vec;
    endfor
    Kt(1,i) = Kt(i,1);
    for j = 2:(L+2*U+1)
      Kt(i,j) = K(i-1,j-1);
    endfor
  endfor

  sair = 0;
  % yt e beta0 com o elemento adicionado x0: %
  yyt = [1;yt];
  bbt0 = [0;beta0'];

  iter = 0;
  % Resolvendo o problema convexo TSVM cm CCCP: %
  while sair == 0
     % Entradas para minimizar o problema convexo: %
     A = []; B = [];
     AEQ = ones(1,L+2*U+1); BEQ = 0;
     LB = min([C*ones(L+1,1);CC*ones(2*U,1)].*yyt-bbt0,zeros(L+2*U+1,1));
     UB = max([C*ones(L+1,1);CC*ones(2*U,1)].*yyt-bbt0,zeros(L+2*U+1,1));

     % Minimizando o Problema Convexo retornando at: %
     [at] = quadprog(Kt,-zt,A,B,AEQ,BEQ,LB,UB);

     % Solução do problema convexo original: %
     alpha = at.*yyt + bbt0;
     % Componentes (índices) de alpha: %
     ind = yyt.*alpha > -bbt0 & yyt.*alpha < [C*ones(L+1,1);CC*ones(2*U,1)] - bbt0;
     bn = mean(yyt(ind) - Kt(ind,:)*alpha); % Novo b %
     fn = Kt*alpha + bn; % Novo f %
     yyt = [yyt(1:(L+1));sign(fn(L+2:end))]; % Rótulo %

     % Atualizando Beta: %
     for i = 1:(L+2*U+1)
       if (i >= L+2 && yyt(i)*fn(i) < s)
         bbt(i) = CC;
       else
         bbt(i) = 0;
       endif
     endfor
     % Critério de Parada: %
     if sum(bbt0 == bbt) == (L + 2*U + 1)
       sair = 1;
     else
       bbt0 = bbt';
     endif
     iter = iter + 1
  endwhile

  %% Rotulando os dados %%
  yrot = yyt(2:L+U+1);
  xx = [xr;xnr];
  Xrot = [xx yrot];
