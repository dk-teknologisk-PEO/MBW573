function [MBWsettings, address, port] = MBW573ReadSetupFile(setupPath)
%MBW573ReadSetupFile opens and reads the setting parameters for the MBW 573 dew point hygrometer
%
% SYNOPSIS: [settings, address, port] = MBW573ReadSetupFile(setupPath)
%
% INPUT setupPath is the path for the setup file
%
% OUTPUT settings are the instrument settings. All parameters are in minutes or °C.
%			address is the IP address of the instrument
%			port is the port used for the instrument                                    
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 08-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setupPath = "C:\Users\peo\Documents\GitHub\FLUKE1586A\";
setupFile = "setup.txt";

location = strcat(setupPath,setupFile);

setupFile = fopen(location,'r');
setup = fscanf(setupFile,'%c'); % read data as characters
setupLines=strsplit(setup,'\r\n'); % split file into lines
startLine = find(setupLines=="%% MBW 573 %%")+1; % find beginning of MBW setup

i=startLine;
field=["setting"];
data = ["data"];
while true
    if setupLines{i}(1:2)=="%%"
        break
    elseif setupLines{i}(1)=="%"
    else
        setupSplit = strsplit(setupLines{i},':');
        field = [field,strtrim(setupSplit{1})];
        data = [data,strtrim(strsplit(setupSplit{2},','))];
    end
    i=i+1;
end
field(1)=[];
data(1)=[];
address=char(data(field=='address'));
port=str2double(data(field=='port'));
data(field=='address' | field=='port')=[];
field(field=='address' | field=='port')=[];

MBWsettings=array2table(data);
MBWsettings.Properties.VariableNames=field;
MBWsettings.("AMC.on")="0";