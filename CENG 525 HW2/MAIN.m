%Run MAIN.m 
%Change FolderName and SolutionName 
%Example: 
%Running "HW2\Solution1.m">> Solution1

clear all;
close all; 
clc;
    
currentMatlabFunctionNames = {  'Solution1.m', 
                                'Solution2.m', 
                                'Solution3.m',
                                'Solution4.m',
                                'Solution5.m' };

SolutionName = currentMatlabFunctionNames{1};
FolderName = 'HW2/';
RunSolution(FolderName, SolutionName)

