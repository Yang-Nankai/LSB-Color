%%This file is used to attack the alogirthm

%%%%%%%%%%%%%%%%%%%%�߶ȱ任����
% ��ȡԭʼͼ��
img = imread('./output/stegoImg.bmp');

% �Բ�ɫ����ͼ����� 2 ����ֵ
img = imresize(img, 2, 'bicubic');

% �Բ�ֵ���ͼ����� 2 ���²���
img = imresize(img, 0.5, 'bicubic');

% % ��СΪԭͼ�ߴ�
% img = imresize(img, size(img)/2, 'bicubic');

% ��ʾ�任���ͼ��
imwrite(img, './Test/scale_stegoimg.bmp', 'bmp')
imshow(img);
title('�任�������ͼ��');

%Ȼ��Բü����ͼ����н���
key = 123456;
m = extractLSB_RGB(img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%�ü�����
