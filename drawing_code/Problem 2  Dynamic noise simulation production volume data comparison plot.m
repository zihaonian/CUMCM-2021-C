x=1:24;%����˳����
y=xlsread('C:\Users\PC\Desktop\��������2��excel����.xlsx',3,'B2:Y2');
%���ݶ�ȡ
x1=-2:0.3:30
bar(x,y,'g');
hold on;%����ͼ��
y1=28200;
plot(x1,y1,'r.');%���Ƶ���
hold on;
plot(x,y,'.-k');
hold on;
title('Ԥ����������Ҫ���������Ա�');%����
xlebal('�ܴ�')%x����
ylebal('������')%y����

