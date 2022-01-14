%gliderTable is a metbuoy data table
%startTime is desired start time in format YYYYmmDDHHMMSS
%endTime is desired end time in format YYYYmmDDHHMMSS
%wgTime is only a waveglider time vector with times within limits
%wgWind10m is only a waveglider wind vector with times within limits
%wgIndices are just the indices of all the values within correct times
function [wgt wgWind10m wgIndices] = gliderTime(gliderTable, startTime, endTime)
    %convert startTime
    startTime = int2str(startTime);
    y_start = str2num(startTime(:,1:4));
    m_start = str2num(startTime(:,5:6));
    d_start = str2num(startTime(:,7:8));
    h_start = str2num(startTime(:,9:10));
    min_start = str2num(startTime(:,11:12));
    s_start = str2num(startTime(:,13:14));
    %convert endTime
    endTime = int2str(endTime);
    y_end = str2num(endTime(:,1:4));
    m_end = str2num(endTime(:,5:6));
    d_end = str2num(endTime(:,7:8));
    h_end = str2num(endTime(:,9:10));
    min_end = str2num(endTime(:,11:12));
    s_end = str2num(endTime(:,13:14));
    %pull times from table and convert
    t_wg = gliderTable{:,6};
    t_wg = datenum(datetime(t_wg, 'ConvertFrom', 'posixtime'));
    [Y, M, D, H, MIN, S] = datevec(t_wg);
    %find times startTime to endTime
    start_index = find(Y==y_start & M==m_start & D==d_start & H==h_start & MIN>=min_start & S>=s_start);
    start_index = start_index(1);
    end_index = find(Y==y_end & M==m_end & D==d_end & H==h_end & MIN>=min_end & S>=s_end);
    end_index = end_index(1)-1;
    %update vars for times
    wgt = t_wg(start_index:end_index);
    wgWind10m = gliderTable{:,20};
    wgWind10m = wgWind10m(start_index:end_index);
    wgIndices = start_index:end_index;
end
