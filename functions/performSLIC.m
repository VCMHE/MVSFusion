
function segmented_image = performSLIC(gray_image)
% gray_image: 输入灰度图像

% 默认参数值
compactness = 30;
n_segments = round(sqrt(numel(gray_image)*100));
%n_segments = 2000;
%fprintf("%d",sqrt(numel(gray_image)*7));
% 进行SLIC超像素分割
[labels, centroids] = superpixels(gray_image, n_segments, 'Compactness', compactness);

% 计算每个超像素块的平均灰度值
avg_gray_values = accumarray(labels(:), gray_image(:), [], @mean);

% 根据每个超像素块的平均灰度值赋值像素
segmented_image = avg_gray_values(labels);

% 转换为uint8类型
segmented_image = uint8(segmented_image);

% 绘制超像素分割线

    %boundaries = drawBoundaries(gray_image, labels);


end


% function boundaries = drawBoundaries(image, labels)
% % 绘制超像素分割线
% 
% % 获取图像尺寸
% [height, width] = size(image);
% 
% % 初始化边界图像
% boundaries = false(height, width);
% 
% % 判断每个像素与相邻像素的标签是否不同
% for y = 2:height-1
%     for x = 2:width-1
%         if labels(y, x) ~= labels(y-1, x) || labels(y, x) ~= labels(y+1, x) ...
%                 || labels(y, x) ~= labels(y, x-1) || labels(y, x) ~= labels(y, x+1)
%             boundaries(y, x) = true;
%         end
%     end
% end
% 
% % 绘制边界线
% % 绘制边界线
% boundaries = bwperim(boundaries);
% 
% % 将边界线图像和原始图像叠加
%     overlay = imoverlay(image, boundaries, [0 0 0]); % 将边界线显示为白色
%     disp("1");
%     % 保存叠加图像
%     imwrite(overlay, 'segmented_image_with_boundaries.png');
% 
% end