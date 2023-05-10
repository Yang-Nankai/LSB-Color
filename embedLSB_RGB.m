function stegoImg = embedLSB_RGB(coverImg, secretImg, key)

% 获取图像大小及待嵌入图像大小
[m, n, ~] = size(coverImg);
[h, w, ~] = size(secretImg);

coverImg = im2uint8(coverImg);
secretImg = im2uint8(secretImg);

%对图像进行Arnold置换与Logistic混沌加密
secretImg = arnold_image(secretImg, 1, 2, 10);
secretImg = logistic_encrypt(secretImg);

% 获取随机序列 xkey 和 ykey
key = int32(key);

rng(key);
xkey = randperm(m, h);
ykey = randperm(n, w);

% 分离RGB图像的三个通道
R_Vec = coverImg(:,:,1);
G_Vec = coverImg(:,:,2);
B_Vec = coverImg(:,:,3);

% 将水印图像分解为8个位平面
wm_1 = bitget(secretImg, 1);
wm_2 = bitget(secretImg, 2);
wm_3 = bitget(secretImg, 3);
wm_4 = bitget(secretImg, 4);
wm_5 = bitget(secretImg, 5);
wm_6 = bitget(secretImg, 6);
wm_7 = bitget(secretImg, 7);
wm_8 = bitget(secretImg, 8);

% 循环将秘密图像按照随机序列嵌入到彩色图像中
for i=1:h
    for j=1:w
        R_Vec(xkey(i),ykey(j)) = bitset(R_Vec(xkey(i),ykey(j)), 4, wm_8(i,j));
        R_Vec(xkey(i),ykey(j)) = bitset(R_Vec(xkey(i),ykey(j)), 3, wm_5(i,j));
        G_Vec(xkey(i),ykey(j)) = bitset(G_Vec(xkey(i),ykey(j)), 4, wm_7(i,j));
        G_Vec(xkey(i),ykey(j)) = bitset(G_Vec(xkey(i),ykey(j)), 3, wm_4(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 4, wm_6(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 3, wm_3(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 2, wm_2(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 1, wm_1(i,j));
    end
end

% 将嵌入信息后的列向量转换为 RGB 彩色图像矩阵
stegoImg = cat(3,R_Vec,G_Vec,B_Vec);
imwrite(stegoImg, './output/stegoImg.bmp', 'bmp');
figure
imshow(stegoImg,[])
title('stegoImg');
end