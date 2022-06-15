close all
clear all
clc


fs=2048;


%Frekvencije odsecanja za bandpass filtar
low_band=20*2/fs; high_band=250*2/fs;


for k=2:5
    preklapanja=zeros(11,22);
    fmax_usrednjene=zeros(11,6);
    totalno_usrednjavanje=zeros(11,3);
    for i=1:11
       %Ucitavanje podataka iz fajla
        naziv=['skok_',num2str(k),'_',num2str(i),'.csv'];


        podaci=dlmread(naziv,';',3);

        vreme=podaci(:,1);
        signali=podaci(:,2:end);
        
        L=length(vreme);
        NFFT = 2^nextpow2(L);
        X =fft(signali, NFFT)/L;
        
        f1=0:fs/NFFT:fs/2;
        
        X1=abs(X(1:NFFT/2+1,:));
        X1(2:NFFT/2+1,:)=2*X1(2:NFFT/2+1,:);
        
        %Kreiranje bandpass fitra
        [b,a] = butter(5,[low_band,high_band],'bandpass');
        
        signali_filtered=zeros(size(signali));

        %Filtriranje 
        for j=1:length(signali(1,:))
            signali_filtered(:,j)=filtfilt(b,a,signali(:,j));
        end
        
        X_filtered =fft(signali_filtered, NFFT)/L;
        
        X1_filtered=abs(X_filtered(1:NFFT/2+1,:));
        X1_filtered(2:NFFT/2+1,:)=2*X1_filtered(2:NFFT/2+1,:);
        
        figure(11*(k-2)+i)
        %subplot(6,2,1)
        plot(f1,X1(:,1));hold all
        plot(f1,X1_filtered(:,1));
        %title('D L spolja');
        xlabel('f [Hz]');
        xlim([0 600]);
        legend('Originalan signal','Filtriran signal');
        
%{
        subplot(6,2,2)
        plot(f1,X1(:,2));hold all
        plot(f1,X1_filtered(:,2));
        title('D L unutra');

        subplot(6,2,3)
        plot(f1,X1(:,3));hold all
        plot(f1,X1_filtered(:,3));
        title('D Z unutra');

        subplot(6,2,4)
        plot(f1,X1(:,4));hold all
        plot(f1,X1_filtered(:,4));
        title('D Z spolja');

        subplot(6,2,5)
        plot(f1,X1(:,5));hold all
        plot(f1,X1_filtered(:,5));
        title('L Z spolja');

        subplot(6,2,6)
        plot(f1,X1(:,6));hold all
        plot(f1,X1_filtered(:,6));
        title('L Z unutra');

        subplot(6,2,7)
        plot(f1,X1(:,7));hold all
        plot(f1,X1_filtered(:,7));
        title('L L unutra');

        subplot(6,2,8)
        plot(f1,X1(:,8));hold all
        plot(f1,X1_filtered(:,8));
        title('L L spolja');

        subplot(6,2,9)
        plot(f1,X1(:,9));hold all
        plot(f1,X1_filtered(:,9));
        title('L B unutra');

        subplot(6,2,10)
        plot(f1,X1(:,10));hold all
        plot(f1,X1_filtered(:,10));
        title('L B spolja');

        subplot(6,2,11)
        plot(f1,X1(:,11));hold all
        plot(f1,X1_filtered(:,11));
        title('D B spolja');

        subplot(6,2,12)
        plot(f1,X1(:,12));hold all
        plot(f1,X1_filtered(:,12));
        title('D B unutra');
        %}
        [maximum,ind]=max(X1_filtered);
        fmax=f1(ind);
        
        fmax_usrednjene(i,:)=[(fmax(2)+fmax(7))/2,(fmax(1)+fmax(8))/2,(fmax(9)+fmax(12))/2,(fmax(10)+fmax(11))/2,(fmax(3)+fmax(6))/2,(fmax(4)+fmax(5))/2];
        totalno_usrednjavanje(i,:)=[(fmax_usrednjene(i,1)+fmax_usrednjene(i,2))/2,(fmax_usrednjene(i,3)+fmax_usrednjene(i,4))/2,(fmax_usrednjene(i,5)+fmax_usrednjene(i,6))/2];
    end
    za_upis=['frekvencije_ispitanik_',num2str(k),'.csv'];
    dlmwrite(za_upis,fmax_usrednjene,'precision','%.4f');
    dlmwrite(za_upis,totalno_usrednjavanje,'-append','precision','%.4f');
    
    
    
end