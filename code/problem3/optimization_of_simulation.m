clc;
clear;
%-----(原2问代码）----------------------数据准备----------------------------
noise=0.4.*rand(50,24)-0.2;%生成正负0.2范围内的随机数
average__supply_rate=xlsread...
('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'E2:E51');%读取平均供应率
capacity_A=xlsread('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'D2:D20');%读取A材料供应商产能
capacity_B=xlsread('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'D21:D35');%读取B材料供应商产能
capacity_C=xlsread('C:\Users\PC\Desktop\数据整合（excel处理）.xls',1,'D36:D51');%读取B材料供应商产能
capacity_A_to_puduct=capacity_A./0.6;%计算每A供应商提供材料所能生产成品量
capacity_B_to_puduct=capacity_B./0.66;%计算每B供应商提供材料所能生产成品量
capacity_C_to_puduct=capacity_C./0.72;%计算每C供应商提供材料所能生产成品量
puduct=[capacity_A_to_puduct; capacity_B_to_puduct ;capacity_C_to_puduct];
%汇总每供应商提供材料所能生产成品量
noise_average__supply_rate = zeros(50,24);%构建24周每供应商噪声平均供应率矩阵
noise_puduct= zeros(50,24);%构建模拟产能矩阵


%-------（新代码）---------------模拟生产量反推模拟供应量---------------
noise_capacity_A=zeros(24,19);
noise_capacity_B=zeros(24,12);
noise_capacity_C=zeros(24,19);
for i=1:19
    for j=1:24
      noise_capacity_A(j,i)=noise_puduct(j,i)./0.6
    end
end
for i=20:31
    for j=1:24
      noise_capacity_B(j,i-19)=noise_puduct(j,i-19)./0.66
    end
end
for i=32:50
    for j=1:24
      noise_capacity_C(j,i-31)=noise_puduct(j,i-31)./0.72
    end
end
noise_capacity=[noise_capacity_A noise_capacity_B noise_capacity_C];


%------------(原2问代码）---------------给平均供应率增加噪声---------------
for i=1:24
   for j=1:50
    noise_average__supply_rate(j,i) = average__supply_rate(j,1)+noise(j,i);
   end
end


%---------------(原2问代码）------------计算24周噪声条件下成品产能-----------
for p=1:24
    for h=1:50
        noise_puduct(h,p)=puduct(h,1).*noise_average__supply_rate(h,p);
    end
end   
noise_puduct=(noise_puduct)';%转置


%------(原2问代码）-----线性规划求解每周最经济供应商供货的产能占比-----
x=zeros(50,24);%每供应商生产成品量与该供应商产能生产成品量比值
fval=zeros(1,24);%供应商数量（向上取整）
e=0.1*rand(1,24);
%---------------（新代码）-----------构建约束条件的0-1逻辑矩阵-------------
c=[ones(1,19) zeros(1,31)];
t=[zeros(1,19) ones(1,12) zeros(1,19)];
d=[zeros(1,31) ones(1,19)];
%--------------（新代码）----------- 构建运输约束条件--------------------
    c1=c.*noise_capacity;
    t1=t.*noise_capacity;
    d1=d.*noise_capacity;
%-------（新代码）-----------循环调用线性规划-------------------------
for k=1:24   
  f=[-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.5;...
      -0.5;-0.5;-0.5;-0.5;-0.5;-0.5;-0.3;-0.3;-0.3;-0.3;-0.3;-0.3;-0.3;...
      -0.3;-0.3;-0.3;-0.3;-0.3;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;...
      -0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2;-0.2];
  A=[-noise_puduct(k,:);noise_puduct(k,:);-c1(k,:);-t1(k,:);-d1(k,:)];
  b=[-1.2*28200;0.8*28200;-6000;-6000;-6000];
  Aeq=[];
  beq=[];
  lb=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;...
      0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
up=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;...
    1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];
  [x(:,k),fval(1,k)]=linprog(f,-A,-b,Aeq,beq,lb,up);
end
%--------------(原2问代码）-----------求解数据处理-------------------
 fval=ceil(fval)%fval 向上取整极为 供货商数量
 capacity=[capacity_A ;capacity_B;capacity_C]%合并供应商产能
 result_of_supply=zeros(50,24);%构建供应量矩阵
 for g=1:24
     for r=1:50
 result_of_supply(r,g)=capacity(r,1).*x(r,g).*noise_average__supply_rate(r,g);%计算模拟供应商供应量
     end
 end
 %--------------（新代码）-------数据保存--------------------------
  xlswrite('three_supply.xls',result_of_supply);%保存数据
  xlswrite('number_of_supply.xls',fval);%保存厂家数量数据