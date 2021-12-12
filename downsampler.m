%clear all
close all
clc
%% part A : reading an audio
% sampling frequency for audio file commonly is used 
Fs =44100; 
% read first 30 sec of audio file
time_len = 10;
filename = 'meyou.wav';
[x , Fs]= audioread(filename,[1 , time_len* Fs]);
xs = x(1:length(x));
t = 0:1/Fs:time_len-1/Fs;
figure();
plot(t,xs);
title('time domain signal');
xlabel('time(sec)');
ylabel('Amlitude');
grid on;
%% part B : plot frequency response 
figure();
freqz(xs);
title('frequency response');

%% part C : add echo 
M = 44100;
N = 3;
alpha = 0.7;
xecho = xs;
for k = 1:N
    xecho = xecho + alpha^k *[zeros(1 ,k*M-1), xs(k*M:length(xs))];
end
sound(xecho,Fs)
pause(time_len + 1);

%% part D : change frequency sampling 
L = 2 ;
n = 3;

upX =upsample(xs,L);
downX = downsample(upX,n);

figure();
subplot(3 , 2 , 1)
% plot(t(1:length(t)/30) , xs(1:length(xs)/30));
plot(xs(1:length(xs)/time_len));
title('orginal')
xlabel('time(sec)');
ylabel('Amlitude');
grid on;

subplot(3 , 2 ,2)
[xf , w]=freqz(xs , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(xf)));
title('orginal')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on ;

subplot(3,2,3)
% tup = 0 : 1/(L*Fs):time_len - 1/(L*Fs);
plot(upX(1:length(upX)/time_len));
%plot(tup(1:length(tup)/30) , upX(1:length(upX)/30));
title('upsample')
xlabel('time(sec)');
ylabel('Amlitude');
grid on;

subplot(3,2,4)
[upf , w]=freqz(upX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(upf)));
title('upsamle')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;

subplot(3,2,5)
% tdown = 0:1/(Fs*L/n):time_len- 1/(Fs*L/n);
% plot(tdown(1:length(tdown)/30) , downX(1:length(downX)/30));
plot(downX(1:length(downX)/time_len));
title('downsample')
xlabel('time(sec)');
ylabel('Amlitude');
grid on;

subplot(3,2,6)
[downf , w]=freqz(downX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(downf)));
title('downsample');
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;

sound(downX , 2*Fs/3);
pause(time_len + 1);


%% part E : use decimator 
%By default, decimate uses a lowpass Chebyshev Type I infinite impulse response (IIR) filter of order 8.
decimateX = decimate(upX , n);
figure();
subplot(2,1,1);
[downf , w]=freqz(downX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(downf)));
title('downsampler')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;

subplot(2,1,2);
[decimatef , w]=freqz(decimateX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(decimatef)));
title('decimator')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;
sound(decimateX , 2*Fs/3);
pause(time_len + 1);

%% part F : design filter 
% cutoff = min(pi/L , pi/n) 
% lowpassfilter fpass = Fs/6(pi/3) and fstop =Fs/5(2*pi/8)
num = [0.028  0.053 0.071  0.053 0.028];
denum = [1.000 -2.026 2.148 -1.159 0.279];
filterX=filter(num , denum , upX);
downfilterX = downsample(filterX,n);

figure();
subplot(3,1,1);
[downf , w]=freqz(downX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(downf)));
title('downsampler')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;

subplot(3,1,2);
[decimatef , w]=freqz(decimateX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(decimatef)));
title('decimator')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;

subplot(3,1,3);
[filterf , w]=freqz(downfilterX , -pi:pi/1000:pi);
plot(w/pi , 10*log(abs(filterf)));
title('downsampler + filter')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
grid on;
sound(downfilterX , 2*Fs/3);
