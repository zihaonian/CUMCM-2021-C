clc;
clear;
%-----(ԭ2�ʴ��룩----------------------����׼��----------------------------
noise=0.4.*rand(50,24)-0.2;%��������0.2��Χ�ڵ������
average__supply_rate=xlsread...
('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'E2:E51');%��ȡƽ����Ӧ��
capacity_A=xlsread('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'D2:D20');%��ȡA���Ϲ�Ӧ�̲���
capacity_B=xlsread('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'D21:D35');%��ȡB���Ϲ�Ӧ�̲���
capacity_C=xlsread('C:\Users\PC\Desktop\�������ϣ�excel����.xls',1,'D36:D51');%��ȡB���Ϲ�Ӧ�̲���
capacity_A_to_puduct=capacity_A./0.6;%����ÿA��Ӧ���ṩ��������������Ʒ��
capacity_B_to_puduct=capacity_B./0.66;%����ÿB��Ӧ���ṩ��������������Ʒ��
capacity_C_to_puduct=capacity_C./0.72;%����ÿC��Ӧ���ṩ��������������Ʒ��
puduct=[capacity_A_to_puduct; capacity_B_to_puduct ;capacity_C_to_puduct];
%����ÿ��Ӧ���ṩ��������������Ʒ��
noise_average__supply_rate = zeros(50,24);%����24��ÿ��Ӧ������ƽ����Ӧ�ʾ���
noise_puduct= zeros(50,24);%����ģ����ܾ���


%-------���´��룩---------------ģ������������ģ�⹩Ӧ��---------------
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


%------------(ԭ2�ʴ��룩---------------��ƽ����Ӧ����������---------------
for i=1:24
   for j=1:50
    noise_average__supply_rate(j,i) = average__supply_rate(j,1)+noise(j,i);
   end
end


%---------------(ԭ2�ʴ��룩------------����24�����������³�Ʒ����-----------
for p=1:24
    for h=1:50
        noise_puduct(h,p)=puduct(h,1).*noise_average__supply_rate(h,p);
    end
end   
noise_puduct=(noise_puduct)';%ת��


%------(ԭ2�ʴ��룩-----���Թ滮���ÿ����ù�Ӧ�̹����Ĳ���ռ��-----
x=zeros(50,24);%ÿ��Ӧ��������Ʒ����ù�Ӧ�̲���������Ʒ����ֵ
fval=zeros(1,24);%��Ӧ������������ȡ����
e=0.1*rand(1,24);
%---------------���´��룩-----------����Լ��������0-1�߼�����-------------
c=[ones(1,19) zeros(1,31)];
t=[zeros(1,19) ones(1,12) zeros(1,19)];
d=[zeros(1,31) ones(1,19)];
%--------------���´��룩----------- ��������Լ������--------------------
    c1=c.*noise_capacity;
    t1=t.*noise_capacity;
    d1=d.*noise_capacity;
%-------���´��룩-----------ѭ���������Թ滮-------------------------
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
%--------------(ԭ2�ʴ��룩-----------������ݴ���-------------------
 fval=ceil(fval)%fval ����ȡ����Ϊ ����������
 capacity=[capacity_A ;capacity_B;capacity_C]%�ϲ���Ӧ�̲���
 result_of_supply=zeros(50,24);%������Ӧ������
 for g=1:24
     for r=1:50
 result_of_supply(r,g)=capacity(r,1).*x(r,g).*noise_average__supply_rate(r,g);%����ģ�⹩Ӧ�̹�Ӧ��
     end
 end
 %--------------���´��룩-------���ݱ���--------------------------
  xlswrite('three_supply.xls',result_of_supply);%��������
  xlswrite('number_of_supply.xls',fval);%���泧����������