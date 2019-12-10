%this program call all the required functions for pitch. then compute mean,
%SD and NSD of pitch.

function [it, if0]= mainPitch(fs,sig)
[zSig, n1, wlen] = zFF(sig, fs);
[if0,it0,slope,it] = computeF0andSlope(zSig, fs, 0);

    a=figure;
    N = length(sig);
	% plot waveform
    ax(1) = subplot(4,1,1);
    t = (0:N-1)/fs;
    plot(t, sig, 'k');
    title('Input Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    %xlim([t(1) t(end)]);
    xlim([0 (n1-wlen*3)/fs]);
    
    ax(2)=subplot(4,1,2); 
    plot((1:length(zSig))/fs,zSig, 'k');
    title('ZFF Signal');
    ylabel('Amplitude');
    grid;
    xlim([0 (n1-wlen*3)/fs]);


    % plot F0 track
    ax(3) = subplot(4,1,3);
    plot(it,if0, 'k.');
    title('F0 contour');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    %xlim([t(1) t(end)]);
    xlim([0 (n1-wlen*3)/fs]);
    pitch=mean(if0);
    %mean(if0)
    SD_pitch=std(if0);
    NSD_pitch=SD_pitch/pitch;
    
    % plot Phase 
    ax(4) = subplot(4,1,4);
    stem(it,slope./max(slope), 'k');
    title('Strength of Excitation');
    xlabel('Time (s)');
    ylabel('Intensity');
    %xlim([t(1) t(end)]);
    xlim([0 (n1-wlen*3)/fs]);
    linkaxes(ax,'x');
    
    pitch_SD_NSD=[pitch, SD_pitch, NSD_pitch]
end
  
%     saveas(a, 'C:\Users\Danish\Desktop\Emo_database\german\16a04Faxx.fig');
%     saveas(a, 'C:\Users\Danish\Desktop\Emo_database\Telugu\spk5-s1-2-An.jpg');