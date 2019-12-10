%%This program is for noise removal using VNV(voicebox)
clear all; close all; clc;


file='E:\IIITS\4.ASD_TD_Datasets\ASD_dataset\S01_F_02y08m_Sn09.wav';

% % file_name=sprintf('%s.wav', name);


[sig, fs] = audioread(file);
info = audioinfo(file);
sig = sig(:, 2 );

quantization=info.BitsPerSample; %% quantization rate

sig=sig./(1.01*abs(max(sig))); %Normalizing the signal amplitudes to be in -1.0 to 1.0

 %%sig= medfilt1(sig,3); %applying 5th order median filter


% % % % VNV Application
[vs,zo]=vadsohn(sig,fs);
vs2 = [vs; zeros(length(sig)-length(vs), 1)];
sig2 = sig.*vs2;
sig = sig2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ins = 0.289;
% N1 = ins.*fs;
% chunk = 0.100*fs;
% sig = sig(N1:N1+chunk-1);             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
audiowrite('E:\IIITS\4.ASD_TD_Datasets\ASD_dataset\asd_preprocessed\vnv.wav'...
,sig,fs,'BitsPerSample',quantization); %% create .wav file