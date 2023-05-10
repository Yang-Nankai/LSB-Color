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
% ��ȡ����ͼ��ĳߴ�
[h, w] = size(img);

% ��ʼ�����Һ��ͼ��
scrambledImg = zeros(h, w);

% �������Ҿ���
P = [1, b; a, a*b+1];

% ���� n �ν�������
for k = 1:n
    for i = 1:h
        for j = 1:w
            % �������Һ����ص�����
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
% �����ת��Ϊ�������͵�ͼ��
scrambledImg = uint8(scrambledImg);

end
