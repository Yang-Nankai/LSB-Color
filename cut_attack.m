%%This file is used to attack the alogirthm

%%%%%%%%%%%%%%%%%%%%�ü�����
% ��ȡԭʼͼ��
img = imread('./output/stegoImg.bmp');

% ���òü��������ʼ����Ϳ�ȡ��߶�
x = 100;
y = 100;
w = 500;
h = 500;

% ���ü�����֮�ڵĲ�������Ϊ��ɫ
img(y:y+h-1, x:x+w-1, :) = 0;

% ��ʾ�ü����ͼ��
imwrite(img, './Test/cut_stegoimg.bmp', 'bmp')
imshow(img);
title('�ü��������ͼ��');

%Ȼ��Բü����ͼ����н���
key = 123456;
m = extractLSB_RGB(img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%�ü�����
