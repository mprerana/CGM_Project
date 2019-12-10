% Computation of ST-ZCR and STE of a speech signal.
%***************This program is downloaded from Matlab site.*************

% clear all; close all; clc;
% [x,Fsz] = wavread('so.wav');
% x=x(:,1);

function[ZCR,t1]=zcr_ste_so(x,Fsz)
x = x.';
N1 = length(x); % signal length
n1 = 0:N1-1;
ts = n1*(1/Fsz); % time for signal

% define the window
wintype = 'rectwin';
winlen = 201;
winamp = [0.5,1]*(1/winlen);

% find the zero-crossing rate
zc = zerocross(x,wintype,winamp(1),winlen);

% find the zero-crossing rate
% % E = energy(x,wintype,winamp(2),winlen);

% time index for the ST-ZCR and STE after delay compensation
out = (winlen-1)/2:(N1+winlen-1)-(winlen-1)/2;
t1 = (out-(winlen-1)/2)*(1/Fsz);
ZCR=zc(out);
% % % % a=figure;
% % % % axx(1) = subplot(2,1,1);
% % % % plot(ts,x);
% % % % title('Input Signal');
% % % % xlim([0 length(x)/Fsz]);
% % % % 
% % % % axx(2) = subplot(2,1,2);
% % % % plot(t1,zc(out),'black','Linewidth',2);
% % % % title('Zero Crossing Rate (ZCR)');
% % % % xlim([0 length(x)/Fsz]);
% % % % ZCR=zc(out);
end
