x=1:24;%生成顺序数
y=xlsread('C:\Users\PC\Desktop\数据整合2（excel处理）.xlsx',3,'B2:Y2');
%数据读取
x1=-2:0.3:30
bar(x,y,'g');
hold on;%保持图窗
y1=28200;
plot(x1,y1,'r.');%绘制点线
hold on;
plot(x,y,'.-k');
hold on;
title('预测生产量和要求生产量对比');%标题
xlebal('周次')%x坐标
ylebal('生产量')%y坐标

