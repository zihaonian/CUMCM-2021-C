clc;
clear;
order = xlsread("C:\Users\PC\Desktop\C\����1 ��5��402�ҹ�Ӧ�̵��������.xlsx",1,'C2:IH403');%��ȡ��������
supply = xlsread('C:\Users\PC\Desktop\C\����1 ��5��402�ҹ�Ӧ�̵��������.xlsx',2,'C2:IH403');%��ȡ��Ӧ����
capacity=zeros(402,1);%��������Ԥ�����
for k=1:402
    capaticy(k,1)=supply(k,1);%����һ�ܵĲ��ܵ�����ǰ�Ĳ������ֵ
end
for i=1:402
    for j=1:240
       if 1.2*order(i,j)>=supply(i,j) &&supply(i,j)>capacity(i,1)%������20%�Ĺ������Է�Ӧ����ˮƽ
              capacity(i,1)=supply(i,j);   
        end   
    end %��ȡÿ��Ӧ������������������ 
            
end
xlswrite('capacity_estimate.xls', capacity);%�������Ԥ������
