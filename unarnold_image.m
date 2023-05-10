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
% ��ȡ����ͼ��ĳߴ�
[h, w] = size(img);

% ��ʼ��ԭʼͼ��
originalImg = zeros(h, w);

% �������Ҿ���������
P_inv = [a*b+1, -b; -a, 1];

% ���� n �ν��н���
for k = 1:n
    for i = 1:h
        for j = 1:w
            % ������ܺ����ص�����
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
% �����ת��Ϊ�������͵�ͼ��
originalImg = uint8(originalImg);

end
