function [d] = dim_finder(img_name) 
%�����ʽΪ��name.jpg/png/bmp��
%����d��λΪ1���ص�
%���������Ƚ�����

%clc,clear,close all; 
d = 0;

ori_img = imread(img_name);    %��ȡͼƬ
gray_img = rgb2gray(ori_img);
thr_img = imbinarize(gray_img);    %��ֵ��

A = thr_img;
B = sum(A,2);   %ͼ��ÿ�кڵ������
tmp_1 = (max(max(B))+min(min(B)))/2;
for i = 1:size(A,1)    %ÿ�кڵ����������ֵ����Сֵ��һ������Ϊ�Ƿ��ź���
    if B(i) <= tmp_1       
        A(i,:) = 0;
    else 
        A(i,:) = 1;
    end
end

C = A(:,1);    %��ȡA�ĵ�һ��
flr = [1;1;1];    %flrΪ�ṹԪ��
C = imerode(C,flr);
C = imdilate(C,flr);      %ͼ��ż�и���ϸ�ߣ���ʴ����ȥ��
n = floor(size(C,1)/2);    %floorΪ����ȡ��

while C(n,1) == 0
    n = n+1;
    d = d+1;
end
n = floor(size(C,1)/2)-1;
while C(n,1) == 0
    n = n-1;
    d = d+1;
end
%%%%%���ԭʼ����ֵ������������ͼƬ������ͼ
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

