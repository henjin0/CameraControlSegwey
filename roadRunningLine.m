%% ���H�摜����Ԑ������m���A�H�ʗ̈��\������B
clear
close all

% ���H�摜��ǂݍ���
%img= imread('���F�����̎Ԑ�.jpg');
%img = imread('���H.jpg');
%img = imread('��s����.jpg');
%img = imread('�g���l���I��s��.jpg');
%img = imread('�^�����Ă͂����Ȃ����.jpg');
%img = imread('�^�����Ă͂����Ȃ����2.jpg');
img = imread('��.jpg');

% �F�̕\��
figure(1)
imshow(img);

% ���K��
figure(2)
img(:,:,1) = (img(:,:,1)-min(img(:,:,1)))./(max(img(:,:,1))-min(img(:,:,1)))*256;
%img(:,:,2) = (img(:,:,2)-min(img(:,:,2)))./(max(img(:,:,2))-min(img(:,:,2)))*256;
img(:,:,2) = 0;
img(:,:,3) = (img(:,:,3)-min(img(:,:,3)))./(max(img(:,:,3))-min(img(:,:,3)))*256;
imshow(img)

% �P�x��������
%figure(3)
%img(img<200) = 0;
%imshow(img)

figure(4)
dimg = diff(img);
imshow(dimg);

% �Ƃ肠�����O���[�X�P�[���ɂ��Ă݂�
grayImg = rgb2gray(dimg);
figure(5)
img(img<200) = 0;
imshow(grayImg);

% ��Â̓�l���̌������g���ăo�C�i���C���[�W���쐬
%BW = imbinarize(grayImg,'adaptive','ForegroundPolarity','dark','Sensitivity',0.6);
%BW = grayImg > 0.5;
BW = edge(grayImg,'canny');
figure(6)
imshow(BW);

theta1 = [0:-0.5:-60];
theta2 = [0:0.5:60];

% �n�t�ϊ�
%[H,T,R] = hough(BW);
[H,T,R] = hough(BW,'Theta',theta1);
%figure(4)
%imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%      'InitialMagnification','fit');

% �s�[�N���o
figure(7)
P = houghpeaks(H,1);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
scatter(T(P(:,2)),R(P(:,1)));

% ���f�[�^�擾
lines = houghlines(BW,T,R,P);
len = length(lines);% �f�[�^���𓱂�
figure(6)
hold on
for i = 1:1:len
     xy = [lines(i).point1; lines(i).point2];
    pl = plot(xy(:,1),xy(:,2));
    pl.LineWidth = 2.5;
    pl.Marker = '*';
    hold on
end
hold off


figure(1)
hold on
for i = 1:1:len
   
    xy = [lines(i).point1; lines(i).point2];
    %�X�������߂�
    a = (xy(2,2) - xy(1,2)) / (xy(2,1) - xy(1,1));
    b = (xy(1,2)-a*xy(1,1));
    
    x = 0:1:1280;
    % y = ax+b
    y = a*x+b;
    
    
    pl = plot(x,y);
    pl.LineWidth = 2.5;
    pl.Marker = '*';
    hold on
end
hold off


