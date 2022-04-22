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

setpoints=table2array(MBWsettings);
for i=1:size(MBWsettings,2)
    t.writeline(strcat(MBWsettings.Properties.VariableNames{i},'=',setpoints(i)));
end