%**************************************************************************
% zfSig: Zero frequency filtered signal
%**************************************************************************
function [zfSig, N, winLength]=zFF(wav,fs)

[winLength, nc, edges] = computeWindowLength(wav,fs,1, 0);
% Difference the speech signal...
	dwav=diff(wav);
	dwav=dwav/max(abs(dwav));
	N=length(dwav);

%     dwav=diff(wav);
% 	wav=wav/max(abs(wav));
% 	N=length(wav);
%     dwav = wav;
% Pass the differenced speech signal twice through zero-frequency resonator..	
	zfSig=cumsum(cumsum(cumsum(cumsum(dwav))));

plotFlag=0;

if(plotFlag==1)
	figure; 
	ax(1)=subplot(5,1,1); plot((1:length(wav))/fs, wav/max(abs(wav))); grid;
	title('Speech signal');
end
% Remove the DC offset introduced by zero-frquency filtering..	
	winLength=round(winLength*fs/1000);

if(plotFlag==1)
	ax(2)=subplot(5,1,2); plot((1:length(zfSig))/fs,zfSig);grid;
	title('Output of cascade of zero frequency resonators, y2[n]');
end
%**************************************************************************
%First Trend Reoval
	zfSig=remTrend(zfSig,winLength);
	temp=zfSig; %temp(N-winLength:N)=0;
%**************************************************************************
if(plotFlag==1)
	ax(3)=subplot(5,1,3); plot((1:length(temp))/fs,temp);grid;
	title('Output after first trend removal');
end

%**************************************************************************
%Second Trend Reoval
	zfSig=remTrend(zfSig,winLength);
	temp=zfSig; %temp(N-winLength*2:N)=0;
%**************************************************************************
if(plotFlag==1)
	ax(4)=subplot(5,1,4); plot((1:length(temp))/fs,temp);grid;
	title('Output after second trend removal');
end
%**************************************************************************
%UNACCOUNTED TREND REMOVAL
	zfSig=remTrend(zfSig,winLength);
	temp=zfSig; %temp(N-winLength*2:N)=0;
%	ax(4)=subplot(5,1,4); plot((1:length(temp))/fs,temp);grid;
%	title('Output after second trend removal');
%**************************************************************************
%**************************************************************************
%Third Trend Removal
	zfSig=remTrend(zfSig,winLength);
	zfSig(N-winLength*3:N)=0;
%**************************************************************************
if(plotFlag==1)
%	ax(5)=subplot(5,1,5); plot((1:length(zfSig))/fs,zfSig/max(abs(zfSig)));grid;
	ax(5)=subplot(5,1,5); plot((1:length(zfSig))/fs,zfSig);grid;
	title('Output after third trend removal');
	xlabel('Time (s)');
	linkaxes(ax,'x');
	xlim([0 (N-winLength*3)/fs]);
end

%   Plotting the ZF Signal
plotFlag=0;

if(plotFlag==1)
	figure;
	ax(1)=subplot(2,1,1); plot((1:length(wav))/fs, wav/max(abs(wav))); grid;
	title('Speech signal');
	ax(2)=subplot(212); plot((1:length(zfSig))/fs,zfSig);grid;xlim([0 (N-winLength*3)/fs]);
	linkaxes(ax,'x');
end


function [out]=remTrend(sig,winSize)

	window=ones(winSize,1);
	rm=conv(sig,window);
	rm=rm(winSize/2:length(rm)-winSize/2);

	norm=conv(ones(length(sig),1),window);
	norm=norm(winSize/2:length(norm)-winSize/2);

	rm=rm./norm;
	out=sig-rm;
    
   