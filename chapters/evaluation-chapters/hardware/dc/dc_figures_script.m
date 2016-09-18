%load dc-testbed-raw-and-corr-n=9-N=6;
load dc-testbed-raw-and-corr-n=7-N=6;

L = 127;
%L = 511;

close all;

start_idx = 1; %400
end_idx = 2000;%length(corr); % 1200

f = 1000;

time_vector = (0:(end_idx-1)) ./ f;


plot(time_vector, raw(start_idx : end_idx))
title('Raw ADC data DC testbed');
xlabel('Time (s)');
ylabel('ADC value');



hold on;

for idx = 0:6
   plot([time_vector(1) time_vector(end)],[300*idx 300*idx]); 
end;

%legend('raw data','0 LEDs on', '1 LEDs on', '2 LEDs on', '3 LEDs on', '4 LEDs on', '5 LEDs on', '6 LEDs on');
legend('raw data','0', '1', '2', '3', '4', '5', '6');

yyaxis right;

ylim([0 1800/1024*5/25*1000]);
ylabel('Current (mA)');
hold off;


figure;

plot(time_vector, corr(start_idx : end_idx));
title('Correlation');
xlabel('Time (s)');
ylabel('Correlation');

hold on;

plot(time_vector, corr_not_included_code(start_idx : end_idx));

plot([time_vector(1) time_vector(end)],[L/2 L/2]); 

legend('Corr. w/ present code', 'Corr w/ not present code', 'Threshold');
hold off;


%idx_first_tp = 511;%95;
idx_first_tp = 95;
tp = 0;
fp = 0;
tn = 0;
fn = 0;

f = zeros(1, end_idx);



for idx=1:end_idx
   if (mod(idx - idx_first_tp, L) == 0)
        %tp = 0;
        %fp = 0;
        %tn = 0;
        %fn = 0;

       if corr(idx) > L/2
           tp = tp + 1;
       else
           fn = fn + 1;
       end;
   else
       if corr(idx) > L/2
           fp = fp + 1;
       else
           tn = tn + 1;
       end;
   end;
   
   precision = tp / (tp + fp);
   recall = tp / (tp + fn);
   
   if (precision == 0 && recall == 0)
       f(idx) = 1;
   else
       f(idx) =  2 * precision * recall / (precision + recall);
   end;
       
    
end;

precision = tp / (tp + fp);
recall = tp / (tp + fn);

figure;
plot(time_vector, f);
title('F-Measure')
xlabel('Time (s)');
ylabel('F-Measure');







