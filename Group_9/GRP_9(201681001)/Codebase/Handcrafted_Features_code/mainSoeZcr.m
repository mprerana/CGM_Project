%***********this function will compute SoE and ZCR together*************


function[it_soe, t1, SoE, ZCR]= mainSoeZcr(sig,fs)

[zSig, n1, wlen] = zFF(sig, fs);
[if0,it0,slope,it_soe] = computeF0andSlope(zSig, fs, 0);
SoE=slope./max(slope); %%*****SoE*****


[ZCR,t1]=zcr_ste_so(sig,fs);
zcr_value=ZCR;
zcr_time=t1;


    figure;
    N = length(sig);
    ax(1) = subplot(3,1,1);
    t = (0:N-1)/fs;
    plot(t, sig, 'k');
    title('Input Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    %xlim([t(1) t(end)]);
    xlim([0 (n1-wlen*3)/fs]);
     
    ax(2) = subplot(3,1,2);
    stem(it_soe,slope./max(slope), 'k');
    title('Strength of Excitation');
    xlabel('Time (s)');
    ylabel('Intensity');
    xlim([t(1) t(end)]);
    xlim([0 (n1-wlen*3)/fs]);
   
    ax(3) = subplot(3,1,3);
    plot(t1,ZCR,'black','Linewidth',2);
    title('Zero Crossing Rate (ZCR)');
    xlim([0 length(sig)/fs]);
    linkaxes(ax,'x');
end
