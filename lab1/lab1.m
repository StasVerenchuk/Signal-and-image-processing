%% 1. Завантаження зображень з бібліотеки
close all

img1 = imread('trees.tif');
img2 = imread('pears.png');
img3 = imread('greens.jpg');
imshow(img1), figure, imshow(img2), figure, imshow(img3)
%% 2. Завантаження власного зображення
close all

my_img = imread('D:\Навчання\Signal-and-image-processing\lab1\images\bug.jpg');
imshow(my_img)
%% 3. Отримуємо інформацію про зображення
img1_size = size(img1)
img2_size = size(img2)
img3_size = size(img3)
my_img_size = size(my_img)

%% 4. Зберегти зображення в заданий каталог

output_folder = 'D:\images\';
img1_path = 'saved_trees.tif';
img2_path = 'saved_pears.png';
img3_path = 'saved_greens.jpg';

ouput_path1 = fullfile(output_folder, img1_path);
ouput_path2 = fullfile(output_folder, img2_path);
ouput_path3 = fullfile(output_folder, img3_path);

imwrite(img1, ouput_path1);
imwrite(img2, ouput_path2);
imwrite(img3, ouput_path3);
%% 5. Гістограми розподілу яскравостей
if size(my_img, 3) == 3
    my_img_gray = rgb2gray(my_img);
end

imshow(my_img_gray), figure;
imhist(my_img_gray);
title('Гістограма розподілу яскаравостей');
xlabel('Яскравість');
ylabel('К-сть пікселів');
%% 6. Контрастування зображення
close all

img_adj = imadjust(my_img_gray);
imshow(my_img_gray), figure, imshow(img_adj);

%img_adj = imadjust(my_img_gray, [0.3, 0.7], []);
%imshow(my_img_gray), figure, imshow(img_adj);
%% Негатив зображення
close all

img_neg = 255 - my_img_gray;

subplot(1,2,1);
imshow(my_img_gray);
title('Grayscale');

subplot(1,2,2);
imshow(img_neg);
title('Negative');
%% 
close all

%img_adj = imadjust(my_img_gray, [0.2, 0.8], []);
imshow(img_adj);

figure;
imhist(img_adj);
title('Гістограма розподілу яскаравостей');
xlabel('Яскравість');
ylabel('К-сть пікселів');