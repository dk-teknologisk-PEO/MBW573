function [MBW573Table] = MBW573CreateTable()
%MBW573CreateTable initializes a table for storing MBW 573 data
%
% SYNOPSIS: [MBW573Table] = MBW573CreateTable()
%
% INPUT no input arguments
%
% OUTPUT MBW573Table is a timetable containing measured values from the MBW 573 dew point meter
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 08-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
outputs = ["Stable","Pump","Heater","MirrorCheck","Control","DP","FP","P","Th","Tx"];
initialArray = zeros(1,size(outputs,2));

MBW573Table=array2timetable(initialArray,'RowTimes',datetime(now,'ConvertFrom','datenum'));
MBW573Table.Properties.VariableNames=outputs;