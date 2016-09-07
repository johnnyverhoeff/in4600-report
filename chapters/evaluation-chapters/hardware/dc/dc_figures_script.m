load dc-testbed-raw-and-corr-n=9-N=6;
%load dc-testbed-raw-and-corr-n=7-N=6;

L = 511;

close all;

start_idx = 1; %400
end_idx = length(corr); % 1200


plot(raw(start_idx : end_idx))
title('Raw ADC data DC testbed');
xlabel('Sample');
ylabel('ADC value');

hold on;

for idx = 0:6
   plot([1 end_idx - start_idx + 1],[300*idx 300*idx]); 
end;

legend('raw data','0 LEDs on', '1 LEDs on', '2 LEDs on', '3 LEDs on', '4 LEDs on', '5 LEDs on', '6 LEDs on');
hold off;


figure;

plot(corr(start_idx : end_idx));
title('Correlation');
xlabel('Sample');
ylabel('Correlation number');

hold on;

plot(corr_not_included_code(start_idx : end_idx));

plot([1 min(end_idx - start_idx + 1, length(corr))],[L/2 L/2]); 

legend('Corr. w/ present code', 'Corr w/ not present code', 'Theshold');
hold off;


idx_first_tp = 511;%95;
tp = 0;
fp = 0;
tn = 0;
fn = 0;

f = zeros(1, length(corr));



for idx=1:length(corr)
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
plot(f);
title('F-Measure')
xlabel('Sample');
ylabel('F-Measure');







