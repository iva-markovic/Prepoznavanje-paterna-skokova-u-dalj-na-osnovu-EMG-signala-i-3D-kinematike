close all 
clear all
clc

fs=2048;
% fs=2000;

%Frekvencije odsecanja za bandpass filtar
low_band=30*2/fs; high_band=250*2/fs;


for k=2:5
    preklapanja=zeros(11,22);
    for i=1:11
       %Ucitavanje podataka iz fajla
        naziv=['skok_',num2str(k),'_',num2str(i),'.csv'];


        podaci=dlmread(naziv,';',3);

        vreme=podaci(:,1);
        signali=podaci(:,2:end);


        %Polazni nizovi za anvelopu i on-off signale
        ON_OFF_signali=zeros(length(signali(:,1)),12);
        anvelope_signala=zeros(length(signali(:,1)),12);

        %For petlja u kojoj kreiramo on off signal za svaki pojedinacni signal u
        %skoku
        for j=1:12
            signal=signali(:,j); %Izdvajanje pojedinacnog signala u skoku

            [b,a] = butter(5,[low_band,high_band],'bandpass');

            %Filtriranje signala bandpass filtrom
            signal=filtfilt(b,a,signal);

            %TKEO filtar
            %signal(2:end-1)= signal(2:end-1).^2-signal(1:end-2).*signal(3:end);

            %Izvlacenje anvelope
            signal=medfilt1(signal,3);
            signal_anvelopa=abs(signal);

            prozor=100;
            signal_anvelopa=sqrt(movmean(signal_anvelopa.^2,prozor));

            anvelope_signala(:,j)=signal_anvelopa;

            %Pravljenje ON OFF signala
            signal_kraci=signal_anvelopa(signal_anvelopa>max(signal_anvelopa)*0.015);
            granica=mean(signal_kraci);

            signal_konacno=(signal_anvelopa>granica).*ones(length(signal_anvelopa),1);

            ON_OFF_signali(:,j)=signal_konacno;

        end


        figure(11*(k-2)+i)
        subplot(6,2,1)
        plot(vreme,abs(signali(:,1))); hold all
        plot(vreme,anvelope_signala(:,1),'LineWidth',3);
        plot(vreme,ON_OFF_signali(:,1)*max(anvelope_signala(:,1))*0.75,'LineWidth',3);
        %xlabel('Vreme [s]');
        %ylabel('Napon [uV]');
        %legend('Filtriran signal','Anvelopa', 'ON/OFF signal (skaliran)');
        %title('');

        subplot(6,2,2)
        plot(vreme,abs(signali(:,2))); hold all
        plot(vreme,anvelope_signala(:,2));
        plot(vreme,ON_OFF_signali(:,2)*max(anvelope_signala(:,2))*0.75);
        title('D L unutra');

        subplot(6,2,3)
        plot(vreme,abs(signali(:,3))); hold all
        plot(vreme,anvelope_signala(:,3));
        plot(vreme,ON_OFF_signali(:,3)*max(anvelope_signala(:,3))*0.75);
        title('D Z unutra');

        subplot(6,2,4)
        plot(vreme,abs(signali(:,4))); hold all
        plot(vreme,anvelope_signala(:,4));
        plot(vreme,ON_OFF_signali(:,4)*max(anvelope_signala(:,4))*0.75);
        title('D Z spolja');

        subplot(6,2,5)
        plot(vreme,abs(signali(:,5))); hold all
        plot(vreme,anvelope_signala(:,5));
        plot(vreme,ON_OFF_signali(:,5)*max(anvelope_signala(:,5))*0.75);
        title('L Z spolja');

        subplot(6,2,6)
        plot(vreme,abs(signali(:,6))); hold all
        plot(vreme,anvelope_signala(:,6));
        plot(vreme,ON_OFF_signali(:,6)*max(anvelope_signala(:,6))*0.75);
        title('L Z unutra');

        subplot(6,2,7)
        plot(vreme,abs(signali(:,7))); hold all
        plot(vreme,anvelope_signala(:,7));
        plot(vreme,ON_OFF_signali(:,7)*max(anvelope_signala(:,7))*0.75);
        title('L L unutra');

        subplot(6,2,8)
        plot(vreme,abs(signali(:,8))); hold all
        plot(vreme,anvelope_signala(:,8));
        plot(vreme,ON_OFF_signali(:,8)*max(anvelope_signala(:,8))*0.75);
        title('L L spolja');

        subplot(6,2,9)
        plot(vreme,abs(signali(:,9))); hold all
        plot(vreme,anvelope_signala(:,9));
        plot(vreme,ON_OFF_signali(:,9)*max(anvelope_signala(:,9))*0.75);
        title('L B unutra');

        subplot(6,2,10)
        plot(vreme,abs(signali(:,10))); hold all
        plot(vreme,anvelope_signala(:,10));
        plot(vreme,ON_OFF_signali(:,10)*max(anvelope_signala(:,10))*0.75);
        title('L B spolja');

        subplot(6,2,11)
        plot(vreme,abs(signali(:,11))); hold all
        plot(vreme,anvelope_signala(:,11));
        plot(vreme,ON_OFF_signali(:,11)*max(anvelope_signala(:,11))*0.75);
        title('D B spolja');

        subplot(6,2,12)
        plot(vreme,abs(signali(:,12))); hold all
        plot(vreme,anvelope_signala(:,12));
        plot(vreme,ON_OFF_signali(:,12)*max(anvelope_signala(:,12))*0.75);
        title('D B unutra');
%}
        %Odredjivanje vrednosti preklapanja

        %Preklapanje odredjujemo na osnovu on off signala

        preklapanja(i,1)=sum(ON_OFF_signali(:,10).*ON_OFF_signali(:,11))/mean(sum(ON_OFF_signali(:,10)),sum(ON_OFF_signali(:,11)));
        preklapanja(i,2)=sum(ON_OFF_signali(:,9).*ON_OFF_signali(:,12))/mean(sum(ON_OFF_signali(:,9)),sum(ON_OFF_signali(:,12)));
        preklapanja(i,3)=sum(ON_OFF_signali(:,4).*ON_OFF_signali(:,5))/mean(sum(ON_OFF_signali(:,4)),sum(ON_OFF_signali(:,5)));
        preklapanja(i,4)=sum(ON_OFF_signali(:,3).*ON_OFF_signali(:,6))/mean(sum(ON_OFF_signali(:,3)),sum(ON_OFF_signali(:,6)));
        preklapanja(i,5)=sum(ON_OFF_signali(:,1).*ON_OFF_signali(:,8))/mean(sum(ON_OFF_signali(:,1)),sum(ON_OFF_signali(:,8)));
        preklapanja(i,6)=sum(ON_OFF_signali(:,2).*ON_OFF_signali(:,7))/mean(sum(ON_OFF_signali(:,2)),sum(ON_OFF_signali(:,7)));

        preklapanja(i,7)=sum(ON_OFF_signali(:,5).*ON_OFF_signali(:,10))/mean(sum(ON_OFF_signali(:,5)),sum(ON_OFF_signali(:,10)));
        preklapanja(i,8)=sum(ON_OFF_signali(:,5).*ON_OFF_signali(:,9))/mean(sum(ON_OFF_signali(:,5)),sum(ON_OFF_signali(:,9)));
        preklapanja(i,9)=sum(ON_OFF_signali(:,6).*ON_OFF_signali(:,10))/mean(sum(ON_OFF_signali(:,6)),sum(ON_OFF_signali(:,10)));
        preklapanja(i,10)=sum(ON_OFF_signali(:,6).*ON_OFF_signali(:,9))/mean(sum(ON_OFF_signali(:,6)),sum(ON_OFF_signali(:,9)));

        preklapanja(i,11)=sum(ON_OFF_signali(:,4).*ON_OFF_signali(:,11))/mean(sum(ON_OFF_signali(:,4)),sum(ON_OFF_signali(:,11)));
        preklapanja(i,12)=sum(ON_OFF_signali(:,4).*ON_OFF_signali(:,12))/mean(sum(ON_OFF_signali(:,4)),sum(ON_OFF_signali(:,12)));
        preklapanja(i,13)=sum(ON_OFF_signali(:,3).*ON_OFF_signali(:,11))/mean(sum(ON_OFF_signali(:,3)),sum(ON_OFF_signali(:,11)));
        preklapanja(i,14)=sum(ON_OFF_signali(:,3).*ON_OFF_signali(:,12))/mean(sum(ON_OFF_signali(:,3)),sum(ON_OFF_signali(:,12)));

        preklapanja(i,15)=sum(ON_OFF_signali(:,8).*ON_OFF_signali(:,10))/mean(sum(ON_OFF_signali(:,8)),sum(ON_OFF_signali(:,10)));
        preklapanja(i,16)=sum(ON_OFF_signali(:,8).*ON_OFF_signali(:,9))/mean(sum(ON_OFF_signali(:,8)),sum(ON_OFF_signali(:,9)));
        preklapanja(i,17)=sum(ON_OFF_signali(:,7).*ON_OFF_signali(:,10))/mean(sum(ON_OFF_signali(:,7)),sum(ON_OFF_signali(:,10)));
        preklapanja(i,18)=sum(ON_OFF_signali(:,7).*ON_OFF_signali(:,9))/mean(sum(ON_OFF_signali(:,7)),sum(ON_OFF_signali(:,9)));

        preklapanja(i,19)=sum(ON_OFF_signali(:,1).*ON_OFF_signali(:,11))/mean(sum(ON_OFF_signali(:,1)),sum(ON_OFF_signali(:,11)));
        preklapanja(i,20)=sum(ON_OFF_signali(:,1).*ON_OFF_signali(:,12))/mean(sum(ON_OFF_signali(:,1)),sum(ON_OFF_signali(:,12)));
        preklapanja(i,21)=sum(ON_OFF_signali(:,2).*ON_OFF_signali(:,11))/mean(sum(ON_OFF_signali(:,2)),sum(ON_OFF_signali(:,11)));
        preklapanja(i,22)=sum(ON_OFF_signali(:,2).*ON_OFF_signali(:,12))/mean(sum(ON_OFF_signali(:,2)),sum(ON_OFF_signali(:,12)));

    end
    za_upis=['preklapanja_ispitanik_',num2str(k),'.csv'];
    dlmwrite(za_upis,preklapanja,'precision','%.6f');
end
    



