pkg load image % pour le traitement d’image

close all;
clear all;

%%format d'une image :

%image RVB
billard_rvb = imread("billard.jpg");
figure;subplot(2,3,1); imshow(billard_rvb); title("RVB");

%image gris
billard_gris = rgb2gray(billard_rvb);
subplot(2,3,2); imshow(billard_gris); title("niveau de gris");

%image binaire (ne peut etre possible qu'avec une image en niveau de gris
billard_bin = im2bw(billard_gris);
subplot(2,3,3);imshow(billard_bin);title("binaire");

##%image indexee
##billard_index = rgb2ind(billard_rvb,0.13);
##subplot(2,3,4);imshow(billard_index);title("indexe");

%image YCbCr
billard_YCbCr = rgb2ycbcr(billard_rvb);
subplot(2,3,5);imshow(billard_YCbCr);title("YCbCr");



%% afficher les trois composantes de l image R, V et B :

Rouge = billard_rvb(:,:,1);
Vert = billard_rvb(:,:,2);
Bleu = billard_rvb(:,:,3);

Y = billard_YCbCr(:,:,1);
Cb = billard_YCbCr(:,:,2);
Cr =billard_YCbCr(:,:,3);

%on peut aussi utiliser [Rouge,Vert,Bleu]=imsplit(billard_rvb); on
%on obtiendra le meme resultat

%%
%Augmenter ou diminuer la luminosite :
%c'est un decalage de l'historigraamme de la composante Y
%donc regardons l'histograme de Y de notre image

figure
subplot(2,2,3)
hist(Y);


billard_YCbCr_luminosite = billard_YCbCr;           %on cree une nouvelle image pour pouvoir comparer
billard_YCbCr_luminosite(:,:,1) = billard_YCbCr_luminosite(:,:,1)+100; %decaler histo d'une valeur de 100
Y_lum = billard_YCbCr_luminosite(:,:,1);


subplot(2,2,1)
imshow(billard_rvb);  %image de base
title("image RGB")

subplot(2,2,2)
imshow(ycbcr2rgb(billard_YCbCr_luminosite)); %image avec plus de luminosite
title("image avec plus de luminosite")

subplot(2,2,4)
hist(Y_lum); %histogram de la composante Y de l'im avec plus de luminosite

%%
%Augmenter le contraste
billard_YCbCr_contraste = billard_YCbCr;

bmin = min(min(billard_YCbCr_contraste(:,:,1)));
bmax = max(max(billard_YCbCr_contraste(:,:,1)));
lmin=0;
lmax=255;

billard_YCbCr_contraste(:,:,1) = ( double(billard_YCbCr_contraste(:,:,1) - bmin)./double(bmax-bmin) ) .* (lmax-lmin) + lmin;

billar_contraste = ycbcr2rgb(billard_YCbCr_contraste);

figure
subplot(2,2,1)
imshow(billard_rvb)
title("image RGB")

subplot(2,2,3)
hist(Y);
title("histogram Y de base")

subplot(2,2,2)
imshow(billar_contraste)
title("image Contraste")

subplot(2,2,4)
hist(billard_YCbCr_contraste(:,:,1));
title("histogram Y de l'image contraste")


%%
%Permuatation couleur
% Test permutation
subplot(1, 2, 1)
hist(billard_YCbCr_contraste(:,:,2))
title("histogram de Cb")

subplot(1, 2, 2)
hist(billard_YCbCr_contraste(:,:,3))
title("histogram de Cr")

lmin_cb = 180;
lmin_cr = 140;

parcours_r = find(billard_YCbCr_contraste(:, :, 2) > lmin_cr);
parcours_b = find(billard_YCbCr_contraste(:, :, 3) > lmin_cb);

chanel_r = billard_YCbCr_contraste(:, :, 2);
chanel_b = billard_YCbCr_contraste(:, :, 3);

for count = parcours_r
    chanel_x = chanel_r(count);
    chanel_r(count) = chanel_b(count);
    chanel_b(count) = chanel_x;
end

for count = parcours_b
    chanel_x = chanel_b(count);
    chanel_b(count) = chanel_r(count);
    chanel_r(count) = chanel_x;
end

billard_YCbCr_contraste(:, :, 2) = chanel_r;
billard_YCbCr_contraste(:, :, 3) = chanel_b;
billard_final = ycbcr2rgb(billard_YCbCr_contraste);
figure
imshow(billard_final);









