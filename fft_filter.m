filename = 'xiaohui2.jpeg';
img = imread(filename);
img = rgb2gray(img);
%img_o = double(img_o)/255.0;
[lo,wi] = size(img);

img_o = zeros([lo*2,wi*2]);

img_o(round(lo/2+1):round(lo*3/2),round(wi/2+1):round(wi*3/2)) = img;

img_o = uint8(img_o);

img_o_f = fft2(img_o);

img_o_f = fftshift(img_o_f);

for i = 1:lo*2
    for j = 1:wi*2
        if sqrt((i-lo)^2+(j-wi)^2)<=50 | sqrt((i-lo)^2+(j-wi)^2)>=100 %带通滤波器
        %if sqrt((i-lo)^2+(j-wi)^2)>=50 & sqrt((i-lo)^2+(j-wi)^2)<=100 %带阻滤波器
        %if sqrt((i-lo)^2+(j-wi)^2)>=50 %低通滤波器
        %if sqrt((i-lo)^2+(j-wi)^2)<=50 %高通滤波器
            img_o_f(i,j)=0;
        end
    end
end

log_img = log(1+abs(img_o_f));

img_t = ifft2(ifftshift(img_o_f));
img_t = uint8(img_t);

tiledlayout(1,3);
nexttile
imshow(img) %原图
nexttile
imshow(log_img,[]) %频谱
nexttile
imshow(img_t(round(lo/2+1):round(lo*3/2),round(wi/2+1):round(wi*3/2))) %处理后

    