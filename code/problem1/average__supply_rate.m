clc;
clear;
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
xlswrite('average_supply_rate',average_supply_rate);