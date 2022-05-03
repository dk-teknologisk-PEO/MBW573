function MBW573Table = MBW573Read(t,MBW573Table)
%MBW573Read queries the instrument for the latest measurement data
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
    for i=1:size(MBW573Table,2)
        command = strcat(MBW573Table.Properties.VariableNames{i},'?');
        t.writeline(command)
        pause(0.05);
        dataTemp(i)=t.readline;
    end
    timestamp = datetime(now,'ConvertFrom','datenum');
    dataTable = array2timetable(dataTemp,'RowTimes',timestamp);
    dataTable.Properties.VariableNames=MBW573Table.Properties.VariableNames;
    MBW573Table=[MBW573Table;dataTable];
end