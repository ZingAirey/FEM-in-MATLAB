clear,  clc
% ӳ������ϵ�� r=-1:2/m-1:1;s = -1:2/n-1:1;
m = 5; n = 5;         % ������������
r = linspace(-1,1,m); s = linspace(-1,1,n);
[R, S] = meshgrid(r,s);
figure(1)
% ������
plot(r,R,'linewidth',1.5,'color','k')
hold on
plot(R,s,'linewidth',1.5,'color','k')
hold on
nnode = reshape(1:m*n,m,n)';   % �ڵ���
nelement = reshape(1:(m-1)*(n-1),m-1,n-1)';  % ��Ԫ���
for i =1:m
    for j= 1:n
        k = num2str(nnode(i,j));        
        plot(R(i,j),S(i,j),'ro')  % ���ڵ�
        text(R(i,j)-0.11,S(i,j)-0.09,k)  % ��ǽڵ���
        if i < m && j < n
            kk = num2str(nelement(i,j));
            % ��ǵ�Ԫ���
            text(R(i,j)+0.2,S(i,j)+0.25,kk,'color','k','FontWeight','bold')  
        end
    end
end
axis([-1.5 1.5 -1.5 1.5]);
set(gca,'FontSize',10,'box','off','linewidth',1.2,'FontWeight','bold')
xlabel('r', 'FontSize',13,'FontWeight','bold');
ylabel('s', 'FontSize',13,'FontWeight','bold');
title('ӳ������ϵ','fontsize',15,'FontWeight','bold')
%
%
% ӳ�䵽��������ϵ
figure(2)
% �Ӿֲ�����ϵOrsӳ�䵽��������ϵOxy
% xyΪ��������ϵ���ĸ��߽�˵�����[{x}{y}]��4��2��
% rsΪ�ֲ�����ϵ���ĸ��߽�˵�����[{r}{s}]��4��2��
 xy = [1 1; 3 1.5; 2.5 3; 1.5 2.5];
 rs = [-1 -1; 1 -1; 1 1; -1 1];
% �������������Լ���ĳ����κ���
Fi = @(rr,ss,ri,si) 1/4*(1+rr*ri)*(1+ss*si);
% ����Oxy����ϵ������x��y�ľ���
x = zeros(m,n);
y = zeros(m,n);
for i =1:m
    for j= 1:n
        l = 1; 
        while l < 5
            x(i,j) = x(i,j) + Fi(R(i,j),S(i,j),rs(l,1),rs(l,2))*xy(l,1);
            y(i,j) = y(i,j) + Fi(R(i,j),S(i,j),rs(l,1),rs(l,2))*xy(l,2);
            l = l+1;
        end
        k = num2str(nnode(i,j));
        plot(x(i,j),y(i,j),'ro')
        text(x(i,j)-0.11,y(i,j)-0.09,k) % ֱ�ӱ�ǽڵ���
        hold on        
    end
end
% �������ڵ��γ�С��Ԫ�ı߽�
hold on
% �������ڵ����㣨�ǶԽǣ��γ���������ϵ�µ�����
for i = 1:m
   for j = 1:n
       % ���ϱ߽���ұ߽�Ĳ��ֵû�����
       % �ϱ߽���ұ߽�ֻ��һ��
       if i <= m-1 && j <= n-1
          line([x(i,j),x(i,j+1)],[y(i,j),y(i,j+1)],'linewidth',1.5,'color','k');
          line([x(i,j),x(i+1,j)],[y(i,j),y(i+1,j)],'linewidth',1.5,'color','k');
          % ����һ��ƫ��������ǵ�Ԫ���
          kk = num2str(nelement(i,j));
          text(0.6*x(i,j)+0.4*x(i+1,j+1),0.5*(y(i,j)+y(i+1,j+1)),kk,...
              'color', 'k','FontWeight','bold')
       end 
       if i == m && j <= n-1   % �ϱ߽�
          line([x(i,j),x(i,j+1)],[y(i,j),y(i,j+1)],'linewidth',1.5,'color','k');          
       end
       if i <= m-1 && j == n   % �ұ߽�
          line([x(i,j),x(i+1,j)],[y(i,j),y(i+1,j)],'linewidth',1.5,'color','k');       
       end              
   end
end
axis([0.5 3.5 0.5 3.5]);  %���������᷶Χ
set(gca,'FontSize',10,'box','off','linewidth',1.2,'FontWeight','bold')
xlabel('x', 'FontSize',13,'FontWeight','bold');
ylabel('y', 'FontSize',13,'FontWeight','bold');
title('��������ϵ','fontsize',15,'FontWeight','bold')