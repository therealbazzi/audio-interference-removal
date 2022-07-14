function main


%% Initialisations
% extract the time domain samples of the audio file '121.wav'
% using the MATLAB function audioread. The outputs of this MATLAB
% function are:
% y:  the time domain signal
% fs: the sampling frequency of the audio file '121.wav'
[y,fs] = audioread('121.wav');
% the sampling period is the reciprocal of fs
Ts = 1/fs;
% compute the length of the vector y
N = length(y);
disp('== Playing audio before interference removal ==')
sound(y,fs)
pause(6)
%% Time domain plotting
% define the time axis that is sampled at the sampling period,
% i.e. t= 0, Ts, 2Ts, 3Ts ... (N-1)Ts
tAxis = [0:Ts:Ts*(N-1)];
% open an empty figure
figure
% plot y vs tAxis
plot(tAxis,y)
% label the x axis as time sample kTs
xlabel('kTs')
% label the y axis as audio amplitude
ylabel('Audio amplitude')
% give a title to the plot
title('The time domain plot of the audio wav file')
% discritize the grid
grid on
grid minor

%% Frequency domain plotting
% apply an fft transform of the audio signal y that is
% now stored in Y
Y = fft(y);
% rearranges a Fourier transform Y by shifting
% the zero-frequency component to the center of the array,
% example: if Y = [1 1 0 2 2], then fftshift(Y) becomes
% fftshift(Y) = [2 2 1 1 0]. This is essential for the plotting
% because we want the central number to play the role of the central
% carrier frequency
Y = fftshift(Y);

if(mod(N,2) == 0 )
    % if the input length is even, then we define the frequency axis as
    % follows:
    fAxis = [0:(N-1)]*fs/N;
else
    fAxis = [0:(N-1)]*fs/(N-1);
end
% now we center the frequency axis at 0 by subtracting a factor of fs/2
fAxis = fAxis - fs/2;
% open an empty figure
figure
% plot y vs tAxis
plot(fAxis,abs(Y))
% label the x axis as time sample kTs
xlabel('frequencies (Hz)')
% label the y axis as audio amplitude
ylabel('Audio amplitude per frequency')
% give a title to the plot
title('The frequency domain plot of the audio wav file')
% discritize the grid
grid on
grid minor

%% correcting the signal: separating the music sound from the bell sound
% seperation freuqncy between the bell sound and the music sound
fc = 1000;
% initialise count to be 1
count = 1;
% initialise Ybell to be a vector of all zeros of size N (same size as Y)
Ybell = zeros(N,1);
% initialise Ymusic to be a vector of all zeros of size N (same size as Y)
Ymusic = zeros(N,1);
% loop over all freqeuncy values
for f = fAxis
    % if we are outside the band [-fc,fc] then we claim the signal to be a
    % bell sound because. In our case we have set fc = 1000 because usually
    % frequencies higher than this value correspond to bell sounds
   if( f < -fc || f > fc)
       Ybell(count) = Y(count);
   else
       % otherwise, if we are within [-fc,fc] we have the music sound
       Ymusic(count) = Y(count);
   end
   % increment count for next iteration in loop
   count = count + 1;
end
% apply an inverse fftshift (ifftshift) because we need to do an inverse
% fft later on. If we did not do fftshift above, then we can directly do 
% an inverse fft to obtain our time domain signal
Ybell_unshifted = ifftshift(Ybell);
% apply inverse fft (ifft) to obtain our time domain signal of the bell
% sound
ybell = ifft(Ybell_unshifted);
% apply an inverse fftshift (ifftshift) because we need to do an inverse
% fft later on. If we did not do fftshift above, then we can directly do 
% an inverse fft to obtain our time domain signal.
Ymusic_unshifted = ifftshift(Ymusic);
% apply inverse fft (ifft) to obtain our time domain signal of the music
% sound
ymusic = ifft(Ymusic_unshifted);

% open an empty figure
figure
% plot y vs tAxis
plot(fAxis,abs(Ybell),'r')
hold on
plot(fAxis,abs(Ymusic),'b')
% label the x axis as time sample kTs
xlabel('frequencies (Hz)')
% label the y axis as audio amplitude
ylabel('Audio amplitude per frequency')
% give a title to the plot
title('The frequency domain plot of the audio wav file')
% insert a legend
legend('Bell sound','Music sound')
% discritize the grid
grid on
grid minor
% up to this point, we managed to separate the correct signal, that is
% ymusic from the bell sound ybell. 




%% Plotting the correct (music) signal in time domain

% open an empty figure
figure
% plot y vs tAxis
plot(tAxis,ymusic)
% label the x axis as time sample kTs
xlabel('kTs')
% label the y axis as audio amplitude
ylabel('Audio amplitude')
% give a title to the plot
title('The time domain plot of the corrected signal (Music)')
% discritize the grid
grid on
grid minor

%% Plotting the correct (music) signal in time domain
% open an empty figure
figure
% plot y vs tAxis
plot(fAxis,abs(Ymusic))
% label the x axis as time sample kTs
xlabel('frequencies (Hz)')
% label the y axis as audio amplitude
ylabel('Audio amplitude per frequency')
% give a title to the plot
title('The frequency domain plot of the corrected signal (Music)')
% discritize the grid
grid on
grid minor

%% Saving the corrected audio signal 
% we save the corrected audio signal under the name:
% 'correctedsignal.wav'
% The corrected audio signal is contained in vector:
% ymusic
% The corrected audio signal is also sampled at:
% fs
% We use the MATLAB built-in function audiowrite to save 
% the corrected audio signal with the three parameters 
% mentioned above as inputs: ('.wav',ymusic,fs)
% This function should create the file correctedsignal.wav
% in the directory we are in. Even though we have it now,
% you can delete the file and run the program again, it will
% be generated after the function main is executed.
audiowrite('correctedsignal.wav',ymusic,fs);
% play the corrected signal
disp('== Playing audio after interference removal ==')
sound(ymusic,fs)



