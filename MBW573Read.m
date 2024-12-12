function MBW573Table = MBW573Read(t, MBW573Table, settings)
%MBW573Read Queries the instrument for the latest measurement data
%
% SYNOPSIS: MBW573Table = MBW573Read(t,MBW573Table)
%
% INPUT t is the handle to the instrument
%		MBW573 is the table containing the measurement data	  
%
% OUTPUT MBW573 is the updated table containing the latest data
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 08-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timestamp = datetime(now,'ConvertFrom','datenum');

if seconds(timestamp - MBW573Table.Time(end))>10
    dataTemp=zeros(1,size(MBW573Table,2));
    mbwFile=fopen('mbwLog.txt','a'); % write raw data into a log
    for i=1:size(MBW573Table,2)
        command = strcat(MBW573Table.Properties.VariableNames{i},'?');
        t.writeline(command)
        %% wait until entire serial message has been received (number of available bytes is constant)
        numBytesOld = t.NumBytesAvailable;
        while true
            pause(0.01)
            numBytesNew = t.NumBytesAvailable;
            if numBytesNew==numBytesOld
                break
            else
                numBytesOld=numBytesNew;
            end
        end
        dataTemp(i)=t.readline;
        fprintf(mbwFile,'%s ',dataTemp(i));
    end
    fprintf(mbwFile,'\r');
    fclose(mbwFile);
    dataTable = array2timetable(dataTemp,'RowTimes',timestamp);
    dataTable.Properties.VariableNames=MBW573Table.Properties.VariableNames;
    MBW573Table=[MBW573Table;dataTable];

    %% Perform mirror check
    mirrorCheckIndices=find(MBW573Table.MirrorCheck==1);
    if ~isempty(mirrorCheckIndices)
        lastMirrorCheckIndices = mirrorCheckIndices(end);
    end
    if strcmp(settings.("AMC.on"), "0") % perform manual mirrorcheck
        if sum(MBW573Table.MirrorCheck==1)==0 || minutes(datetime('now') - MBW573Table.Time(lastMirrorCheckIndices))>double(settings.("AMC.cycleTime"))
            t.writeline('MirrorCheck=1')
        end
    end
end