function animateSolution(t,Xh,l,n)

nt = length(t);
dt = [0;diff(t)];

% cart position
xc = Xh(1,:);

% body position
xm = xc-l*sin(Xh(2:n/2,:));
ym = l*cos(Xh(2:n/2,:));

x = [xc;xm];
y = [zeros(size(ym));ym];

% animation
figure(1)
for it = 1:nt
    plot(x(:,it),y(:,it), 'k-', 'LineWidth',2)
    xlim([xc(it)-(n/4-0.5)*l, xc(it)+(n/4-0.5)*l]); ylim([0,(n/2-1)*l])
    xlabel('$x_c(t)$', 'interpreter', 'latex')
    ylabel('$y$', 'interpreter', 'latex')
    title(['$t\,\,=\,\,', num2str(t(it)),'$'], 'interpreter', 'latex')
    axis('equal')
    pause(dt(it)*0.85)
end
