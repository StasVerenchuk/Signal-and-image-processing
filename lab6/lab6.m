%% 1
img1 = imread('peppers.png');
img2 = imread('cameraman.tif');
%% 2
if size(img1, 3) == 3
    img1_gray = rgb2gray(img1);
else
    img1_gray = img1;
end

if size(img2, 3) == 3
    img2_gray = rgb2gray(img2);
else
    img2_gray = img2;
end

figure;
subplot(1,2,1);
imshow(img1);
title('Оригінал: peppers.png');

subplot(1,2,2);
imshow(img1_gray);
title('Чорно-біле: peppers.png');

figure;
subplot(1,2,1);
imshow(img2);
title('Оригінал: cameraman.tif');

subplot(1,2,2);
imshow(img2_gray);
title('Чорно-біле: cameraman.tif');

%% 3 поблочне дискретне косинусне перетворення зображень.
% Поблочне ДКП — параметри
N = 8;                      % Розмір блоку
T = dctmtx(N);              % Матриця ДКП
dct_func = @(block_struct) T * block_struct.data * T';  % ДКП для блоку


%% 4
% Поблочне ДКП для peppers.png
img1_d = im2double(img1_gray);
B1 = blockproc(img1_d, [N N], dct_func);
B1_log = log(1 + abs(B1));

figure;
imshow(B1_log, []);
title('DCT блоками (log) – peppers.png');

% Поблочне ДКП для cameraman.tif
img2_d = im2double(img2_gray);
B2 = blockproc(img2_d, [N N], dct_func);
B2_log = log(1 + abs(B2));

figure;
imshow(B2_log, []);
title('DCT блоками (log) – cameraman.tif');
%% 5. Відновлення зображень за допомогою зворотного ДКП

% Функція зворотного перетворення
invdct = @(block_struct) T' * block_struct.data * T;

% Відновлення зображення для peppers.png
I1_restored = blockproc(B1, [N N], invdct);

% Відновлення зображення для cameraman.tif
I2_restored = blockproc(B2, [N N], invdct);

% Відображення результатів
figure;
subplot(1,2,1);
imshow(img1_gray);
title('Оригінал (grayscale): peppers.png');

subplot(1,2,2);
imshow(I1_restored, []);
title('Відновлене зображення: peppers.png');

figure;
subplot(1,2,1);
imshow(img2_gray);
title('Оригінал: cameraman.tif');

subplot(1,2,2);
imshow(I2_restored, []);
title('Відновлене зображення: cameraman.tif');
%% 6. Квантування ДКП-коефіцієнтів для різних значень кроку
quant_steps = [1, 5, 10];  % Значення кроку квантування

for k = 1:length(quant_steps)
    qN = quant_steps(k);

    % ==== peppers.png ====
    % Квантування спектра
    B1q = qN * round(B1 / qN);
    
    % Візуалізація спектра після квантування
    figure;
    B1q_log = log(1 + abs(B1q));
    subplot(1,2,1);
    imshow(B1q_log, []);
    title(['Спектр після квантування (N = ', num2str(qN), ') – peppers.png']);
    
    % Відновлення зображення
    I1q = blockproc(B1q, [N N], invdct);
    subplot(1,2,2);
    imshow(I1q, []);
    title(['Відновлення після квантування (N = ', num2str(qN), ') – peppers.png']);

    % ==== cameraman.tif ====
    B2q = qN * round(B2 / qN);

    figure;
    B2q_log = log(1 + abs(B2q));
    subplot(1,2,1);
    imshow(B2q_log, []);
    title(['Спектр після квантування (N = ', num2str(qN), ') – cameraman.tif']);

    I2q = blockproc(B2q, [N N], invdct);
    subplot(1,2,2);
    imshow(I2q, []);
    title(['Відновлення після квантування (N = ', num2str(qN), ') – cameraman.tif']);
end
%% 7. Маскування коефіцієнтів ДКП

% Визначення маски
mask = [1 1 1 1 0 0 0 0;
        1 1 1 0 0 0 0 0;
        1 1 0 0 0 0 0 0;
        1 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0];

% Маскування блоків ДКП для peppers.png
B1_masked = blockproc(B1, [8 8], @(block_struct) mask .* block_struct.data);
I1_masked = blockproc(B1_masked, [8 8], invdct);

figure;
subplot(1,2,1);
imshow(log(1 + abs(B1_masked)), []);
title('Спектр після маскування – peppers.png');

subplot(1,2,2);
imshow(I1_masked, []);
title('Відновлення після маскування – peppers.png');

% Маскування блоків ДКП для cameraman.tif
B2_masked = blockproc(B2, [8 8], @(block_struct) mask .* block_struct.data);
I2_masked = blockproc(B2_masked, [8 8], invdct);

figure;
subplot(1,2,1);
imshow(log(1 + abs(B2_masked)), []);
title('Спектр після маскування – cameraman.tif');

subplot(1,2,2);
imshow(I2_masked, []);
title('Відновлення після маскування – cameraman.tif');
%% 8. Відновлення зображення після квантування
% (припускаємо, що B1q та B2q отримані після квантування)

I1q_restored = blockproc(B1q, [8 8], invdct);
I2q_restored = blockproc(B2q, [8 8], invdct);

% Візуалізація
figure;
subplot(1,2,1);
imshow(I1q_restored, []);
title('Відновлене зображення після квантування – peppers.png');

subplot(1,2,2);
imshow(I2q_restored, []);
title('Відновлене зображення після квантування – cameraman.tif');
