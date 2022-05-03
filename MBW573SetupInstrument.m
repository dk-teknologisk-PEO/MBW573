function MBW573SetupInstrument(t,MBWsettings)
%MBW573SetupInstrument makes the initial setup of the instrument
%
% SYNOPSIS: MBW573SetupInstrument(t,settings)
%
% INPUT t is the handle to the instrument
%		settings contains information on the setup of the instrument  
%
% OUTPUT there is no output from the function
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 08-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setPoints=table2array(MBWsettings);
setPointNames=string(MBWsettings.Properties.VariableNames);

%% activation of pump, heater, and control must go last, so the order of the setpoints must be re-allocated
arraysToMove = ismember(setPointNames,["Pump","Heater","Control"]); % find indeces of the elements to move
setPoints(end+1:end+3)=setPoints(arraysToMove); %add them to the end of the arrays
setPointNames(end+1:end+3)=setPointNames(arraysToMove);
setPoints(arraysToMove)=[]; % remove them from their initial location
setPointNames(arraysToMove)=[];


for i=1:size(MBWsettings,2)
%     strcat(setPointNames(i),'=',setPoints(i))
    t.writeline(strcat(setPointNames(i),'=',setPoints(i)));
    pause(0.05);
end