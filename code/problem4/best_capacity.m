clc;
clear;

noise=0.4.*rand(50,24)-0.2;%生成正负0.2范围内的随机数
average__supply_rate=xlsread...
 ('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'E2:E51');%读取平均供应率
capacity_A=xlsread('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'D2:D20');
capacity_B=xlsread('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'D21:D35');
capacity_C=xlsread('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'D36:D51');

puduct=[capacity_A; capacity_B ;capacity_C];%
noise_average__supply_rate = zeros(50,24);%构建24周每供应商噪声平均供应率矩阵
noise_puduct= zeros(50,24);%构建模拟产能矩阵


for i=1:24
    for j=1:50
    noise_average__supply_rate(j,i) = average__supply_rate(j,1)+noise(j,i);
    end
end

for p=1:24
    for h=1:50
        noise_puduct(h,p)=puduct(h,1).*noise_average__supply_rate(h,p);
    end
end   
noise_puduct=(noise_puduct)';%转置
%---------------------------线性规划求解每周最大生产量方案---------------
x=zeros(50,24);%每供应商生产成品量与该供应商产能生产成品量比值
fval=zeros(1,24);%供应商数量（向上取整）
e=0.1*rand(1,24);
for k=1:24   
  f=[-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;...
      -1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;-1/0.6;...
      -1/0.6;-1/0.66;-1/0.66;-1/0.66;-1/0.66;-1/0.66;-1/0.66;-1/0.66;...
      -1/0.66;-1/0.66;-1/0.66;-1/0.66;-1/0.66;-1/0.66;-1/0.66;];
  A=[-noise_puduct(k,:);noise_puduct(k,:)];
b=[-18000;(0.8+e(1,k))*28200];
  Aeq=[];
  beq=[];
  lb=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;...
      0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
up=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;...
    1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];
  [x(:,k),fval(1,k)]=linprog(f,A,b,Aeq,beq,lb,up);
end
capacity=[capacity_A ;capacity_B;capacity_C]%合并供应商产能
 result_of_supply=zeros(50,24);%构建供应量矩阵
 for g=1:24
     for r=1:50
 result_of_supply(r,g)=capacity(r,1).*x(r,g).*noise_average__supply_rate(r,g);%计算模拟供应商供应量
     end
 end
 xlswrite('best_capicity',result_of_supply);