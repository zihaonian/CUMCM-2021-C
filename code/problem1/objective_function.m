clc;
clear;
%----------------------ÿ��Ӧ��ƽ����Ӧ��-----------------------------
order = xlsread("C:\Users\PC\Desktop\C\����1 ��5��402�ҹ�Ӧ�̵��������.xlsx",1,'C2:IH403');%��ȡ��������
supply = xlsread('C:\Users\PC\Desktop\C\����1 ��5��402�ҹ�Ӧ�̵��������.xlsx',2,'C2:IH403');%��ȡ��Ӧ����
supply_rate = supply./order;%����ÿ����Ӧ��ÿ�ܹ�Ӧ��
supply_rate(isnan(supply_rate) == 1)=1;%������������Ӧ��Ϊ0�����ڹ�Ӧ����Ϊ100%
average_supply_rate=zeros(402,1);
Add_supply_rate=zeros(402,1);
for i=1:402
   for j=1:240
      Add_supply_rate(i,1)= Add_supply_rate(i,1)+supply_rate(i,j);
   end
   average_supply_rate(i,1)=Add_supply_rate(i,1)/240;
end
%--------------------------����Ԥ��---------------------------------------
capacity=zeros(402,1);%�������ܾ���
for k=1:402
    capaticy(k,1)=supply(k,1);%����һ�ܵĲ��ܵ�����ǰ�Ĳ������ֵ
end
for i=1:402
    for j=1:240
       if 1.2*order(i,j)>=supply(i,j) && supply(i,j)>capacity(i,1)%
              capacity(i,1)=supply(i,j);   
        end   
    end %��ȡÿ��Ӧ������������������           
end
%--------------------------���ܴ���-----------------------------------
optimized_capacity=zeros(402,1);%�������ܴ������
single_capacity=xlsread("C:\Users\����\Desktop\C\����1 ��5��402�ҹ�Ӧ�̵��������.xlsx",2,'C2:IH403');
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

%--------------------------Ŀ�꺯��-----------------------------------
objective__function=zeros(402,2);
for  i=1:402
     objective__function(i,1)=i;%����Ӧ�̱��
     objective__function(i,2)= optimized_capacity(i,1).*average_supply_rate(i,1);%����Ŀ�꺯��ֵ
end
xlswrite('objection', objective__function);%����Ŀ�꺯��ֵ����