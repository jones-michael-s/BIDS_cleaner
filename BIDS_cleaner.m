function BIDS_cleaner()

%----------------------------------------------------------------------------------
% tool to auto-correct errors in BIDS data. (structure/syntax/convention)
%----------------------------------------------------------------------------------
   
   
    directory = uigetdir('select data directory');
   
   % directory = '/Users/andrewweng/Data/ds000170';
   
    addpath(genpath(directory));
    problemLog = {};
    
    if directory == 0
        disp("please select the data directory and try again");
        return
    end
    if directory ~= 0
   
        %Taskqueue
         
       % writes scan log to current matlab directory
        diary BIDS_scan_log;
        
        subjectPaths = getPaths(directory);
        jsonFiles = (getJson(directory));
        fixJson(jsonFiles,directory,problemLog);
        fixTSV(subjectPaths,directory,problemLog);
        excludefmap(subjectPaths,problemLog);
        fixCorruption(subjectPaths,directory,problemLog);
        fileConsistency(subjectPaths,directory,problemLog);
        eventToUppercase(directory,problemLog);
        disp('-------------------------------------------------------------');
        disp('BIDS scan complete');
        disp('-------------------------------------------------------------');
          
    end
        
        %prints problem log to a BIDS_tool_repairLog.txt
        diary off;
   
        disp('done');
        
        clearvars;

end
























