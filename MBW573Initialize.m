function [t, model] = MBW573Initialize(Address,Port)
%MBW573Initialize creates and returns a handle for the instrument
%
% SYNOPSIS: [t, model] = MBW573Initialize(Address,Port)
%
% INPUT Address is the IP-address for the instrument
%		Port is the port for the instrument           
%
% OUTPUT t is the handle for the instrument
%			model is the model of the insitrument  
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 08-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = tcpclient(Address,Port);

% configure the terminator for the instrument
t.configureTerminator("CR/LF");

% check the connection
t.writeline('IDN?')
i=0;
while true
    if t.NumBytesAvailable>0
        responseCode = 1;
        responseText = t.readline;
        break
    elseif i==10
        responseCode = -1;
    else
        pause(1);
        i=i+1;
    end
end
if responseCode==-1
    disp('No connection to the instrument')
    return
elseif responseCode==1
    model=responseText;
end

