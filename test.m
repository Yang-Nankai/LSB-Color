%%Test
% 
% x = imread('./Image/Baboon.bmp');
% x = imresize(x,[512,512]);
% figure
% imshow(x);
% title('Original Image')

%%Arnlod
% 
% y = arnold_image(x, 1, 2, 10);
% figure
% imshow(y);
% title('Arnold One Image')
% 
% z = unarnold_image(y, 1, 2, 10);
% figure
% imshow(z);
% title('Unarnold One Image')

%Logistic

% y = logistic_encrypt(x);
% figure
% imshow(y);
% title('logistic encrypt');
% 
% z = logistic_decrypt(y);
% figure
% imshow(z);
% title('unlogistic decrypt');

x = imread('./Image/Baboon.bmp');
x = imresize(x,[512,512]);

y = imread('./Image/Colour.bmp');
y = imresize(y,[1024,786]);
imwrite(y, './output/orignalImg.bmp','bmp')

key = 123456;
key1 = 123457;
z = embedLSB_RGB(y,x,key,1,2,10,3.769947,0.75,50);
figure
imshow(z);
title('encrypt');

m = extractLSB_RGB(z,512,512,key,1,2,10,3.769947,0.75,50);

