%--------------------------------------------------------------------------
% FILE:         logistic_encrypt.m
% AUTHOR:       [YangXin]
% DATE:         [2023-05-10]
% DESCRIPTION:  Logistic scrambles a image using the given parameters
%
% INPUTS:
%   originalImg: the input image
%   r: scrambling parameter
%   x: scrambling parameter
%   iter: number of scrambling rounds 
%
% OUTPUTS:
%   encryptedImg: the encrypted image
%
% NOTES:        This function is compatible with MATLAB R2013a.
%--------------------------------------------------------------------------
function encryptedImg = logistic_encrypt(originalImg, r, x, iter)
if nargin < 4, iter = 50; end
if nargin < 3, x = 0.75; end
if nargin < 2, r = 3.769947; end

% ��ȡԭʼͼ��ĳߴ�
[m, n] = size(originalImg);

%����iter�Σ��ﵽ��ֻ���״̬
for i=1:iter
    x = r * x * (1 - x); 
end

% ��ʼ����������
chaosSeq = zeros(1, m * n);
chaosSeq(1)=x;
for i = 1:m * n - 1
    chaosSeq(i+1) = r * chaosSeq(i) * (1 - chaosSeq(i));
end

% ����������ӳ�䵽����ֵ��Χ��
chaosSeq = uint8(chaosSeq * 255);

% ���������б任Ϊ��ԭʼͼ����ͬ�ĳߴ�
chaosSeq = reshape(chaosSeq, m, n);

% ��ԭʼͼ����������������ɼ��ܺ��ͼ��
encryptedImg = bitxor(originalImg, chaosSeq);
end
