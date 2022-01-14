%startTime is start time in format YYYYMMDDHHmmSS
%endTime is end time in format YYYYMMDDHHmmSS
%CDIPt is times within desired range
%CDIPHs is significant wave heights within desired time range
%time is ncread of thredds.cdip.ucsd.edu for waveTime
%Hs is ncread of thredds.cdip.ucsd.edu for waveHs
function [CDIPt CDIPHs] = CDIPtime(time, Hs, startTime, endTime)
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

    CDIPt = datenum(datetime(time, 'ConvertFrom', 'posixtime'));
    %time (vec)
    [Y, M, D, H, MIN, S] = datevec(CDIPt);
    %find time indices
    start_index = find(Y==y_start & M==m_start & D==d_start & H==h_start & MIN>=min_start & S>=s_start);
    start_index = start_index(1);
    end_index = find(Y==y_end & M==m_end & D==d_end & H==h_end & MIN>=min_end & S>=s_end);
    end_index = end_index(1)-1;
    CDIPt = CDIPt(start_index:end_index);
    CDIPHs = Hs(start_index:end_index);
end
