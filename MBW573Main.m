clear variables
close all
clc

[MBWSettings, MBWAddress, MBWPort] = MBW573ReadSetupFile("..\materialefugt\");
[MBW573Table] = MBW573CreateTable();
[t, model] = MBW573Initialize(MBWAddress,MBWPort);
MBW573SetupInstrument(t,MBWSettings)

figure(1)
tStart = datetime('now');
tControl = datetime('now');
while minutes(datetime("now") - tStart) < 30
    tCurrent = datetime('now');
    deltaT = (tCurrent - tControl);
    if seconds(deltaT) > 15
        MBW573Table = MBW573Read(t, MBW573Table, MBWSettings);
        stackedplot(MBW573Table)
        tControl = tCurrent;
    else
        pause(5)
    end  
end

disp('Finished collecting data')

MBW573Stop(t)