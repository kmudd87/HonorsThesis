function [corr, dircorr] = windWaveCorr64(stnName, wgWind, wgMeanDir, cdip)
    correlation_energy = corrcoef([wgWind cdip.sf'],'Rows','pairwise');
    correlation_energy = correlation_energy(1,2:length(correlation_energy));
    figure(1)
    plot(cdip.f,correlation_energy,'k')
    hold on
    scatter(cdip.f,correlation_energy,10,'o','filled','r')
    t = strcat('Energy Density - Wind Speed Correlation, 64-Band,',stnName);
    title(t)
    ylabel('correlation coefficient')
    xlabel('frequency')
    hold off
    
    correlation_direction = corrcoef([wgMeanDir cdip.md'],'Rows','pairwise');
    correlation_direction = correlation_direction(1,2:length(correlation_direction));
    figure(2)
    plot(cdip.f,correlation_direction,'k')
    hold on
    scatter(cdip.f,correlation_direction,10,'o','filled','b')
    t = strcat('Waveglider Mean Direction - CDIP Wind Direction Correlation, 64-Band, ',stnName);
    title(t)
    ylabel('correlation coefficient')
    xlabel('frequency')
    hold off
    
    %plot maximum and minimum correlations
    corr = correlation_energy;
    dircorr = correlation_direction;
    
    max_corr_index = find(corr == max(corr));
    min_corr_index = find(corr == min(corr));
    figure(4)
    subplot(2,1,1)
    scatter(wgWind,cdip.sf(max_corr_index,:),'filled');
    t = strcat('Maximum Correlation at',{' '}, num2str(cdip.f(max_corr_index)), ' Hz', stnName);
    title(t)
    xlabel('wind speed')
    ylabel('wave energy density')
    subplot(2,1,2)
    scatter(wgWind,cdip.sf(min_corr_index,:),'filled');
    t = strcat('Minimum Correlation at',{' '}, num2str(cdip.f(min_corr_index)), ' Hz', stnName);
    title(t)
    xlabel('wind speed')
    ylabel('wave energy density')
end


