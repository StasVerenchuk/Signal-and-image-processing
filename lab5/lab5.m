%% 1. Завантажити з бібліотеки MATLAB кілька тестових зображень. Відобразити вихідні зображення на екрані ПК
close all

img1 = imread('D:\Навчання\Signal-and-image-processing\lab5\images\perch.jpg');
img2 = imread('autumn.tif');

figure;
imshow(img1);
figure;
imshow(img2);
%% 
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
%% 3. дискретне косинусне перетворення зображень.
img1_dct = dct2(img1);
img2_dct = dct2(img2);

figure;
subplot(1,2,1);
imshow(img1);
title('');

subplot(1,2,2);
imshow(log(abs(img1_dct)), []);
title('DCT ');

figure;
subplot(1,2,1);
imshow(img2);
title('');

subplot(1,2,2);
imshow(log(abs(img2_dct)), []);
title('DCT ');
%% 
img1_k = idct2(img1_dct);
img2_k = idct2(img2_dct);

figure;
subplot(1,3,1);
imshow(img1);
title('');

subplot(1,3,2);
imshow(log(abs(img1_dct)), []);
title('DCT ');

subplot(1,3,3);
imshow(img1_k, []);
title('Відновлене ');

subplot(2,3,1);
imshow(img2);
title('');

subplot(2,3,2);
imshow(log(abs(img2_dct)), []);
title('DCT ');

subplot(2,3,3);
imshow(img2_k, []);
title('Відновлене ');

%% Квантування за допомогою формули J = N*round(J*N)
n1 = 0.1;
n2 = 1;
n3 = 10;

J1_quantized1 = n1 * round(img1_dct * n1);
J1_quantized2 = n2 * round(img1_dct * n2);
J1_quantized3 = n3 * round(img1_dct * n3);

figure;
imshow(log(abs(J1_quantized1)), []);
title(['Квантування (N = ' num2str(n1) ')']);
figure;
imshow(log(abs(J1_quantized2)), []);
title(['Квантування (N = ' num2str(n2) ')']);
figure;
imshow(log(abs(J1_quantized3)), []);
title(['Квантування (N = ' num2str(n3) ')']);
%% Відновлення зображення після квантування
img1_reconstructed1 = idct2(J1_quantized1);
img1_reconstructed2 = idct2(J1_quantized2);
img1_reconstructed3 = idct2(J1_quantized3);

figure;
imshow(img1);
title(['']);
figure;
imshow(img1_reconstructed1, []);
title(['Відновлене (N = ' num2str(n1) ')']);
figure;
imshow(img1_reconstructed2, []);
title(['Відновлене (N = ' num2str(n2) ')']);
figure;
imshow(img1_reconstructed3, []);
title(['Відновлене (N = ' num2str(n3) ')']);

% log(abs())
%% 
close all;
%% 
% Квантуємо зображення
img_quantized = round(img1 / n1) * n1;

% Відображаємо результат квантування
figure;
imshow(uint8(img_quantized));
title(['Квантування з n = ', num2str(n1)]);