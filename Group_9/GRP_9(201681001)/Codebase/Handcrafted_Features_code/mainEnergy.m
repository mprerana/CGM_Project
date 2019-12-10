%this program call all the required functions for Energy. then compute mean,
%SD and NSD of Energy.
function [t2, Mean_Energy]= mainEnergy(sig,fs)
frame_size = 30;    %frame size 30ms
frame_shift = 10;   %frame shift 10ms
a= frame_size*fs/1000;  %no of samples
b= (frame_size - frame_shift)*fs/1000;
t=1/fs:1/fs:length(sig)/fs;

wavbuff = buffer(sig,a,b);
Energy = sum(abs(wavbuff).^2);
Mean_Energy = mean(abs(wavbuff).^2);

h=figure;
%Plot the waveform
ax(1) = subplot(2,1,1);
plot(t, sig, 'k','LineWidth',1);
xlabel('Time','FontSize', 12,'FontWeight','bold');
ylabel('Amplitude', 'FontSize', 12,'FontWeight','bold');
title('(a) Waveform of the speech signal', 'FontSize', 13,'FontWeight','bold');
set(gca, 'FontSize', 10, 'FontWeight', 'bold');


Fsize = frame_size/1000;    %resize frame size to plot energy matching the waveform
Fshift = frame_shift/1000;  %resize frame shift to plot energy

[rows,cols]=size(Energy);
t2=1/fs:Fshift:(cols*Fshift);   %take t2 whose vectors match the dimension of Mean_Energy


ax(2) = subplot(2,1,2);
plot(t2, Mean_Energy, 'k.', 'LineWidth',1.2);
xlabel('Time', 'FontSize', 12,'FontWeight','bold');
ylabel('Energy', 'FontSize', 12, 'FontWeight','bold');
title('(b) Energy of the signal', 'FontSize', 13,'FontWeight','bold');
linkaxes([ax(2) ax(1)], 'x');
% set(gca, 'FontSize', 10, 'FontWeight', 'bold');
xlim([0 (length(sig)/fs)]);


me = mean(Mean_Energy);
meean=me;
% me=round(me*10)/10
SD= std(Mean_Energy);
SD1=round(SD*1000)/1000;
NSD=SD1/me;
NSD1=round(NSD*1000)/1000;
Energy_SD_NSD=[meean,SD1,NSD1]
end
