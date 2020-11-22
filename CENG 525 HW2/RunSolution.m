function RunSolution(currentDirPath, currentSolutionFunctionName)
    try
        toRun = fullfile(currentDirPath, currentSolutionFunctionName);
        fprintf('Running "%s"', toRun);
        run(toRun)
    catch 
        
    end
end

