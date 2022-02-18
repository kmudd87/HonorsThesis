function [] = freqplot(cdip, corr, wgWind, wgt)
    [I, B] = sort(corr,'descend');
    numfreqs = 3;
    figure(10)
    subplot(2,1,1)
    plot(cdip.time,cdip.sf(B(1),:))
    t = cdip.f(B(1));
    hold on
    for i = 2:numfreqs
        plot(cdip.time,cdip.sf(B(i),:))
        t = [t;cdip.f(B(i))];
    end
    legend(num2str(t),'wavelgider wind')
    hold off
    datetick
    ylabel('band energy')
    title('high wind speed - wave enrgy density correlations')
    subplot(2,1,2)
    plot(cdip.time,cdip.sf(B(end),:))
    t2 = cdip.f(B(end));
    hold on
    for i = length(B)-1:-1:length(B)-numfreqs+1
        plot(cdip.time,cdip.sf(B(i),:))
        t2 = [t2;cdip.f(B(i))];
    end
    legend(num2str(t2))
    hold off
    datetick
    ylabel('band energy')
    title('low wind speed - wave enrgy density correlations')
    sgtitle('Energy Density Time Series')
end