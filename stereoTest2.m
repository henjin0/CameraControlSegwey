clear

% 視差画像を取得する
%nI1 = imread('scene_left.png');
%nI2 = imread('scene_right.png');
nI1 = imread('im2.png');
nI2 = imread('im6.png');
figure(1)
imshow(nI1);

I1 = rgb2gray(nI1);
I2 = rgb2gray(nI2);

% 画像を比較する。
figure(2)
stAnag = stereoAnaglyph(I1,I2);
imshow(stAnag);

disparityRange = [-48,48];%視差のギャップの大きさに関するレンジ 
disparityMap = disparity(I1,I2,...
    'BlockSize',13,'DisparityRange',disparityRange);

figure(3)
imshow(disparityMap,disparityRange)
colormap(gca,jet)
colorbar

