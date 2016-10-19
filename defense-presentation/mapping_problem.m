a = 100;

x = [ repmat(1, 1, a) repmat(-1, 1, a) repmat(1, 1, a) repmat(-1, 1, a)];
y = [ repmat(1, 1, a) repmat(-1, 1, a) repmat(1, 1, a) repmat(-1, 1, a)];

x1 = (1 - x) / 2;
y1 = (1 - y) / 2;


figure;
%hold on;
plot(x);
%plot(y)
%plot(x+y);
title('+1/-1 Symbols');
ylim([-1.2 1.2]);

figure;






plot(x1);
title('0/1 Symbols');
ylim([-0.2 1.2]);
