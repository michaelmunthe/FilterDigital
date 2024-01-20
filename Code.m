clear;
%Melakukan Audioread
[y1,Fs]=audioread('Input2.wav');

yleft = y1(:,1)';
yright = y1(:,2)';

%Membuat LPF dengan orde 32
koef = fir1(32,4000/Fs,'low');

%Proses pemfilteran sampel suara 1 dan penyimpanan output 1
y_out_1 = conv(yleft,koef);
audiowrite('Output_LPF_1.wav', y_out_1, Fs);

%Proses pemfilteran sampel suara 2 dan penyimpanan output 2
y_out_2 = conv(yright,koef);
audiowrite('Output_LPF_2.wav', y_out_2, Fs);

%Proses Modulasi dan Menyimpan Output Modulasi
mod_8k = ammod(y_out_1,8000,Fs);
audiowrite('Output_Modulasi_1.wav',mod_8k,48000);

mod_16k = ammod(y_out_2,16000,Fs);
audiowrite('Output_Modulasi_2.wav',mod_16k,48000);

mod_tot = mod_8k + mod_16k;
audiowrite('Output_Modulasi_Total.wav',mod_tot,48000);

%Melakukan Proses Demodulasi dan Menyimpan Output Demodulasi
amdemod_8k = amdemod(mod_tot,8000,Fs);
audiowrite('Output_Demodulasi_1.wav',amdemod_8k,48000);

amdemod_16k = amdemod(mod_tot,16000,Fs);
audiowrite('Output_Demodulasi_2.wav',amdemod_16k,48000);

%Pemfilteran terhadap Output Demodulasi
y_end_1 = filter(koef, 1, amdemod_8k);
audiowrite('Output_Akhir_1.wav',y_end_1,48000);

y_end_2 = filter(koef, 1, amdemod_16k);
audiowrite('Output_Akhir_2.wav',y_end_2,48000);