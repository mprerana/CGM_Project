%this will call all the required functions to compute F0, E, SoE, ZCR, FD,
%formants. ****run it after "MainAudioread.m"****** 
%**************Then run "mean_SD_NSD_all.m"********

[it, if0]= mainPitch(fs,sig); % Pitch call

[t2, Mean_Energy]= mainEnergy(sig,fs); % Energy call

[it_soe, t1, SoE, ZCR]= mainSoeZcr(sig,fs); %SoE, ZCR call
