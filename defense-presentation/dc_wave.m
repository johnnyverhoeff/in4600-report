
t=0:0.00001:0.02;

A = 12;

y = A .* ones(1, length(t));

f = 500;

A2 = 50;

z = A2 .* sin(2*pi*f*t);

z(z >= 0) = A2;
z(z < 0) = 0;


%hold on;
yyaxis left;
plot(1000.*t, y);


ylim([-1 A+1]);
ylabel('Voltage (V)');




yyaxis right;
plot(1000.*t, z);
ylabel('Current (mA)');
ylim([-8 2*A2]);



xlabel('Time (ms)');
title('DC Voltage');
legend('DC Voltage', 'Modulating Signal'); 


