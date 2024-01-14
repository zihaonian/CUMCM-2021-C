clc;
clear;
capacity= xlsread("E:\matlab\data\1\capacity_estimate.xls"','A1:A402');%读取产能预测数据
optimized_capacity=zeros(402,1);%构建产能处理矩阵
single_capacity=xlsread("C:\Users\PC\Desktop\C\附件1 近5年402家供应商的相关数据.xlsx",2,'C2:IH403');
averge_capacity=zeros(402,1);
Add_capacity=zeros(402,1);
for k=1:402
   for j=1:240
       Add_capacity(k,1)=Add_capacity(k,1)+single_capacity(k,j);
   end
   averge_capacity(k,1)=Add_capacity(k,1)./240;
end
    
for i=1:402
    if capacity(i,1)>=1500
        optimized_capacity(i,1)=averge_capacity(i,1);%
    else 
        optimized_capacity(i,1)=capacity(i,1);%
    end
end
xlswrite('optimization of capacity',optimized_capacity);%保存处理了的产能数据
        