function [a,b,xyStruct] = RoadArea(img,theta,peakNum)

% 正規化
img(:,:,1) = (img(:,:,1)-min(img(:,:,1)))./(max(img(:,:,1))-min(img(:,:,1)))*256;
%img(:,:,2) = (img(:,:,2)-min(img(:,:,2)))./(max(img(:,:,2))-min(img(:,:,2)))*256;
img(:,:,2) = 0;
img(:,:,3) = (img(:,:,3)-min(img(:,:,3)))./(max(img(:,:,3))-min(img(:,:,3)))*256;

% 差分を取る
dimg = diff(img);

% グレースケール化
grayImg = rgb2gray(dimg);
% 輝度の小さいものを除去する
img(img<200) = 0;

% 大津の二値化の原理を使ってバイナリイメージを作成
BW = edge(grayImg,'canny');

% ハフ変換
[H,T,R] = hough(BW,'Theta',theta);

% ピーク導出
P = houghpeaks(H,peakNum);

% 線データ取得
lines = houghlines(BW,T,R,P);
len = length(lines);% データ長を導く

a = [];
b = [];
xyStruct = struct();
for i = 1:1:len
    
    xyStruct(i).xy = [lines(i).point1; lines(i).point2];
    %傾きを求める
    a = [a; (xyStruct(i).xy(2,2) - xyStruct(i).xy(1,2))...
        / (xyStruct(i).xy(2,1) - xyStruct(i).xy(1,1))];
    b = [b; (xyStruct(i).xy(1,2)-a(i)*xyStruct(i).xy(1,1))];
    
    disp('loop');
end

end

