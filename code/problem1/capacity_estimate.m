clc;
clear;
order = xlsread("C:\Users\PC\Desktop\C\附件1 近5年402家供应商的相关数据.xlsx",1,'C2:IH403');%读取订单数据
supply = xlsread('C:\Users\PC\Desktop\C\附件1 近5年402家供应商的相关数据.xlsx',2,'C2:IH403');%读取供应数据
capacity=zeros(402,1);%构建产能预测矩阵
for k=1:402
    capaticy(k,1)=supply(k,1);%将第一周的产能当作当前的产能最大值
end
for i=1:402
    for j=1:240
       if 1.2*order(i,j)>=supply(i,j) &&supply(i,j)>capacity(i,1)%不超过20%的供货可以反应生产水平
              capacity(i,1)=supply(i,j);   
        end   
    end %提取每供应商满足条件的最大产能 
            
end
xlswrite('capacity_estimate.xls', capacity);%保存产能预测数据
