# TSVM-CCCP

Este arquivo contém os algoritmos cccp.m , dados1.m , mnistdados.m :

- cccp.m : O algortimo principal que usa Concave-Convex Procedure (CCCP) aplicado às Máquinas de Vetor Suporte Transdutiva (TSVM). O programa foi adaptado para Octave
usando as ideias do pseudo-código disponível em "Large Scale Transductive SVMs - Collobert". As entradas do algoritmo estão explicadas no próprio programa, para executar
o algoritmo é necessário baixar a biblioteca "LIBSVM" e o pacote já instalado no Octave, "optim".

- dados1.m : É uma base de dados aleatória em formato de circunferência que possui 200 dados rotulads e 150 dados não rotulados.

- mnistdados.m : É a base de dados dos dígitos manuscritos bastante usada em Aprendizagem de Máquina, chamada MNIST. Contém um conjunto de treinamento (60000 x 784) e 
um conjunto de teste (10000 x 784), com seus respectivos vetores rotulados. Neste caso, o código seleciona os dados como sendo "5" ou "não 5".
