%% cleansing
close all;
clear all;
clc;

%% parameters
a = .2;
b = .2;
c = 5.7;
dt = 3.e-2;  %time step
steps = 250;

%% figure
figure(1);
hold off;
figure(2);
hold on;

%% initial values
phi = zeros(3,100);
phi(1,:) = linspace(-3,-10,size(phi,2));
dphi = zeros(3,size(phi,2));
rho = zeros(steps,size(phi,2),1);
z = zeros(steps,size(phi,2),1);

%% colors
cors = zeros(size(phi,2),3);
cors(:,1) = linspace(0,1,size(phi,2));
cors(:,3) = 1-cors(:,1);

%% differential equation
f = @(phi) [-phi(2)-phi(3); phi(1)+a*phi(2); b+phi(3)*(phi(1)-c)];

%% iterations
figure(1);
hold off;
rho(1,:) = sqrt(phi(1,:).*phi(1,:)+phi(2,:).*phi(2,:));
for step = 2:steps
    fprintf('step %d\n',step);
	for i = 1:size(phi,2)
        phi(:,i) = phi(:,i) + rk4(f,dt,phi(:,i));
	end
    rho(step,:) = sqrt(phi(1,:).*phi(1,:)+phi(2,:).*phi(2,:));
    z(step,:) = phi(3,:);
	scatter(rho(step,:),z(step,:),5,cors(:,:));
    axis([-5 14 -2 34]);
    drawnow;
end

figure(2);
for i = 1:size(phi,2)
    hold on;
	plot3(1:step,rho(:,i),z(:,i),'color',cors(i,:),'LineWidth',1);
end

%% save images
figure(2);
fprintf('saving figure...');
xlabel('t');
ylabel('\rho');
zlabel('z');
%axis equal;
view(3);
%saveas(gcf,'rossler.fig');
%print('rossler','-dpng');
%print('rossler','-dpdf','-r720');
fprintf(' ok\n');