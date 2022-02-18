function [] = pcolor_plot(wgt, wgWind, wgMeanDir, cdip)    
    %waveglider plots
    figure(1); clf; 
    subplot(211);
    plot(wgt, wgWind, 'k.')
    datetick(gca, 'x')
    sgtitle([datestr(wgt(1)) ' to ' datestr(wgt(end)) ' [UTC]'])
    title('Waveglider Wind Speed')
    grid on; box on;
    
    subplot(212);
    plot(wgt, wgMeanDir, 'k.')
    datetick(gca, 'x')
    title('Waveglider Mean Direction')
    grid on; box on;
    
    %CDIP plots
    figure(2); clf; 
    subplot(311);
    plot(cdip.time, cdip.md, 'k.')
    datetick(gca, 'x')
    title('CDIP Time, Mean Direction')
    grid on; box on;
       
    subplot(312);
    pcolor(cdip.time, cdip.f, log10(cdip.sf)); shading flat;
    datetick(gca, 'x')
    title('CDIP Time, Frequency, Energy Density')
    cb = colorbar;
    ylabel(cb,'energy density')
    grid on; box on;
    
    subplot(313);
    pcolor(cdip.time, cdip.f, cdip.md); shading flat;
    datetick(gca, 'x')
    title('CDIP Time, Frequency, Mean Direction')
    ylabel('frequency (Hz)')
    cb = colorbar;
    ylabel(cb,'mean direction')
    grid on; box on;   

    sgtitle([datestr(cdip.time(1)) ' to ' datestr(cdip.time(end)) ' [UTC]'])
end