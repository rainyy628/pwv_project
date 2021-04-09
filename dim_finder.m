function [d] = dim_finder(img_name) 
%传入格式为‘name.jpg/png/bmp’
%返回d单位为1像素点
%部分命名比较随意

%clc,clear,close all; 
d = 0;

ori_img = imread(img_name);    %读取图片
gray_img = rgb2gray(ori_img);
thr_img = imbinarize(gray_img);    %二值化

A = thr_img;
B = sum(A,2);   %图像每行黑点数相加
tmp_1 = (max(max(B))+min(min(B)))/2;
for i = 1:size(A,1)    %每行黑点数大于最大值和最小值的一半则认为是非信号区
    if B(i) <= tmp_1       
        A(i,:) = 0;
    else 
        A(i,:) = 1;
    end
end

C = A(:,1);    %提取A的第一列
flr = [1;1;1];    %flr为结构元素
C = imerode(C,flr);
C = imdilate(C,flr);      %图像偶有干扰细线，腐蚀膨胀去除
n = floor(size(C,1)/2);    %floor为向下取整

while C(n,1) == 0
    n = n+1;
    d = d+1;
end
n = floor(size(C,1)/2)-1;
while C(n,1) == 0
    n = n-1;
    d = d+1;
end
%%%%%输出原始、二值化、初步估算图片、最终图
figure;
imshow(ori_img);
figure;
imshow(thr_img);
figure;
imshow(A);
C = [C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C,C];
figure;
imshow(C);
% clc,clear,close all; 
end

