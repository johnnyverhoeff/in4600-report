a = 100;

x = [ repmat(1, 1, a) repmat(1, 1, a) repmat(1, 1, a) repmat(-1, 1, a)];
y = [ repmat(1, 1, a) repmat(-1, 1, a) repmat(1, 1, a) repmat(-1, 1, a)];


plot(x+y);
title('+1/-1 Symbols');
ylim([-2.2 2.2]);

figure;

x1 = (1 - x) / 2;
y2 = (1 - y) / 2;


plot(x1+y2);
title('0/1 Symbols');
ylim([-0.2 2.2]);
