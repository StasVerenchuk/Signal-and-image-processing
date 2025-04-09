%% 1. Завантажити з бібліотеки MATLAB кілька тестових зображень. Відобразити вихідні зображення на екрані ПК
close all

img = imread('D:\Навчання\Signal-and-image-processing\lab2\images\10_копійок.jpg');
imshow(img);

%% 
img = rgb2gray(img);

%% 2. Здійснити процедуру зашумлення зображення нормальним білим шумом і імпульсною перешкодою з різною щільністю.
close all;

% Нормальний білий шум (Gaussian noise)
img_gaussian_noise = imnoise(img, 'gaussian');

% Імпульсна перешкода з різною щільністю
img_salt_pepper_noise_1 = imnoise(img, 'salt & pepper', 0.02);  % Щільність 2% шуму
img_salt_pepper_noise_2 = imnoise(img, 'salt & pepper', 0.1);  % Щільність 10% шуму

% Відображаємо оригінальне зображення та зображення з шумом
figure;

subplot(2,2,1);
imshow(img);
title('Оригінальне зображення');

subplot(2,2,2);
imshow(img_gaussian_noise);
title('Нормальний білий шум');

subplot(2,2,3);
imshow(img_salt_pepper_noise_1);
title('Імпульсна перешкода (щільність 2%)');

subplot(2,2,4);
imshow(img_salt_pepper_noise_2);
title('Імпульсна перешкода (щільність 10%)');

%% 3. Виконати фільтрацію вихідних зображень лінійними фільтрами з використанням віконних фільтрів низьких частот, і процедури imfilter(I,h);
close all;

h = ones(3, 3) / 9;
img_low_pass = imfilter(img, h);

figure;
imshow(img);
title('Оригінальне зображення');
figure;
imshow(img_low_pass);
title('Лінійний фільтр з використанням віконного фільтра низьких частот');
%% 4. Виконати фільтрацію вихідних зображень лінійними фільтрами з використанням віконних фільтрів високих частот, і процедури imfilter(I,h);
close all;

H = [0, -1, 0; -1, 5, -1; 0, -1, 0];
img_high_pass = imfilter(img, H);

figure;
imshow(img);
title('Оригінальне зображення');
figure;
imshow(img_high_pass);
title('Лінійний фільтр з використанням віконного фільтра високих частот');
%% 5. Відобразити зображення після фільтрації. Пояснити отриманий результат (зміна характеру зображення в результаті фільтрації). Відобразити результат фільтрації. Пояснити отриманий результат.

%% 6. Профільтрувати різними лінійними фільтрами зображення, що зашумлені різними за характером перешкодами. Відобразити результат фільтрації. Пояснити отриманий результат.
close all;

% Віконні маски фільтра низьких частот
% Маска середнє фільтрування
h1 = [1, 1, 1; 1, 1, 1; 1, 1, 1] * 1 / 9;
% Маска середнє фільтрування з більшою вагою в центрі
h2 = [1, 1, 1; 1, 2, 1; 1, 1, 1] * 1 / 10;
% Маска Гаусівське згладжування
h3 = [1, 2, 1; 2, 4, 2; 1, 2, 1] * 1 / 16;

% Маска Laplace з підсиленням
H1 = [0, -1, 0; -1, 5, -1; 0, -1, 0];
% Маска Простий фільтр для підсилення контурів
H2 = [-1, -1, -1; -1, 9, -1; -1, -1, -1];
% Маска Загальний фільтр для підсилення контурів
H3 = [1, -2, 1; -2, 5, -2; 1, -2, 1];

%% Низькочастотна фільтрація з віконними масками фільтра низьких частот
%% h1
close all;

gauss_filter_low1 = imfilter(img_gaussian_noise, h1)

figure;
imshow(img_gaussian_noise);
title('Зашумлене зображення білим шумом');

figure;
imshow(gauss_filter_low1);
title('Низькочастотна фільтрація білого шуму з маскою середнього фільтрування');
%% h2
gauss_filter_low2 = imfilter(img_gaussian_noise, h2)

figure;
imshow(gauss_filter_low2);
title('Низькочастотна фільтрація білого шуму з маскою середнього фільтрування з більшою вагою в центрі');
%% h3
gauss_filter_low3 = imfilter(img_gaussian_noise, h3)

figure;
imshow(gauss_filter_low3);
title('Низькочастотна фільтрація білого шуму з маскою Гаусівське згладжування');
%% Високочастотна фільтрація з віконними масками фільтра високих частот
%% H1
gauss_filter_high1 = imfilter(img_gaussian_noise, H1)

figure;
imshow(gauss_filter_high1);
title('Високочастотна фільтрація білого шуму з маскою Laplace з підсиленням');
%% H2
gauss_filter_high2 = imfilter(img_gaussian_noise, H2)

figure;
imshow(gauss_filter_high2);
title('Високочастотна фільтрація білого шуму з маскою Простий фільтр для підсилення контурів');
%% H3
gauss_filter_high3 = imfilter(img_gaussian_noise, H3)

figure;
imshow(gauss_filter_high3);
title('Високочастотна фільтрація білого шуму з маскою Загальний фільтр для підсилення контурів');
%% 
%% -----------------------------------------------------------------------------
%% %% Низькочастотна фільтрація salt&papper з віконними масками фільтра низьких частот
%% h1
close all;

salt_pepper_filter_low1 = imfilter(img_salt_pepper_noise_1, h1)

figure;
imshow(img_salt_pepper_noise_1);
title('Зашумлене зображення salt&papper 2%');

figure;
imshow(salt_pepper_filter_low1);
title('Низькочастотна фільтрація salt&papper 2% з маскою середнього фільтрування');
%% h2
salt_pepper_filter_low2 = imfilter(img_salt_pepper_noise_1, h2)

figure;
imshow(salt_pepper_filter_low2);
title('Низькочастотна фільтрація salt&papper 2% з маскою середнього фільтрування з більшою вагою в центрі');
%% h3
salt_pepper_filter_low3 = imfilter(img_salt_pepper_noise_1, h3)

figure;
imshow(salt_pepper_filter_low3);
title('Низькочастотна фільтрація salt&papper 2% з маскою Гаусівське згладжування');
%% Високочастотна фільтрація salt&papper 2% з віконними масками фільтра високих частот
%% H1
gauss_filter_high1 = imfilter(img_gaussian_noise, H1)

figure;
imshow(gauss_filter_high1);
title('Високочастотна фільтрація salt&papper 2% з маскою Laplace з підсиленням');
%% H2
gauss_filter_high2 = imfilter(img_gaussian_noise, H2)

figure;
imshow(gauss_filter_high2);
title('Високочастотна фільтрація salt&papper 2% з маскою Простий фільтр для підсилення контурів');
%% H3
gauss_filter_high3 = imfilter(img_gaussian_noise, H3)

figure;
imshow(gauss_filter_high3);
title('Високочастотна фільтрація salt&papper 2% з маскою Загальний фільтр для підсилення контурів');
%% 7. Виконати фільтрацію вихідних і перекручених шумами зображень адаптивним вінерівським фільтром (фільтром, який адаптує свої характеристики під характер і рівень шумів).
close all;

gauss_wiener_filter = wiener2(img_gaussian_noise, [5, 5]);

figure;

subplot(1,2,1);
imshow(img_gaussian_noise);
title('Нормальний білий шум');

subplot(1,2,2);
imshow(gauss_wiener_filter);
title('Адаптивна вінерівська фільтрація');

%% 
close all;

salt_pepper_wiener_filter = wiener2(img_salt_pepper_noise_1, [5, 5]);

figure;

subplot(1,2,1);
imshow(img_salt_pepper_noise_1);
title('Імпульсний шум');

subplot(1,2,2);
imshow(salt_pepper_wiener_filter);
title('Адаптивна вінерівська фільтрація');

%% 8. Здійснити фільтрацію зашумлених зображень нелінійним медіанним фільтром. Відобразити отриманий результат. Пояснити дію медіанного фільтра на гаусівську й імпульсну перешкоду на зображенні.
close all;

salt_pepper_median_filter = medfilt2(img_salt_pepper_noise_1);

figure;

subplot(1,2,1);
imshow(img_salt_pepper_noise_1);
title('Імпульсний шум');

subplot(1,2,2);
imshow(salt_pepper_median_filter);
title('Медіанна фільтрація');

%% 
close all;

gauss_median_filter = medfilt2(img_gaussian_noise);

figure;

subplot(1,2,1);
imshow(img_gaussian_noise);
title('Білий шум');

subplot(1,2,2);
imshow(gauss_median_filter);
title('Медіанна фільтрація');