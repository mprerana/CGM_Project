%this program is designed to read audiofile and do preprocessing.%03rd-Mar-19
%*************At 1st this program needs to be run****************
%after this program run "MAIN_for_ALL.m" and then "mean_SD_NSD_all.m"
%****************************************************************************

%%NB--->> audiowrite('try.wav',sig1,32000); %% create audio file.
clear all; close all; clc;

[sig, fs] = audioread('E:\IIITS\4.ASD_TD_Datasets\TD_dataset\Noise_removed_TD\S20_M_08y00m_Sn10.wav');

% % % % VNV Application
[vs,zo]=vadsohn(sig,fs);                        
vs2 = [vs; zeros(length(sig)-length(vs), 1)];
sig2 = sig.*vs2;
sig = sig2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%audiowrite('filename.wav',sig,fs)%% create .wav file

%sig = sig(:, 2 );
sig_formant= resample(sig,10000,fs);% for formant and FD re-sampling
sig=sig./(1.01*abs(max(sig))); %Normalizing the signal amplitudes to be in -1.0 to 1.0  
%  sig=sig(1:100);
%sig= medfilt1(sig,5); %applying 5th order median filter



%*********************** ONLY for Formant and FD  ***********************%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sig_formant=sig_formant./(1.01*abs(max(sig_formant))); %%%Normalizing 
%sig_formant= medfilt1(sig_formant,5); %applying 5th order edian filter

fs_formant=10000;
tSampling= 1/fs_formant; 
len= length(sig_formant);
t_formant=(0:len-1)*tSampling; %Making the time vector
t_formant=t_formant';
% % plot(1000*t_formant,sig_formant); % time in ms
% % xlim([0 (length(sig_formant)/10)]); % **** cut the extra signal part in ms****
% %  sound(sig_formant,fs_formant);
%**************************************************************%