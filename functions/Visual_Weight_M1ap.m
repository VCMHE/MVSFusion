function out = Visual_Weight_M1ap(I)

img=uint8(255*I);
[count, x] = imhist(img);
Sal_Tab = zeros(256,1);
for j=0:255,
    for i=0:255,
        diff = j - i;
        if diff >= 0
            Sal_Tab(j+1) = Sal_Tab(j+1) + count(i+1) * diff;%count 有多少个满足条件的加上开始的值
        end
    end      
end
out=zeros(size(img));

for i=0:255,
    out(img==i)=Sal_Tab(i+1);
end 
out=mat2gray(out);
% figure,imshow(out);
end
