function [valid,TC] = verify(TC)

%VERIFY Check validity of threecomp object.
% TC = VERIFY(TC) Prep and check validity of a threecomp object. Runs a
% series of tests to ensure that the threecomp object meets minimum
% standards and is suitable for further processing. 
%
% CHECKS FOR CONSISTENCY BETWEEN TRACES:
%   matching start times
%   matching stations
%   matching units
%   matching frequencies
%   compatible channels (ZNE, ZRT, Z12)
%   
% TRACE PROCESSING
%   align
%   demean
%   detrend
%   fix_trace_length
%   
% This function is mostly likely to be called from from within other
% threecomp functions.
%



if numel(TC)>1
    error('threecomp:verify:notScalarInput','threecomp/verify operates only single threecomp objects.');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSISTENCY CHECKS
%%%%%%%%%%%%%%%%%%%%%%%%%%


% CHECK START TIMES
t = get(TC.traces,'START_MATLAB');
if ( t(2)~=t(1) ) | ( t(3)~=t(1) )
    warning('traces have different start times');
end;
    
% CHECK FREQUENCIES
freq = get(TC.traces,'FREQ');
if ( t(2)~=t(1) ) | ( t(3)~=t(1) )
    warning('traces have different frequencies');
end;
    

% CHECK FOR COMMON UNITS
units = get(TC.traces,'UNITS');
tf = strcmpi(units,units(1));
if length(find(tf)) ~= length(tf)
    warning('traces have different units');
end


% CHECK FOR COMMON STATION NAMES
units = get(TC.traces,'STATION');
tf = strcmpi(units,units(1));
if length(find(tf)) ~= length(tf)
    warning('traces have different units');
end


% CHECK ARRANGEMENT OF CHANNELS IN WAVEFORM OBJECT
channels = get(TC.traces,'CHANNEL');
if ~strcmpi(channels{1,1}(end),'Z')
   warning('First column is not Z component'); 
end
if ~strcmpi(channels{1,2}(end),'N') && ~strcmpi(channels{1,2}(end),'R') && ~strcmpi(channels{1,2}(end),'1') 
   warning('Second column is not N, R, or 2 component'); 
end
if ~strcmpi(channels{1,3}(end),'E') && ~strcmpi(channels{1,3}(end),'T') && ~strcmpi(channels{1,3}(end),'2')
   warning('Third column is not E, T, or 1 component'); 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRACE ADJUSTMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%


% ALIGN TRACES ON COMMON SAMPLE
TC.traces = align( TC.traces , get(TC.traces(1),'START_MATLAB') , get(TC.traces(1),'FREQ') );


% DEMEAN AND DETREND DATA
TC.traces = demean(TC.traces);
TC.traces = detrend(TC.traces);


% ADJUST TRACE LENGTHS TO BE THE SAME
lengths = get(TC.traces,'DATA_LENGTH');
ideal = median(lengths);
f = find(lengths~=ideal);
if ~isempty(f)
   warning('Traces have been padded to the same length');
   TC.traces = fix_data_length(TC.traces);
end

INSERT WAVEFORM SYNCHRONIZE HERE
