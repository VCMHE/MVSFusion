import os
import numpy as np
from sklearn.svm import SVC
from skimage import io, color, transform
import joblib

# 图像预处理：将图像转换为RGB图像并进行大小调整
def preprocess_image(img):
    if len(img.shape) == 2 or (len(img.shape) == 3 and img.shape[-1] == 1):  # 灰度图像
        img_rgb = color.gray2rgb(img)  # 将灰度图像转换为RGB图像
        img_resized = transform.resize(img_rgb, (100, 100))
        return img_resized.flatten()
    elif len(img.shape) == 3 and img.shape[-1] == 3:  # 彩色图像
        img_resized = transform.resize(img, (100, 100))
        return img_resized.flatten()
    else:
        raise ValueError("Invalid image format. Expected RGB or grayscale image.")

# 加载训练好的模型
model = joblib.load('trained_svm_model.pkl')

# 准备要测试的数据
test_data_path = "test_data/"  # 测试数据所在文件夹路径
test_data = []

# 加载测试数据并进行预处理
try:
    predicted_labels = []

    # 从 1 到 21 读取文件名
    for i in range(1, 22):
        filename = f"VIS ({i}).png"
        img = io.imread(os.path.join(test_data_path, filename))
        preprocessed_img = preprocess_image(img)
        label = model.predict([preprocessed_img])[0]
        predicted_labels.append(label)

    # 输出原始的预测标签列表
    print(predicted_labels)

    # 生成标签文件
    with open("predicted_labels.txt", "w") as file:
        for label in predicted_labels:
            file.write(f"{label}\n")

except Exception as e:
    print("发生错误：", str(e))
