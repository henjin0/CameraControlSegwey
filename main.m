%% 道路画像から車線を検知し、路面の走行領域を表示する。
clear
close all

% 道路画像を読み込む
%img= imread('黄色実線の車線.jpg');
%img = imread('道路.jpg');
%img = imread('首都高夜.jpg');
%img = imread('トンネル的首都高.jpg');%失敗パターン
%img = imread('真似してはいけないやつ.jpg');
%img = imread('真似してはいけないやつ2.jpg');
img = imread('鹿.jpg');

% ハフ変換のときのシータ
theta1 = [-20:-0.5:-60];
theta2 = [20:0.5:60];
%ρは画像の対角線の長さがそのまま入っている？（半分でよくね？）

% 領域の表示
figure(1)
imshow(img);

% 線分の表示
figure(2)
imshow(img);

%元画像
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

%直線引き
for i = 1:1:length(a)
    % y = ax+b
    y = a(i)*x+b(i);
    
    pl = plot(x,y);
    pl.LineWidth = 2.5;
    pl.Marker = '*';
    hold on
    
end
hold off

%見える化
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

