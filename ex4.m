clear,  clc
% 映射坐标系内 r=-1:2/m-1:1;s = -1:2/n-1:1;
m = 5; n = 5;         % 定义网格数量
r = linspace(-1,1,m); s = linspace(-1,1,n);
[R, S] = meshgrid(r,s);
figure(1)
% 画网格
plot(r,R,'linewidth',1.5,'color','k')
hold on
plot(R,s,'linewidth',1.5,'color','k')
hold on
nnode = reshape(1:m*n,m,n)';   % 节点编号
nelement = reshape(1:(m-1)*(n-1),m-1,n-1)';  % 单元编号
for i =1:m
    for j= 1:n
        k = num2str(nnode(i,j));        
        plot(R(i,j),S(i,j),'ro')  % 画节点
        text(R(i,j)-0.11,S(i,j)-0.09,k)  % 标记节点编号
        if i < m && j < n
            kk = num2str(nelement(i,j));
            % 标记单元编号
            text(R(i,j)+0.2,S(i,j)+0.25,kk,'color','k','FontWeight','bold')  
        end
    end
end
axis([-1.5 1.5 -1.5 1.5]);
set(gca,'FontSize',10,'box','off','linewidth',1.2,'FontWeight','bold')
xlabel('r', 'FontSize',13,'FontWeight','bold');
ylabel('s', 'FontSize',13,'FontWeight','bold');
title('映射坐标系','fontsize',15,'FontWeight','bold')
%
%
% 映射到整体坐标系
figure(2)
% 从局部坐标系Ors映射到整体坐标系Oxy
% xy为整体坐标系下四个边界端点坐标[{x}{y}]（4×2）
% rs为局部坐标系下四个边界端点坐标[{r}{s}]（4×2）
 xy = [1 1; 3 1.5; 2.5 3; 1.5 2.5];
 rs = [-1 -1; 1 -1; 1 1; -1 1];
% 定义匿名函数以计算某点的形函数
Fi = @(rr,ss,ri,si) 1/4*(1+rr*ri)*(1+ss*si);
% 定义Oxy坐标系下坐标x与y的矩阵
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
        text(x(i,j)-0.11,y(i,j)-0.09,k) % 直接标记节点编号
        hold on        
    end
end
% 连接相邻点形成小单元的边界
hold on
% 连接相邻的两点（非对角）形成整体坐标系下的网格
for i = 1:m
   for j = 1:n
       % 非上边界和右边界的部分得画两条
       % 上边界和右边界只有一条
       if i <= m-1 && j <= n-1
          line([x(i,j),x(i,j+1)],[y(i,j),y(i,j+1)],'linewidth',1.5,'color','k');
          line([x(i,j),x(i+1,j)],[y(i,j),y(i+1,j)],'linewidth',1.5,'color','k');
          % 设置一定偏移量，标记单元编号
          kk = num2str(nelement(i,j));
          text(0.6*x(i,j)+0.4*x(i+1,j+1),0.5*(y(i,j)+y(i+1,j+1)),kk,...
              'color', 'k','FontWeight','bold')
       end 
       if i == m && j <= n-1   % 上边界
          line([x(i,j),x(i,j+1)],[y(i,j),y(i,j+1)],'linewidth',1.5,'color','k');          
       end
       if i <= m-1 && j == n   % 右边界
          line([x(i,j),x(i+1,j)],[y(i,j),y(i+1,j)],'linewidth',1.5,'color','k');       
       end              
   end
end
axis([0.5 3.5 0.5 3.5]);  %设置坐标轴范围
set(gca,'FontSize',10,'box','off','linewidth',1.2,'FontWeight','bold')
xlabel('x', 'FontSize',13,'FontWeight','bold');
ylabel('y', 'FontSize',13,'FontWeight','bold');
title('整体坐标系','fontsize',15,'FontWeight','bold')