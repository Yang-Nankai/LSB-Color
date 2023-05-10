function secretImg = extractLSB_RGB(coverImg, h, w, key)

% ��ȡͼ���С����Ƕ��ͼ���С
[m, n, ~] = size(coverImg);

coverImg = im2uint8(coverImg);

% ��ȡ������� xkey �� ykey
key = int32(key);

rng(key);
xkey = randperm(m, h);
ykey = randperm(n, w);

% ����RGBͼ�������ͨ��
R_Vec = coverImg(:,:,1);
G_Vec = coverImg(:,:,2);
B_Vec = coverImg(:,:,3);

wme_8 = zeros(h,w);
wme_7 = zeros(h,w);
wme_6 = zeros(h,w);
wme_5 = zeros(h,w);
wme_4 = zeros(h,w);
wme_3 = zeros(h,w);
wme_2 = zeros(h,w);
wme_1 = zeros(h,w);

% �õ����ܵ��������
for i=1:h
    for j=1:w
        wme_8(i,j)=bitget(R_Vec(xkey(i),ykey(j)), 4);
        wme_5(i,j)=bitget(R_Vec(xkey(i),ykey(j)), 3);
        wme_7(i,j)=bitget(G_Vec(xkey(i),ykey(j)), 4);
        wme_4(i,j)=bitget(G_Vec(xkey(i),ykey(j)), 3);
        wme_6(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 4);
        wme_3(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 3);
        wme_2(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 2);
        wme_1(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 1);
    end
end


% ���õ���λƽ���������
% ��ÿ��λƽ��������Ӧ��λ��
img_1 = uint8(bitshift(wme_8, 7));
img_2 = uint8(bitshift(wme_7, 6));
img_3 = uint8(bitshift(wme_6, 5));
img_4 = uint8(bitshift(wme_5, 4));
img_5 = uint8(bitshift(wme_4, 3));
img_6 = uint8(bitshift(wme_3, 2));
img_7 = uint8(bitshift(wme_2, 1));
img_8 = uint8(wme_1);

% ʹ�� bitor ���������е�λƽ����ϳ�һ������
secretImg = bitor(bitor(bitor(bitor(bitor(bitor(bitor(img_1, img_2), img_3), img_4), img_5), img_6), img_7), img_8);

%��ͼ�����Arnold�û�������Logistic�������
secretImg = logistic_decrypt(secretImg);
secretImg = unarnold_image(secretImg, 1, 2, 10);

imwrite(secretImg, './output/decrypt_secret.bmp', 'bmp');
figure
imshow(secretImg,[])
title('decrypt_secret');

end