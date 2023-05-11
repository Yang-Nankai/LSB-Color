%%%%%%%%%%%%%%%%%%%%��������
% ��ȡԭʼͼ��
img = imread('./output/stegoImg.bmp');

% ���ý����������ܶȣ�������������ռ�ı�����
density = 0.3;

% �����������������λ��
noise_pixels = rand(size(img, 1), size(img, 2));
noise_pixels = noise_pixels < density/2 | noise_pixels > 1-density/2;

% �����λ�õ���������Ϊ��ɫ���ɫ
noise = uint8(255 * (rand(size(img)) > 0.5));
noise(noise == 255) = 1;
noise(noise_pixels) = 0;

% ��ԭʼͼ�������ͼ��ϲ�
noisy_img = img;
noisy_img(noise_pixels) = noise(noise_pixels);

% ��ʾ����ͼ��
imwrite(noisy_img, './Test/noisy_img.bmp', 'bmp')
imshow(noisy_img);
title('���������������ͼ��');

%Ȼ��Դ�����ͼ����н���
key = 123456;
m = extractLSB_RGB(noisy_img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%��������