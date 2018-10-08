%% 道路画像から車線を検知し、路面領域を表示する。
clear
close all

% 道路画像を読み込む
%img= imread('黄色実線の車線.jpg');
%img = imread('道路.jpg');
%img = imread('首都高夜.jpg');
%img = imread('トンネル的首都高.jpg');
%img = imread('真似してはいけないやつ.jpg');
%img = imread('真似してはいけないやつ2.jpg');
img = imread('鹿.jpg');

% 色の表示
figure(1)
imshow(img);

% 正規化
figure(2)
img(:,:,1) = (img(:,:,1)-min(img(:,:,1)))./(max(img(:,:,1))-min(img(:,:,1)))*256;
%img(:,:,2) = (img(:,:,2)-min(img(:,:,2)))./(max(img(:,:,2))-min(img(:,:,2)))*256;
img(:,:,2) = 0;
img(:,:,3) = (img(:,:,3)-min(img(:,:,3)))./(max(img(:,:,3))-min(img(:,:,3)))*256;
imshow(img)

% 輝度を下げる
%figure(3)
%img(img<200) = 0;
%imshow(img)

figure(4)
dimg = diff(img);
imshow(dimg);

% とりあえずグレースケールにしてみる
grayImg = rgb2gray(dimg);
figure(5)
img(img<200) = 0;
imshow(grayImg);

% 大津の二値化の原理を使ってバイナリイメージを作成
%BW = imbinarize(grayImg,'adaptive','ForegroundPolarity','dark','Sensitivity',0.6);
%BW = grayImg > 0.5;
BW = edge(grayImg,'canny');
figure(6)
imshow(BW);

theta1 = [0:-0.5:-60];
theta2 = [0:0.5:60];

% ハフ変換
%[H,T,R] = hough(BW);
[H,T,R] = hough(BW,'Theta',theta1);
%figure(4)
%imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%      'InitialMagnification','fit');

% ピーク導出
figure(7)
P = houghpeaks(H,1);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
scatter(T(P(:,2)),R(P(:,1)));

% 線データ取得
lines = houghlines(BW,T,R,P);
len = length(lines);% データ長を導く
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
    %傾きを求める
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


