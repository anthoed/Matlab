pkg load image % pour le traitement d’image
close all
clear all
figure
plage_rgb=imread("fond_plage.jpg");
subplot(2,2,1);imshow(plage_rgb);

manchots_rgb=imread("manchots.jpg");
subplot(2,2,2);imshow(manchots_rgb);

manchots_ycbcr = rgb2ycbcr(manchots_rgb);
Y = manchots_ycbcr(:, :, 1);
Cb = manchots_ycbcr(:, :, 2);
Cr = manchots_ycbcr(:, :, 2);

%% on cherche quelle composente choisir pour segmenter t quelle valeur prendre.
figure
subplot(1,2,1);  %On s interresse a la composante bleu Cb il y a un fort contratre entre le fond et les manchots
imshow(Cb);

subplot(1,2,2);
hist(Cb);

%% binarization
blue_min = 142;
index_manchots = (find(manchots_ycbcr(:, :, 2) < blue_min))';
[ligne, colone, color] = size(manchots_rgb);
manchots_mask = zeros(ligne, colone);
manchots_mask(index_manchots) = 1;

figure
imshow(manchots_mask)

%% coller le mask des machot sur la plage
% "not" permet d inverser notre matrice

plage_avec_manchot_rgb = uint8 (manchots_mask) .* manchots_rgb + uint8 (not (manchots_mask)) .* plage_rgb;

figure
imshow(plage_avec_manchot_rgb)


