%startTime and endTime in YYYYmmDDHHMMSS format 
%freqTable is a readtable of a .txt from CDIP download 9-band energy
%gliderTable is metbuoy data table from gliderTime.m
function [ ] = windWaveCorr(freqTable, startTime, endTime, wgt, wgWind10m)   
    %edit start and end times because frequency band energies are to 30 min precision
    startTime = int2str(startTime);
    startTime = str2num(startTime(1:12));
    endTime = int2str(endTime);
    endTime = str2num(endTime(1:12));    
    %collecting times from frequency band table
    t_energy = freqTable{:,1};
    start_index = find(t_energy == startTime);
    end_index = find(t_energy == endTime);
    t_energy = t_energy(start_index:end_index);   
    % energies for each frequency band 
    energies = freqTable{start_index:end_index,4:12};
    %equivalent Hs (using equation from CDIP website)
    Hs = 4*sqrt(energies);    
    %convert energy times to datenum
    t_energy = int2str(t_energy);
    yr = str2num(t_energy(:,1:4));
    mo = str2num(t_energy(:,5:6));
    da = str2num(t_energy(:,7:8));
    hr = str2num(t_energy(:,9:10));
    mi = str2num(t_energy(:,11:12));
    time_vec = [yr mo da hr mi zeros(length(yr),1)];
    t_energy = datenum(time_vec);
    %remove waveglider times that have no corresonding values in energy times
    t_wind_new = NaN(length(t_energy),1);
    wind_wave_indices = NaN(length(t_energy),1);
    diff = 1000;
    index = 1;
        for i = 1:length(t_energy)
          for j = 1:length(wgt)
            if abs(t_energy(i)-wgt(j)) < diff
                diff = abs(t_energy(i)-wgt(j));
                index = j;
            end
          end
          t_wind_new(i) = wgt(index);
          wind_wave_indices(i) = index;
          index = 1;
          diff = 1000;
        end    
    %new wind speeds
    wgWind10m = wgWind10m(wind_wave_indices);    
    %plot wind speeds vs wave energies for each frequency band
    figure(1)
    subplot(3,3,1)
    scatter(wgWind10m,energies(:,1))
    title('22+s')
    subplot(3,3,2)
    scatter(wgWind10m,energies(:,2))
    title('18-22s')
    subplot(3,3,3)
    scatter(wgWind10m,energies(:,3))
    title('16-18s')
    subplot(3,3,4)
    scatter(wgWind10m,energies(:,4))
    title('14-16s')
    subplot(3,3,5)
    scatter(wgWind10m,energies(:,5))
    title('12-14s')
    subplot(3,3,6)
    scatter(wgWind10m,energies(:,6))
    title('10-12s')
    subplot(3,3,7)
    scatter(wgWind10m,energies(:,7))
    title('8-10s')
    subplot(3,3,8)
    scatter(wgWind10m,energies(:,8))
    title('6-8s')
    subplot(3,3,9)
    scatter(wgWind10m,energies(:,9))
    title('2-6s')
    sgtitle('Wind Speed vs. Wave Energy, 9-Band') 
    han=axes(figure(1),'visible','off'); 
    han.Title.Visible='on';
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    ylabel(han, 'band energy (cm^{2})')
    xlabel(han, 'wind speed')
    %wave energy - wind correlation
    covariance_energy = cov([wgWind10m energies]);
    ww_cov_energy = NaN(9,1);
    for i = 1:9
        ww_cov_energy(i) = covariance_energy(i+1,i+1);
    end
    freqs = [22 20 17 15 13 11 9 7 4];
    %plot correlation term for each average frequency band value 
    figure(2)
    scatter(freqs,ww_cov_energy,'o','filled')
    ylabel('covariance')
    xlabel('frequency (s)')
    title('Wind-Wave Energy Correlation')
%     %plot wind speeds vs equivalent Hs for each frequency band
%     figure(3)
%     subplot(3,3,1)
%     scatter(wgWind10m,Hs(:,1),'r')
%     title('22+s')
%     subplot(3,3,2)
%     scatter(wgWind10m,Hs(:,2),'r')
%     title('18-22s')
%     subplot(3,3,3)
%     scatter(wgWind10m,Hs(:,3),'r')
%     title('16-18s')
%     subplot(3,3,4)
%     scatter(wgWind10m,Hs(:,4),'r')
%     title('14-16s')
%     subplot(3,3,5)
%     scatter(wgWind10m,Hs(:,5),'r')
%     title('12-14s')
%     subplot(3,3,6)
%     scatter(wgWind10m,Hs(:,6),'r')
%     title('10-12s')
%     subplot(3,3,7)
%     scatter(wgWind10m,Hs(:,7),'r')
%     title('8-10s')
%     subplot(3,3,8)
%     scatter(wgWind10m,Hs(:,8),'r')
%     title('6-8s')
%     subplot(3,3,9)
%     scatter(wgWind10m,Hs(:,9),'r')
%     title('2-6s')
%     sgtitle('Wind Speed vs. Wave Energy')
%     han=axes(figure(3),'visible','off'); 
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'equivalent Hs (cm)')
%     xlabel(han, 'wind speed')
%     %equivalent Hs - wind correlation
%     covariance_Hs = cov([wgWind10m Hs]);
%     ww_cov_Hs = NaN(9,1);
%     for i = 1:9
%         ww_cov_Hs(i) = covariance_Hs(i+1,i+1);
%     end
%     freqs = [22 20 17 15 13 11 9 7 4];
%     %plot correlation term for each average frequency band value
%     figure(4)
%     scatter(freqs,ww_cov_Hs,'o','filled','r')
%     ylabel('covariance')
%     xlabel('frequency (s)')
%     title('Wind-Wave Correlation')
end