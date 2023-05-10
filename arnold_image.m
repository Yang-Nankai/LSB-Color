%--------------------------------------------------------------------------
% FILE:         arnold_image.m
% AUTHOR:       [YangXin]
% DATE:         [2023-05-11]
% DESCRIPTION:  Arnold scrambles an image using the given parameters.
%
% INPUTS:
%   img: the input image
%   a: scrambling parameter
%   b: scrambling parameter
%   n: number of scrambling rounds
%
% OUTPUTS:
%   scrambledImg: the scrambled image
%
% NOTES:        This function is compatible with MATLAB R2019a.
%--------------------------------------------------------------------------
function scrambledImg = arnold_image(img, a, b, n)
% 获取输入图像的尺寸
[h, w] = size(img);

% 初始化置乱后的图像
scrambledImg = zeros(h, w);

% 计算置乱矩阵
P = [1, b; a, a*b+1];

% 迭代 n 次进行置乱
for k = 1:n
    for i = 1:h
        for j = 1:w
            % 计算置乱后像素的坐标
            x = mod(P*[i; j], [h; w]);
            if(x(1)==0)
                x(1)=h;
            end
            if(x(2)==0)
                x(2)=w;
            end
            scrambledImg(x(1), x(2)) = img(i, j);
        end
    end
    img = scrambledImg;
end
% 将结果转换为整数类型的图像
scrambledImg = uint8(scrambledImg);

end
