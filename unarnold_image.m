%--------------------------------------------------------------------------
% FILE:         unarnold_image.m
% AUTHOR:       [YangXin]
% DATE:         [2023-05-10]
% DESCRIPTION:  Unscrambles a scrambled image using the given parameters
%
% INPUTS:
%   img: the input scrambled image
%   a: scrambling parameter
%   b: scrambling parameter
%   n: number of unscrambling rounds 
%
% OUTPUTS:
%   originalImg: the unscrambled image
%
% NOTES:        This function is compatible with MATLAB R2013a.
%--------------------------------------------------------------------------

function originalImg = unarnold_image(img, a, b, n)
% 获取置乱图像的尺寸
[h, w] = size(img);

% 初始化原始图像
originalImg = zeros(h, w);

% 计算置乱矩阵的逆矩阵
P_inv = [a*b+1, -b; -a, 1];

% 迭代 n 次进行解密
for k = 1:n
    for i = 1:h
        for j = 1:w
            % 计算解密后像素的坐标
            x = mod(P_inv*[i; j], [h; w]);
            if(x(1)==0)
                x(1)=h;
            end
            if(x(2)==0)
                x(2)=w;
            end
            originalImg(x(1), x(2)) = img(i, j);
        end
    end
    img = originalImg;
end
% 将结果转换为整数类型的图像
originalImg = uint8(originalImg);

end
