function MBW573Stop(t)
%MBW573Stop sends the proper stopping commands to the MBW 573 dew point hygrometer
%
% SYNOPSIS: MBW573Stop(t)
%
% INPUT t is the handle for the instrument
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 08-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters = ["Pump.on","AMC.on","Heater","Control","MirrorCheck"];
for i=1:size(parameters,2)
    command = strcat(parameters(i),'=0');
    t.writeline(command);
end