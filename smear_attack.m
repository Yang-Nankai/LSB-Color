%%This file is used to attack the alogirthm

%%%%%%%%%%%%%%%%%%%%ͿĨ����
% ��ȡԭʼͼ��
img = imread('./output/stegoImg.bmp');

% ���ò�������״ͿĨ����������
x = [100 150 200 250 300 350 400 450];
y = [100 150 200 250 300 250 200 150];

% ����һ����ֵ�������֣���ʾ��������״
mask = poly2mask(x, y, size(img, 1), size(img, 2));

% ����������״�����ڵĲ�������Ϊ��ɫ
img(repmat(mask, [1, 1, size(img, 3)])) = 0;

% ��ʾͿĨ���ͼ��
imwrite(img, './Test/smear_stegoimg.bmp', 'bmp')
imshow(img);
title('ͿĨ�������ͼ��');

%Ȼ���ͿĨ���ͼ����н���
key = 123456;
m = extractLSB_RGB(img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%ͿĨ����
