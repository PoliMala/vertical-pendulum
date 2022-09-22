function animateSolution(t,Xh,l,n)

nt = length(t);
dt = [0;diff(t)];

% initialize variables
xm = zeros([n/2-1,nt]);
ym = zeros([n/2-1,nt]);

% cart position
xc = Xh(1,:);

% body position
xm(1,:) = xc-l*sin(Xh(2,:));
ym(1,:) = l*cos(Xh(2,:));
for jj = 2:(n/2-1)
    xm(jj,:) = xm(jj-1,:)-l*sin(Xh(jj+1,:));
    ym(jj,:) = ym(jj-1,:)+l*cos(Xh(jj+1,:));
end
x = [xc;xm];
y = [zeros(size(xc));ym];

% animation
figure(1)
for it = 1:nt
    plot(x(:,it),y(:,it), 'k-', 'LineWidth',2)
    xlim([xc(it)-(n/4-0.5)*l, xc(it)+(n/4-0.5)*l]); ylim([0,(n/2-1)*l])
    xlabel('$x_c(t)$ [$m$]', 'interpreter', 'latex')
    ylabel('$y$ [$m$]', 'interpreter', 'latex')
    title(['$t\,\,=\,\,', num2str(t(it)),'$ [$s$]'], 'interpreter', 'latex')
    axis('equal')
    pause(dt(it)*0.85)
end
