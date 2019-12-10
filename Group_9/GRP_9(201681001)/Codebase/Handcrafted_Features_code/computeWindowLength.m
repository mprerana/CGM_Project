function [avgt0, nc, edges]= computeWindowLength(s,fs,preempflag, plotflag)

if preempflag == 1
	s1 = diff(s);
	s1(length(s)) = s1(end);
	clear s;
	s = s1;
end
ls = length(s);

% Analysis parameters.
sz = 30; % in ms
sh = 3; % in ms.

N = floor(sz*fs/1000);
L = floor(sh*fs/1000);
minT0 = floor(2.0*fs/1000);

% For autocorrelation of speech.

bufs = buffer(s,N,N-L,'nodelay');
[r,c] = size(bufs);
posPeak = [];
for i=1:c
	ac1 = xcorr(bufs(:,i));
	ac = ac1(N:2*N-1)/max(ac1);
	ac(1:minT0) = 0;
        y1 = [diff(ac) > 0];
        y2 = [diff(ac) <= 0];
        [locPeaks] = find((y1(1:length(y1)-1) + y2(2:length(y2))) == 2);
        if isempty(locPeaks) == 0
                locPeaks = locPeaks(:) + ones(length(locPeaks),1);
                [acmaxval,pos] = max(ac(locPeaks));
                posPeak(i) = locPeaks(pos);
		acmax(i) = acmaxval;
        else
                posPeak(i) = minT0;
		acmax(i) = 0;
        end
	posPeak(i) = posPeak(i)*1000/fs;
end

t0ms = posPeak;
locv = find(acmax > 0.3);

T0 = t0ms(locv);

edges = [2:2:18];
[nc,bin] = histc(T0, edges);

%nc(1:2) = 0;
nc = nc/sum(nc);

[maxnc, binpos] = max(nc);
%avgt0 = edges(binpos);

avgt0 = ceil(mean(T0));

if plotflag == 1
	bar(edges, nc/sum(nc));
end
