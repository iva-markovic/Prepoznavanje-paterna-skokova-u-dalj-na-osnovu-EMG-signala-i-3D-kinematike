close all
clear all

for i=1:12
    % Odabir ispitanika - skok_br_ gde je br broj ispitanika
    naziv=['skok_5_',num2str(i),'.csv'];
    podaci=dlmread(naziv,';',3);

    vreme=podaci(:,1);
    signali=podaci(:,2:end);

    figure(i)
    subplot(6,2,1)
    plot(vreme,abs(signali(:,1))); hold all
    %xlabel('Vreme [s]');
    %ylabel('Napon [uV]');
    
    subplot(6,2,2)
    plot(vreme,abs(signali(:,2))); hold all

    subplot(6,2,3)
    plot(vreme,abs(signali(:,3))); hold all

    subplot(6,2,4)
    plot(vreme,abs(signali(:,4))); hold all

    subplot(6,2,5)
    plot(vreme,abs(signali(:,5))); hold all

    subplot(6,2,6)
    plot(vreme,abs(signali(:,6))); hold all

    subplot(6,2,7)
    plot(vreme,abs(signali(:,7))); hold all

    subplot(6,2,8)
    plot(vreme,abs(signali(:,8))); hold all

    subplot(6,2,9)
    plot(vreme,abs(signali(:,9))); hold all

    subplot(6,2,10)
    plot(vreme,abs(signali(:,10))); hold all

    subplot(6,2,11)
    plot(vreme,abs(signali(:,11))); hold all

    subplot(6,2,12)
    plot(vreme,abs(signali(:,12))); hold all
    
end