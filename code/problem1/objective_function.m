clc;
clear;
%----------------------每供应商平均供应率-----------------------------
order = xlsread("C:\Users\PC\Desktop\C\附件1 近5年402家供应商的相关数据.xlsx",1,'C2:IH403');%读取订单数据
supply = xlsread('C:\Users\PC\Desktop\C\附件1 近5年402家供应商的相关数据.xlsx',2,'C2:IH403');%读取供应数据
supply_rate = supply./order;%计算每个供应商每周供应率
supply_rate(isnan(supply_rate) == 1)=1;%将订单量，供应量为0的星期供应率设为100%
average_supply_rate=zeros(402,1);
Add_supply_rate=zeros(402,1);
for i=1:402
   for j=1:240
      Add_supply_rate(i,1)= Add_supply_rate(i,1)+supply_rate(i,j);
   end
   average_supply_rate(i,1)=Add_supply_rate(i,1)/240;
end
%--------------------------产能预测---------------------------------------
capacity=zeros(402,1);%构建产能矩阵
for k=1:402
    capaticy(k,1)=supply(k,1);%将第一周的产能当作当前的产能最大值
end
for i=1:402
    for j=1:240
       if 1.2*order(i,j)>=supply(i,j) && supply(i,j)>capacity(i,1)%
              capacity(i,1)=supply(i,j);   
        end   
    end %提取每供应商满足条件的最大产能           
end
%--------------------------产能处理-----------------------------------
optimized_capacity=zeros(402,1);%构建产能处理矩阵
single_capacity=xlsread("C:\Users\余麋\Desktop\C\附件1 近5年402家供应商的相关数据.xlsx",2,'C2:IH403');
averge_capacity=zeros(402,1);
Add_capacity=zeros(402,1);
for k=1:402
   for j=1:240
       Add_capacity(k,1)=Add_capacity(k,1)+single_capacity(k,j);
   end
   averge_capacity(k,1)=Add_capacity(k,1)./240;
end
    
for i=1:402
    if capacity(i,1)>=3000 
        optimized_capacity(i,1)=averge_capacity(i,1);%
    else 
        optimized_capacity(i,1)=capacity(i,1);%
    end
end

%--------------------------目标函数-----------------------------------
objective__function=zeros(402,2);
for  i=1:402
     objective__function(i,1)=i;%给供应商编号
     objective__function(i,2)= optimized_capacity(i,1).*average_supply_rate(i,1);%计算目标函数值
end
xlswrite('objection', objective__function);%保存目标函数值数据