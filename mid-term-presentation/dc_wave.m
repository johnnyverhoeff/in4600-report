
t=0:0.00001:0.02;

A = 12;

y = A .* ones(1, length(t));

f = 500;

z = A .* sin(2*pi*f*t);

z(z >= 0) = A;
z(z < 0) = 0;


hold on;
plot(1000.*t, z);
plot(1000.*t, y);
ylim([-1 A+1]);
xlabel('Time (ms)');
ylabel('Voltage (V)');
title('DC Voltage');
legend('DC Voltage', 'Modulating Signal'); 

