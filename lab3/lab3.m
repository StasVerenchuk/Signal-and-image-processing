close all

img = imread('cameraman.tif');
imshow(img);
%% Перекручення зображення з зміною параметрів LEN та THETA


%LEN = 21;
THETA = 0;
psf = fspecial('motion', 21, THETA);
blurred = imfilter(img, psf, 'conv', 'circular');

psf1 = fspecial('motion', 20, 30);
blurred1 = imfilter(img, psf1, 'conv', 'circular');

% Відображаємота змазане зображення
figure;
imshow(blurred);
title('Зображення змазане горизонтально');

figure;
imshow(blurred1);
title('2 Зображення змазане горизонтально');
%% Відновелння зображення

wnr1 = deconvwnr(blurred, psf, 0);
wnr2 = deconvwnr(blurred1, psf, 0);

figure;
imshow(wnr1);
title('Відновленне зображення 1');

figure;
imshow(wnr2);
title('Відновленне зображення 2');
%% Зашумленння зображення

% Нормальний білий шум (Gaussian noise)
img_gaussian_noise = imnoise(img, 'gaussian');

% Імпульсна перешкода
img_salt_pepper_noise_1 = imnoise(img, 'salt & pepper', 0.02);  % Щільність 2% шуму

% Перекручення зашумленого зображення з зміною параметрів LEN та THETA

LEN = 21;
THETA = 0;
psf = fspecial('motion', LEN, THETA);
blurred = imfilter(img_gaussian_noise, psf, 'conv', 'circular');
blurred1 = imfilter(img_salt_pepper_noise_1, psf1, 'conv', 'circular');

figure;
imshow(img_gaussian_noise);
title('Нормальний білий шум');

figure;
imshow(blurred);
title('Перекручене зображення (нормальний білий шум)');

figure;
imshow(img_salt_pepper_noise_1);
title('Імпульсна перешкода');

figure;
imshow(blurred1);
title('Перекручене зображення (імпульсна перешкода)');
%% Відновлення
%% Відновелння зображення

wnr_gaussian_blur = deconvwnr(blurred, psf, 0);
wnr_salt_pepper_noise = deconvwnr(blurred1, psf, 0);

figure;
imshow(wnr_gaussian_blur);
title('Відновленне зображення (нормальний білий шум)');

figure;
imshow(wnr_salt_pepper_noise);
title('Відновленне зображення (імпульсна перешкода)');
%% 
close all
