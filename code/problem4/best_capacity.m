clc;
clear;

noise=0.4.*rand(50,24)-0.2;%��������0.2��Χ�ڵ������
average__supply_rate=xlsread...
 ('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'E2:E51');%��ȡƽ����Ӧ��
capacity_A=xlsread('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'D2:D20');
capacity_B=xlsread('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'D21:D35');
capacity_C=xlsread('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'D36:D51');

puduct=[capacity_A; capacity_B ;capacity_C];%
noise_average__supply_rate = zeros(50,24);%����24��ÿ��Ӧ������ƽ����Ӧ�ʾ���
noise_puduct= zeros(50,24);%����ģ����ܾ���


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
noise_puduct=(noise_puduct)';%ת��
%---------------------------���Թ滮���ÿ���������������---------------
x=zeros(50,24);%ÿ��Ӧ��������Ʒ����ù�Ӧ�̲���������Ʒ����ֵ
fval=zeros(1,24);%��Ӧ������������ȡ����
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
capacity=[capacity_A ;capacity_B;capacity_C]%�ϲ���Ӧ�̲���
 result_of_supply=zeros(50,24);%������Ӧ������
 for g=1:24
     for r=1:50
 result_of_supply(r,g)=capacity(r,1).*x(r,g).*noise_average__supply_rate(r,g);%����ģ�⹩Ӧ�̹�Ӧ��
     end
 end
 xlswrite('best_capicity',result_of_supply);