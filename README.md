## 项目概述

本论文旨在解决生产企业原材料的订购与运输问题(2021 年高教社杯全国大学生数学建模竞赛(CUMCM)C题： 生产企业原材料的订购与运输)，涉及对供应商、订购方案、转运方案等进行综合分析和优化。该企业主要使用木质纤维和其他植物素纤维材料，分为 A、B、C 三种类型。生产周期为 48 周，需提前制定 24 周的原材料订购和转运计划。

## 文件结构

```
CUMCM-2021-C/
│
├── code/                        # 存放解决问题的代码，按问题划分
│   ├── problem1/
│   ├── problem2/
│   ├── problem3/
│   └── problem4/
│
├── data/                        # 存放使用的数据集以及结果
│   ├── problem1/
│   ├── problem2/
│   ├── problem3/
│   └── problem4/
│
├── Drawing_code/                # 包含论文图表绘制代码
│   ├── Problem 1 Drawing of comprehensive evaluation indicators of supply capacity
│   ├── Problem 1 The proportion of raw materials produced by the top 50 suppliers
│   └── Problem 2 Dynamic noise simulation production volume data comparison plot
│
├── paper/                       # 包含完整的论文文本以及竞赛题目
│   ├── CUMCM-2021-C.pdf       
│   ├── Ordering and transportation of raw materials for production enterprises.pdf	
│   └── Ordering and transportation of raw materials for production enterprises.docx
│
├── appendix/                    # 附录
│   ├── Appendix A Ordering Scenario Data Results.csv
│   └── Appendix B Transshipment Programme Data Results.csv
│
└── README.md                    # 本文档，提供有关问题描述、论文摘要以及文件结构等信息
```


## 问题描述

### 问题一

- **目标：** 量化分析供应商的供货特征，确定最重要的50家供应商。
- **方法：** 利用附件1的数据，通过预测产能与平均供货率的综合评价指标筛选供应商。采用循环计算，排除无恶意倾销和库存积压交易，得出供应商最优的供应量。将平均供应率与预测产能的乘积作为供应产能综合评价指标，排序选取前50家供货商。通过柱状图验证了评价模型的合理性。

### 问题二

- **目标：** 确定至少需要选择多少家供应商，制定最经济的原材料订购方案和损耗最少的转运方案。
- 方法：
  1. 以供应商数量最少为目标函数，使用0-1整数规划模型求解最佳供应商数量。
  2. 建立常规线性规划订购方案模型，引入波动率构建动态噪声模型，求解最经济的原材料订购方案。
  3. 以损耗率最小为目标函数，使用0-1规划模型求解最小损耗的转运方案。
  4. 分析订购方案和转运方案的实施效果。

### 问题三

- **目标：** 制定新的订购方案和转运方案，以压缩生产成本。
- **方法：** 优化动态噪声模拟模型循环迭代过程，构建以最少原材料订购量为目标函数的线性规划模型，得到满足企业产能的平均产能为28169.97立方米的订购方案。以损耗率最小为目标函数构建0-1规划模型求解24周损耗率最小的转运方案。

### 问题四

- **目标：** 根据技术改造提高产能潜力，确定未来24周的订购和转运方案。
- **方法：** 构建产能最大为目标函数的整数规划模型，对402家供应商供货率加入动态噪声模拟，模拟出24周产能最大的订购方案。增加矩阵维度，构建整数规划模型求解。

## 数据来源

- 附件1: 近5年402家供应商的订货量和供货量数据。
- 附件2: 8家转运商的运输损耗率数据。

## 论文摘要

随着全球经济的快速发展，各类企业的竞争也越来越大，特别是建筑和装饰板材生产企业，因此通过对企业内部的原材料订货，转运以及供应商的选择等问题进一步规划成为了企业在夹缝中生存的重要手段。

**针对问题一：** 通过预测产能与平均供货率的综合评价指标筛选供应商，首先进行运算，找出无恶意倾销和库存积压交易，循环找到供应商最优的供应量作为该供应商的产能；平均供应率和产能均正向反映了供货商信誉和实际生产水平，故平均供应率与预测产能的乘积作为供应产能综合评价指标，来量化反映供应商的重要程度，将指标值排序选取前50作为最重要的50个供货商；并以50家供应商的评价指标值绘出的柱状图有显著差异，验证了评价模型的合理性。

**针对问题二：** 首先，以供应商数量最少为目标函数，满足企业产能为约束条件，在最重要的50个供货商的基础上使用0-1整数规划模型求解出至少需要19家供货商；其次，先建立常规线性规划订购方案模型，再在此基础上引入波动率，构建由动态噪声影响下的订购方案模型，通过对平均供应率和产能加入噪声，反映实际生产当中的供货率与产能波动，循环调用以最低价格为目标的规划模型求解24周最经济订购原料方案；接着求出上述方案的每周平均产能28293.8立方米，与企业的规定产能误差不到1%，验证了方案的合理性；最后，当企业长期生产经营，转运商损耗率趋近于期望值，故选取损耗率期望值小的转运商承担转运业务。循环嵌套使用以损耗率最小为目标函数的0-1规划模型求解24周损耗率最小的转运方案。

**针对问题三：** 先优化动态噪声模拟模型循环迭代过程：上周供应量S决定本周订单量O。建立以最少原材料订购量为目标函数，并以满足加入优化后噪声影响的企业产能为约束条件的线性规划模型。最终得到的平均产能为28169.97立方米，使得我们在未来24周得到的订单均不相同且都满足企业生产需要；以损耗率最小为目标函数构建0-1规划模型求解24周损耗率最小的转运方案。

**针对问题四：** 构建产能最大为目标函数，转运商运输量为约束条件，对402家供应商供货率加入含波动率的动态噪声，模拟出24周产能最大的订购方案。同第二,三问的转运0-1规划算法相似，在二，三问的基础上增加矩阵维度，构建整数规划模型求解。

**关键字：** **整数规划**   **线性规划**   **动态噪声模拟**   **综合评价指标**     

