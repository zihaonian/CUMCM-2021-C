capacity=xlsread("E:\matlab\Problem C\question 1\�������ϣ�excel����.xls",...
    2,'E2:E51');%��ȡ��������
%----------------����Ŀ�꺯������---------------------------------------
f=zeros(60,24);
for p=1:24
  for k=1:20
    for j=1:3
      f(3*(k-1)+j,p) = capacity(k,p).*rate(j,1)
    end
  end
end
%-------------------������ʽԼ������----------------------------------------
aeq=zeros(20,60)
for i=1:20
    g=zeros(1,60);
    g(1,3*i)=1;
    g(1,3*i-1)=1;
    g(1,3*i-2)=1;
    aeq(i,:)=g;
end%������ʽ����
beq=ones(20,1);%������ʽ�������
%------------------��������ʽԼ������-----------------------
a=zeros(3,60);
for t=1:20
    p=zeros(60,1);
    a(1,3*(t-1)+1)=1   
end
for t=1:20
    p=zeros(60,1);
    a(2,3*(t-1)+2)=1   
end
for t=1:20
    p=zeros(60,1);
    a(3,3*(t-1)+3)=1   
end
for e=1:3
    for w=1:20
        a1=capacity(w,e).*a(3*(w-1)+1,e);
    end
end
lb=zeros(60,1);
up=ones(60,1);
[x,fval]=linprog(f,-A,-b,Aeq,beq,lb,up);

    



    
