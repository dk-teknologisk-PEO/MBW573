clear variables
close all
clc

[MBWsettings, MBWAddress, MBWPort] = MBW573ReadSetupFile("C:\materialefugt\materialefugt\");
[MBW573Table] = MBW573CreateTable();
[t, model] = MBW573Initialize(MBWAddress,MBWPort);
MBW573SetupInstrument(t,MBWsettings)

tStart=datetime('now');
while i<60
    tNow=datetime('now');
    deltaT=(tNow-tStart)*24*60*60;
    if deltaT>1
        MBW573Table = MBW573Read(t,MBW573Table);
        tStart=tStart+1/(24*60*60);
        i=i+1;
    end  
end

MBW573Stop(t)