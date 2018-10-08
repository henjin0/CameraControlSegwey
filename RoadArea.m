function [a,b,xyStruct] = RoadArea(img,theta,peakNum)

% ���K��
img(:,:,1) = (img(:,:,1)-min(img(:,:,1)))./(max(img(:,:,1))-min(img(:,:,1)))*256;
%img(:,:,2) = (img(:,:,2)-min(img(:,:,2)))./(max(img(:,:,2))-min(img(:,:,2)))*256;
img(:,:,2) = 0;
img(:,:,3) = (img(:,:,3)-min(img(:,:,3)))./(max(img(:,:,3))-min(img(:,:,3)))*256;

% ���������
dimg = diff(img);

% �O���[�X�P�[����
grayImg = rgb2gray(dimg);
% �P�x�̏��������̂���������
img(img<200) = 0;

% ��Â̓�l���̌������g���ăo�C�i���C���[�W���쐬
BW = edge(grayImg,'canny');

% �n�t�ϊ�
[H,T,R] = hough(BW,'Theta',theta);

% �s�[�N���o
P = houghpeaks(H,peakNum);

% ���f�[�^�擾
lines = houghlines(BW,T,R,P);
len = length(lines);% �f�[�^���𓱂�

a = [];
b = [];
xyStruct = struct();
for i = 1:1:len
    
    xyStruct(i).xy = [lines(i).point1; lines(i).point2];
    %�X�������߂�
    a = [a; (xyStruct(i).xy(2,2) - xyStruct(i).xy(1,2))...
        / (xyStruct(i).xy(2,1) - xyStruct(i).xy(1,1))];
    b = [b; (xyStruct(i).xy(1,2)-a(i)*xyStruct(i).xy(1,1))];
    
    disp('loop');
end

end

