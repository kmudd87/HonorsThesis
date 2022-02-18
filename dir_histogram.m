%histogram 
function [hist] = dir_histogram(cdip, wgMeanDir, corr)
    %find highest and lowest correlation frequencies
    max_corr = max(corr);
    max_index = find(corr == max_corr);
    min_corr = min(corr);
    min_index = find(corr == min_corr);
    %bin width
    his_lims = 0:5:360;
    %plot high correlation histogram 
    figure(1)
    histogram(cdip.md(max_index,:),his_lims,'faceColor','b')
    hold on
    histogram(wgMeanDir,his_lims,'faceColor','y')
    title('Waveglider and CDIP Mean Direction, Highest Correlation Frequency')
    xlabel('direction in degrees')
    hold off
    %plot low correlation histogram
    figure(2)
    histogram(cdip.md(min_index,:),his_lims,'faceColor','b')
    hold on
    histogram(wgMeanDir,his_lims,'faceColor','y')
    title('Waveglider and CDIP Mean Direction, Lowest Correlation Frequency')
    xlabel('direction in degrees')
    hold off
    %% 
    summ = sum(abs(histcounts(cdip.md(1,:),his_lims) - histcounts(wgMeanDir, his_lims)));
    index = 1;
    hist = NaN(1,length(cdip.md(:,1)));
    for i = 1:length(cdip.md(:,1))
        total = sum(abs(histcounts(cdip.md(i,:),his_lims) - histcounts(wgMeanDir, his_lims)));
        hist(i) = 1/total;
        if total < summ
            summ = total;
            index = i;
        end
    end
    hist = [cdip.f;hist];
    figure(3)
    histogram(cdip.md(index,:),his_lims,'faceColor','b')
    hold on
    histogram(wgMeanDir,his_lims,'faceColor','y')
    t = strcat('Waveglider and CDIP Mean Direction,',{' '}, num2str(cdip.f(index)),'Hz');
    title(t)
    xlabel('direction in degrees')
    hold off
    figure(5)
    plot(hist(1,:),hist(2,:))
    ylabel('1/total of bin differences')
    xlabel('frequency (Hz)')
    title(strcat('Wind Direction Histogram Differences',{' '},num2str(cdip.f(index)),'Hz'))
    
    %direction differences
    %plot high correlation histogram 
    %raw difference
    dir_diff_max = abs(cdip.md(max_index,:)-wgMeanDir');
    indices = find(dir_diff_max > 180);
    dir_diff_max(indices) = dir_diff_max(indices)-180;
    %plot for max correlation frequency
    figure(6)
    histogram(dir_diff_max,his_lims,'faceColor','b')
    title('Waveglider and CDIP Mean Direction Difference, Highest Correlation Frequency')
    xlabel('degrees')
    %plot low correlation histogram
    %raw difference
    dir_diff_min = abs(cdip.md(min_index,:)-wgMeanDir');
    indices = find(dir_diff_min > 180);
    dir_diff_min(indices) = dir_diff_min(indices)-180;
    %plot for max correlation frequency
    figure(7)
    histogram(dir_diff_min,his_lims,'faceColor','b')
    title('Waveglider and CDIP Mean Direction Difference, Lowest Correlation Frequency')
    xlabel('degrees')
    %% 
    %total difference for each frequency band
    differences = NaN(length(cdip.f),1);
    for i = 1:length(cdip.f)
        dir_diff = abs(cdip.md(i,:)-wgMeanDir');
        indices = find(dir_diff > 180);
        dir_diff(indices) = dir_diff(indices)-180;
        differences(i) = sum(dir_diff);
    end
    figure(8)
    plot(cdip.f,differences)
    title('Waveglider-CDIP Buoy Total Error')
    ylabel('total error (degrees)')
    xlabel('frequency (Hz)')
    %%
    md = NaN(length(cdip.f),length(cdip.time));
    for i = 1:length(cdip.f)
        mdx = abs(cdip.md(i,:)-wgMeanDir');
        indices = find(mdx > 180);
        mdx(indices) = mdx(indices)-180;
        md(i,:) = mdx;
    end
    figure(9)
    pcolor(cdip.time, cdip.f, md)
    shading interp;
    datetick
    cb = colorbar;
    ylabel('frequency  (Hz)')
    ylabel(cb,'direction difference')
    title('Direction Error')
    caxis([0 50])
end