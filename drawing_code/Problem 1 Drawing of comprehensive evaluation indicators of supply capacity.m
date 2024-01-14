x =1:50%生成顺序数
y=xlsread("E:\matlab\Problem C\question 1\数据整合（excel处理）.xls",2,'E2:E51');%数据读取
y=y';%转置
bar(x,y,'c');%绘图
title('最重要50个供应产能综合指标');%标题
xlabel('50个供应商');%x坐标
ylabel('供应产能综合指标值')%y坐标
