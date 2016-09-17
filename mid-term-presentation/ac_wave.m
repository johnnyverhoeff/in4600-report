
A= 230 * sqrt(2);

f=50;


t=[0:0.00001:0.02];


y = A * sin(2*pi*f*t);


figure;
title('AC voltage');
xlabel('Time (ms)');

plot(1000.*t, y);

hold on;
plot(1000.*[t(1) t(end)], [0 0], 'black');


plot([t(101) t(902)].*1000, [100 100], 'blue');
plot([t(1100) t(1900)].*1000, [-100 -100], 'red');

ylabel('Voltage (V)');





yyaxis right;
trigger = (y > 100) + (y < -100);
plot(1000.*t, trigger);
ylim([-2 2]);

ylabel('Trigger output');



legend('AC', '0 V', '+100 V', '-100 V', 'Trigger');
%legend('AC', '0 V');









