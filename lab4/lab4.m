%% 
close all;
%% 
img = imread('cameraman.tif');
imshow(img);
%% 2. Двовимірні спектри зображень
F = fft2(img);
S = abs(F);
Slog = log(1+S);

% Відображаємо зображення та спектр
figure;

subplot(1,2,1);
imshow(img);
title('Оригінальне зображення');

subplot(1,2,2);
imshow(Slog, []);
title('Спектр (двовимірне ДПФ)');
%% 3. Відображення спектру зображення з початком в центрі частотної області
Fc = fftshift(S);
Slog = log(1 + Fc);

figure;
imshow(Slog, []);
title('Спектр з початком в центрі (двовимірне ДПФ)');
%% 4. Відновлення зображень за їх спектрами
F = fft2(img);
Fc = fftshift(F);
Fdc = ifftshift(Fc);
If = ifft2(Fdc);

% Відображаємо зображення та спектр
figure;

subplot(1,2,1);
imshow(img);
title('Оригінальне зображення');

subplot(1,2,2);
imshow(If, []);
title('Відновлене зображення');
%% 5. Задати дововимірний фільтр з параметрами [M,N], sigma в області просторових змінних
% Встановлення параметрів фільтра
M = 25;  % Висота фільтра
N = 25;  % Ширина фільтра
sigma1 = 1;  % Стандартне відхилення

h1 = fspecial('gaussian', [M, N], sigma1);

figure;
imshow(h1, []);
title('Гаусівський фільтр (sigma = 1)');
%% 6. Визначення вигляду частотної характеристики фільтра та її відображення
H1 = fft2(h1);
SH1=abs(H1);
Shc1= fftshift(SH1);
Shlog1=log(1+Shc1);

figure
imshow(Shlog1, []);
title('Частотна характеристика фільтра');
%% 
close all;
figure;
subplot(1,2,1);
imshow(h1, []);
title('Гаусівський фільтр (sigma = 1)');
subplot(1,2,2);
imshow(Shlog1, []);
title('Частотна характеристика фільтра');
%% 7. Змініть параметр sigma фільтра, і повторіть пункти 5, 6
sigma10 = 10;  % Стандартне відхилення

h2 = fspecial('gaussian', [M, N], sigma10);

H2 = fft2(h2);
SH2 = abs(H2);
Shc2 = fftshift(SH2);
Shlog2 =log(1+Shc2);

figure;
subplot(1,2,1);
imshow(h2, []);
title('Гаусівський фільтр (sigma = 10)');
subplot(1,2,2);
imshow(Shlog2, []);
title('Частотна характеристика фільтра');
%% 8. Виконайте фільтрацію зображень у частотній області з використанням фільтрів згідно пунктів 5, 6, 7
sigma1 = 1;
h1 = fspecial('gaussian', [M, N], sigma1);

H1 = fft2(h1, size(img, 1), size(img, 2)); 
SH1 = abs(H1);
Shc1 = fftshift(SH1);
Shlog1 = log(1 + Shc1);

sigma2 = 10;
h2 = fspecial('gaussian', [M, N], sigma2);

H2 = fft2(h2, size(img, 1), size(img, 2));
SH2 = abs(H2);
Shc2 = fftshift(SH2);
Shlog2 = log(1 + Shc2);

% Фільтрація зображення в частотній області (sigma = 1)
F = fft2(img);
F1 = F .* H1;
If1 = ifft2(F1);

% Фільтрація зображення в частотній області (sigma = 10)
F2 = F .* H2;
If2 = ifft2(F2);

% Відображення результатів
figure;

subplot(1, 3, 1);
imshow(h1, []);
title('Гаусівський фільтр (sigma = 1)');

subplot(1, 3, 2);
imshow(Shlog1, []);
title('Частотна характеристика фільтра (sigma = 1)');

subplot(1, 3, 3);
imshow(If1, []);
title('Відфільтроване зображення (sigma = 1)');

figure;

subplot(1, 3, 1);
imshow(h2, []);
title('Гаусівський фільтр (sigma = 10)');

subplot(1, 3, 2);
imshow(Shlog2, []);
title('Частотна характеристика фільтра (sigma = 10)');

subplot(1, 3, 3);
imshow(If2, []);
title('Відфільтроване зображення (sigma = 10)');
%% 9. З використанням того самого віконного фільтра, заданого функцією
% fspecial('gaussian'), виконайте фільтрацію зображення в області
% просторових змінних.
img_filtered = imfilter(img, h, 'same', 'replicate');

figure;

subplot(1, 2, 1);
imshow(If1, []);
title('Фільтрація (частотна область)');

subplot(1, 2, 2);
imshow(img_filtered, []);
title('Фільтрація (область просторових змінних)');