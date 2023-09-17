import os
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt
from skimage import io, color, transform
import joblib

# 数据集路径，存放白天和黑夜图片
day_path = "dataset/day/"
night_path = "dataset/night/"

# 加载数据并预处理
def load_data():
    X, y = [], []

    # 加载白天图片
    for filename in os.listdir(day_path):
        if filename.endswith(".png"):
            img = io.imread(os.path.join(day_path, filename))
            img = preprocess_image(img)
            X.append(img)
            y.append(1)  # 白天图片标签为1

    # 加载黑夜图片
    for filename in os.listdir(night_path):
        if filename.endswith(".png"):
            img = io.imread(os.path.join(night_path, filename))
            img = preprocess_image(img)
            X.append(img)
            y.append(0)  # 黑夜图片标签为0

    return np.array(X), np.array(y)

# 图像预处理：将图像转换为灰度图或RGB图，并进行大小调整
def preprocess_image(img):
    if len(img.shape) == 3 and img.shape[-1] == 3:  # RGB图像
        img_resized = transform.resize(img, (100, 100))
        return img_resized.flatten()
    elif len(img.shape) == 2 or (len(img.shape) == 3 and img.shape[-1] == 1):  # 灰度图像
        img_rgb = color.gray2rgb(img)
        img_resized = transform.resize(img_rgb, (100, 100))
        return img_resized.flatten()
    else:
        raise ValueError("Invalid image format. Expected RGB or grayscale image.")

# 主函数
def main():
    # 加载数据
    X, y = load_data()

    # 划分训练集和测试集
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # 创建支持向量机分类器
    classifier = SVC(kernel='linear')

    # 训练分类器
    classifier.fit(X_train, y_train)

    # 在测试集上进行预测
    y_pred = classifier.predict(X_test)

    # 计算准确率
    accuracy = accuracy_score(y_test, y_pred)
    print("Accuracy:", accuracy)

    # 保存训练好的模型
    model_filename = "trained_svm_model.pkl"
    joblib.dump(classifier, model_filename)
    print(f"Trained model saved as {model_filename}")

    # 可视化结果
    plt.figure(figsize=(10, 4))
    for i in range(5):
        plt.subplot(1, 5, i + 1)
        plt.imshow(X_test[i].reshape((100, 100, 3)))
        plt.title("Day" if y_pred[i] == 1 else "Night")
        plt.axis('off')
    plt.show()

if __name__ == "__main__":
    main()
