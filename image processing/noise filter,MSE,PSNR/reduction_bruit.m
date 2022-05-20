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
title("bruité")

%% filtre passe bas

filtre_passe_bas = 1/9*ones(3);
angers_filtre_passe_bas = imfilter(angers_bruit,filtre_passe_bas);

filtre_passe_bas2 = 1/25*ones(5);
angers_filtre_passe_bas2 = imfilter(angers_bruit,filtre_passe_bas2);
subplot(a,b,3)
imshow(angers_filtre_passe_bas)
title("debruit filtre passe bas")

%% filtre median

angers_filtre_median = medfilt2(angers_bruit); % de base la matrice de filtre pour trouver la median est de 3 par 3
angers_filtre_median2 = medfilt2(angers_bruit,[5 5]); % ici 5x5


subplot(a,b,4)
imshow(angers_filtre_median)
title("debruit filtre median")

%%performance 

MSE_bruit = mean2((angers_base - angers_bruit).^2);

MSE_angers_filtre_passe_bas = mean2((angers_base - angers_filtre_passe_bas).^2);
MSE_angers_filtre_passe_bas2 = mean2((angers_base - angers_filtre_passe_bas2).^2);

MSE_angers_filtre_median = mean2((angers_base - angers_filtre_median).^2);
MSE_angers_filtre_median2 = mean2((angers_base - angers_filtre_median2).^2);


%%performance histogram
subplot(a,b,5)
histogram(angers_filtre_passe_bas)

PSNR_angers_filtre_passe_bas = 10*log(255^2/MSE_angers_filtre_passe_bas);

subplot(a,b,6)
histogram(angers_filtre_median)
PSNR_angers_filtre_median = 10*log(255^2/MSE_angers_filtre_median);

%%filtre adaptatif
moy_local = 1/9 * sum(angers_bruit);
var_local = 1/9 * sum(angers_bruit.^2) - moy_local.^2;
%num = max(var_local - MSE_bruit.^2,0);% prend la valeur zero daunq le numératif est négatif, sinon ca valeur 
num =var_local - MSE_bruit.^2;
autre = ( num / var_local ) .* (angers_bruit - moy_local);
angers_filtre_adap = moy_local + autre;
subplot(a,b,7)
imshow(angers_filtre_adap)
title('filte adapte')