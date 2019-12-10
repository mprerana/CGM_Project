%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File name : computeResidual

% DESCRIPTION :
% To compute LP residual and LPCs 

% INPUTS :
%		speech - speech in ASCII
%		Fs - Sampling frequency (Hz)
%		segmentsize - framesize for lpanalysis (ms)
%		segmentshift - frameshift for lpanalysis (ms)
%		lporder    - order of lpc
%		preempflag - If 1 do preemphasis
%		plotflag  - If 1 plot results

%  OUTPUTS :
%		residual - residual signal
%		LPCoeffs - 2D array containing LP coeffs of all frames
%               Ne       - Normalized error

%  LOG: Nan errors have been fixed.
%		Some elements of 'residual' were Nan. Now, the error
%		has been corrected.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [residual,LPCoeffs] = computeResidual(speech,Fs,segmentsize,segmentshift,lporder,preempflag,plotflag)

% Preemphasizing speech signal
if(preempflag==1)
	dspeech=diff(speech);
	dspeech(length(dspeech)+1)=dspeech(length(dspeech));
else
	dspeech=speech;
end

dspeech = dspeech(:);

framesize = floor(segmentsize * Fs/1000);
frameshift = floor(segmentshift * Fs/1000);
nframes=floor((length(dspeech)-framesize)/frameshift)+1;
Lspeech = length(dspeech);
numSamples = Lspeech - framesize;

(nframes-1)*frameshift + framesize;

sbuf = buffer(dspeech, framesize, framesize-frameshift,'nodelay');
[rs,cs] = size(sbuf);
tmp = dspeech(Lspeech-rs+1:Lspeech);
sbuf(:,cs) = tmp(:); % Last column of the buffer.

% Computation of LPCs.
for i=1:cs
	nanflag = 0;
	erg(i) = sum(sbuf(:,i).*sbuf(:,i));
	if erg(i) ~= 0
		a = lpc(sbuf(:,i),lporder);
		nanflag = sum(isnan(real(a)));
	else
		a = [1 zeros(1,lporder)];
	end

	if nanflag ~= 0
        a = [1 zeros(1,lporder)];
		A(:,i) = real(a(:));
	else
		A(:,i) = a(:);
	end
end

% Computation of LP residual.
x = [zeros(1,lporder) (dspeech(:))'];
xbuf = buffer(x, lporder+framesize, lporder+framesize-frameshift,'nodelay');
[rx,cx] = size(xbuf);
tmp = x(Lspeech+lporder-rx+1:Lspeech+lporder);
xbuf(:,cx) = tmp(:); % Last column of the buffer.

% Inverse filtering.
j=1;
for i=1:cx-1
	res = filter(A(:,i), 1, xbuf(:,i));
	
	% Write current residual into the main residual array.
	residual(j:j+frameshift-1) = res(lporder+1:frameshift+lporder);
	j=j+frameshift;
end
	res = filter(A(:,cx), 1, xbuf(:,cx));
	residual((cx-1)*frameshift + 1: Lspeech) = res((cx-1)*frameshift - Lspeech + rx + 1:rx);

	LPCoeffs = A';
	%size(LPCoeffs)

% Plotting the results
if plotflag==1

        % Setting scale for x-axis.
	i=1:Lspeech;
       	x = i/Fs;
	

	figure;	subplot(2,1,1);plot(x,speech);
	xlim([x(1) x(end)]);
	ylabel('Signal');grid;

	subplot(2,1,2);plot(x,residual);
	xlim([x(1) x(end)]);
	xlabel('Time (s)');ylabel('LP Residual');grid;
end