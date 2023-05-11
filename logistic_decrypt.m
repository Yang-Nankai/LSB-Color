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

% ��ȡ����ͼ��ĳߴ�
[m, n] = size(encryptedImg);

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

% ���������б任Ϊ�����ͼ����ͬ�ĳߴ�
chaosSeq = reshape(chaosSeq, m, n);

% �Լ���ͼ����������������ɽ��ܺ��ͼ��
decryptedImg = bitxor(encryptedImg, chaosSeq);
end
