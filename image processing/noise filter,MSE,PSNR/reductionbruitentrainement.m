clear ALL
close all
load ('angers.mat')

a = 3;
b = 3;

angers_base = ind2gray(X,map);
angers_base2 = angers_base.*255;
angers_8 = uint8(angers_base*255);

figure
subplot(a,b,1)
imshow(angers_8)
title("base")

moyen = 0;
sigma_carre = 0.05;

bruit =  moyen + sigma_carre*randn(size(angers_8));
angers_bruit = angers_base+bruit;
subplot(a,b,2)
imshow(angers_bruit)
title("bruit�")

%% filtre passe base
filtre_passe_bas = 1/9*ones(3);
