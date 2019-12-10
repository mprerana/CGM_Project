% %FD estimation from LP Spectrum
function[dominent_value,dominent_mag]=fd_using_LP_spectrum(sig,t,start,nd)

y2=sig;  
time=t;

sp= start  ;     %starteng point
ep= nd  ;        %ending point

P=5       ; % LP order


sindx=find(time>=sp,1);% it'll give the index value of 1st number from all the numbers it('sp') matches with. it's perfect for starting point.
eindx=find(time>=ep,1);
y1=y2(sindx:eindx);
y=y1(1:length(y1));% select 20ms segment. fr 20ms take 200samples if fs=10KHz. formula->num of sample/fs(Hz)=time(ms). 

L=length(y);
w=hamming(L);
y=y.*w; %Multiplying the signal with hamming window
% P=14; % LP order
%y=y';
ycorr=autocorr(y,(length(y)-1)); %autocorrelaiton
A=ycorr(1:P); %Pth order autocorrelation sequence
r=ycorr(2:(P+1)); %Column vector for matrix solving
%A1=A';
A=toeplitz(A); %toeplitz autocorrelation matrix
r=r';
L= -inv(A)*transpose(r); %direct matrix solving method
L=transpose(L); %LP coefficients
LPCoeffs(1,1:length([1,L])) = [1,L];

%Computing LP spectrum by taking FFT of LP coefficients
y3=abs(fft(LPCoeffs, 8000)); %representing inverse spectrum A(z)
y3=y3.^(-1); %representing LP spectrum as H(z)=1/A(z)
y3=20*log10(y3);%Converting to DB
y4=y3(1:4000);%Taking symmetric part of the locations

%Peak picking algorithm for finding formants locations
k=1;
for i=2:length(y4)-1
    if(y4(i-1)<y4(i)) & (y4(i+1)<y4(i))
        formant_mag(k) = y4(i); %Estimated formant magnitude
        formant(k)=1; %Estimated formant location
        k=k+1;  
    else
        continue;
    end
end

%graph part
figure;
plot(y4);
hold('on');
plot(formant, formant_mag,'r*');
title('Dominenet locations');
xlabel('Frequency (Hz)');
ylabel('Magnitude(dB)');
% hold('off');

%Peak picking algorithm to get formant value
k=1;
for i=2:length(y4)-1
    if(y4(i-1)<y4(i)) &  (y4(i+1)<y4(i))
        dominent_mag(k)=y4(i);
        dominent_value(k)=i;
        k=k+1;
    else
        continue;
    end
end
 dominent_value(k)=i
 dominent_mag(k)=y4(i)
end
