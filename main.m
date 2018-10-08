%% ���H�摜����Ԑ������m���A�H�ʂ̑��s�̈��\������B
clear
close all

% ���H�摜��ǂݍ���
%img= imread('���F�����̎Ԑ�.jpg');
%img = imread('���H.jpg');
%img = imread('��s����.jpg');
%img = imread('�g���l���I��s��.jpg');%���s�p�^�[��
%img = imread('�^�����Ă͂����Ȃ����.jpg');
%img = imread('�^�����Ă͂����Ȃ����2.jpg');
img = imread('��.jpg');

% �n�t�ϊ��̂Ƃ��̃V�[�^
theta1 = [-20:-0.5:-60];
theta2 = [20:0.5:60];
%�ς͉摜�̑Ίp���̒��������̂܂ܓ����Ă���H�i�����ł悭�ˁH�j

% �̈�̕\��
figure(1)
imshow(img);

% �����̕\��
figure(2)
imshow(img);

%���摜
figure(3)
imshow(img);

[a1,b1,xyStruct1] = RoadArea(img,theta1,1);
[a2,b2,xyStruct2] = RoadArea(img,theta2,1);

a = [a1;a2];
b = [b1;b2];
xyStruct = {xyStruct1 xyStruct2};

figure(1)
hold on
scale = size(img);
x = 0:1:scale(1)*2;

%��������
for i = 1:1:length(a)
    % y = ax+b
    y = a(i)*x+b(i);
    
    pl = plot(x,y);
    pl.LineWidth = 2.5;
    pl.Marker = '*';
    hold on
    
end
hold off

%�����鉻
figure(2)
hold on
scale = size(xyStruct);
for i = 1:1:scale(2)
    xy = {xyStruct{i}.xy};
    len = length(xy);
    
    for j = 1:1:len
        xyc = xy{j};
        plc=plot(xyc(:,1),xyc(:,2));
    
        plc.LineWidth = 2.5;
        plc.Marker = '*';
        hold on
    end
end
hold off

