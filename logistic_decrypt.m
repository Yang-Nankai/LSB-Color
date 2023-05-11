%--------------------------------------------------------------------------
% FILE:         logistic_decrypt.m
% AUTHOR:       [YangXin]
% DATE:         [2023-05-10]
% DESCRIPTION:  Logistic unscrambles a scrambled image using the given parameters
%
% INPUTS:
%   encryptedImg: the input scrambled image
%   r: scrambling parameter
%   x: scrambling parameter
%   iter: number of unscrambling rounds 
%
% OUTPUTS:
%   decryptedImg: the unscrambled image
%
% NOTES:        This function is compatible with MATLAB R2013a.
%--------------------------------------------------------------------------
function decryptedImg = logistic_decrypt(encryptedImg, r, x, iter)
if nargin < 4, iter = 50; end
if nargin < 3, x = 0.75; end
if nargin < 2, r = 3.769947; end

% 获取加密图像的尺寸
[m, n] = size(encryptedImg);

%迭代iter次，达到充分混沌状态
for i=1:iter
    x = r * x * (1 - x); 
end

% 初始化混沌序列
chaosSeq = zeros(1, m * n);
chaosSeq(1)=x;
for i = 1:m * n - 1
    chaosSeq(i+1) = r * chaosSeq(i) * (1 - chaosSeq(i));
end

% 将混沌序列映射到像素值范围内
chaosSeq = uint8(chaosSeq * 255);

% 将混沌序列变换为与加密图像相同的尺寸
chaosSeq = reshape(chaosSeq, m, n);

% 对加密图像进行异或操作，生成解密后的图像
decryptedImg = bitxor(encryptedImg, chaosSeq);
end
