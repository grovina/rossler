clear all;
close all;
clc;
figure(1);
hold on;

tic;

w0 = -4.:.1:4.;

for r = -2:.001:4.
    fprintf('r=%f\n',r);
    w = w0;
    for i=1:1000
        w = r*w.*(1-w);
    end
    w = w + 1e-5;
    for i=1:1000
        w = r*w.*(1-w);
    end
    
    wf = zeros(10,length(w));
    for i=1:size(wf,1)
        wf(i,:) = r*w.*(1-w);
        w = wf(i,:);
    end
    
    a = unique(wf);
    for i = 1:length(a)
        if (~isinf(a(i)))
            plot(r,a(i),'k.','MarkerSize', 1);
        end
    end
    drawnow;
end

fprintf('saving figure...');
xlabel('r');
ylabel('w');
axis equal;
print('diagram','-dpng');
print('diagram','-dpdf','-r720');
fprintf(' ok\n');

toc;