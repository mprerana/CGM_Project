%This will calculate the Mean, SD and NSD of pitch, E, SoE, ZCR, FD and
%formants for the given duration. ***** run it after "MAIN_for_ALL.m"******

clearvars -except sig fs it if0 t2 Mean_Energy it_soe t1 SoE ZCR sig_formant t_formant fs_formant; clc; %F0,E,SoE,ZCR,formant,FD (sequence)


tSampling= 1/fs; 
len= length(sig);
tim=(0:len-1)*tSampling; %Making the time vector
tim=tim';
tim_Len= tim(length(tim));

time_arry=it;       %pitch
time_E=t2;          %Energy 
time_soe=it_soe;    %SoE
time_zcr=t1;        %ZCR

%****************Specify time period in sec*******************************

sp=   00      ;                                    %starting point in sec
% ep=   tim_Len-.1  ;                                    %ending point in sec

ep_formant=t_formant(length(t_formant)); %% for formant,FD,LPCC
%*************************************************************************


%*************************Pitch******************************
sindx=find(time_arry>=sp,1);% it'll give the index value of 1st number from all the numbers it('sp') matches with. it's perfect for starting point.
eindx=find(time_arry>=time_arry(length(time_arry)),1);
% eindx=find(time_arry<=ep,1,'last')%it'll give the last smallest number than the given number 
% sindx=find(time_arry<=sp,1,'last')%it'll give the last smallest number than the given number 

all_pitch=if0(sindx:eindx);
mean_pitch= mean(all_pitch);        %mean F0 value
pitch1=round(mean_pitch*10)/10;     %take single digit after point. [remove colon for pitch value]
SD= std(all_pitch);                 %standard deviation of F0 
pitch_SD1=round(SD*100)/100;        %[remove colon for pitch_SD value]
NSD=SD/mean_pitch;                  %normalised F0 value
pitch_NSD1=round(NSD*1000)/1000;    %[remove colon for pitch_NSD value]
%*************************************************************************


%*******************************Energy********************************
sindx=find(time_E>=sp,1);
eindx=find(time_E>=time_E(length(time_E)),1);
all_energy=Mean_Energy(sindx:eindx); % Energy for a given period
me = mean(all_energy);
meean_E=me;
SD= std(all_energy);
SD1_E=round(SD*1000)/1000;
NSD=SD1_E/me;
NSD1_E=round(NSD*1000)/1000;
%********************************************************************

%***************************SoE**************************************
sindx=find(time_soe>=sp,1);% it'll give the index value of 1st number from all the numbers it('sp') matches with. it's perfect for starting point.
eindx=find(time_soe>= time_soe(length(time_soe)),1);
all_SoE=SoE(sindx:eindx);
me = mean(all_SoE);
% mean_SoE=me;%%%%%
mean_SoE=round(me*10000)/10000;%%%%
SD_SoE= std(all_SoE);
SD1_SoE=round(SD_SoE*1000)/1000;%%%%
NSD_SoE=SD1_SoE/me;
NSD1_SoE=round(NSD_SoE*1000)/1000;%%%
%***********************************************************************

% **********************ZCR calculation*********************************
sindx1=find(time_zcr>=sp,1);% it'll give the index value of 1st number from all the numbers it('sp') matches with. it's perfect for starting point.
eindx1=find(time_zcr>=time_zcr(length(time_zcr)),1);
all_zcr=ZCR(sindx1:eindx1);
mean_zcr = mean(all_zcr);
% mean_zcr;%%%%%
mean_zcr=round(mean_zcr*10000)/10000;%%%%%
SD_zcr= std(all_zcr);
SD1_zcr=round(SD_zcr*1000)/1000;%%%%%
NSD=SD1_zcr/mean_zcr;
NSD1_zcr=round(NSD*1000)/1000;%%%%%%
all_results=[mean_SoE SD1_SoE NSD1_SoE mean_zcr  SD1_zcr  NSD1_zcr];
%**********************************************************************
%result appreance sequence f0->E->SoE->ZCR->formants->FD
all_features_values=[pitch1, pitch_SD1, pitch_NSD1, meean_E, SD1_E, NSD1_E, all_results]

%serial wise according to "all_features_values" variable 
Pitch_Sd_NSD=[pitch1, pitch_SD1, pitch_NSD1];
Energy_Sd_NSD=[meean_E, SD1_E, NSD1_E];
SoE_Sd_NSD=[mean_SoE, SD1_SoE, NSD1_SoE];
ZCR_Sd_NSD=[mean_zcr, SD1_zcr, NSD1_zcr];

%****************************for FORMANT & FDs****************************
%*************************************************************************
sindx_f=find(t_formant>=sp,1);
eindx_f=find(t_formant>=t_formant(length(t_formant)),1);
y_f=sig_formant(sindx_f:eindx_f);
 
%=============================formant===============================
[residual,LPCoeffs] = computeResidual(y_f,fs_formant,30,10,10,0,0);
[n,f,a,b]=lpcar2fm(LPCoeffs);

 f(f==0) = NaN;
 formants=nanmean(f);
 formants=round(formants*10000)
%===================================================================

%==============================FD===================================
[residual,LPCoeffs] = computeResidual(y_f,fs_formant,30,10,5,0,0);
[n,f,a,b]=lpcar2fm(LPCoeffs);

 f(f==0) = NaN;
 fd=nanmean(f);
 fd=round(fd*10000)
 
 Formants_FD=[formants, fd]; % formants and Fd results together
 ultimate_Res=[all_features_values,Formants_FD];
 %===================================================================
 %*******************************************************************

lpcc_res=lpcc(sig_formant,fs_formant); %% LPCC 

[MFCCs]=MFCC_call(sig,fs); 
MFCC_res=MFCCs';
 
% % % %*****************************OLD formant and FD**************************
% % % [formant_value,formant_mag]=formant_using_LP_spectrum(sig_formant,t_formant,sp,ep); %formants
% % % % clearvars -except sig t start nd dominent_value dominent_mag ;
% % % [dominent_value,dominent_mag]=fd_using_LP_spectrum(sig_formant,t_formant,sp,ep); % FD
% % % %**********************************************************************