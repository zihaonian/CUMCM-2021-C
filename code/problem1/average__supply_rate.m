clc;
clear;
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
xlswrite('average_supply_rate',average_supply_rate);