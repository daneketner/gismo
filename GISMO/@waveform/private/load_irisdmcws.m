function wavef = load_irisdmcws(dataRequest, combine_waves)

% LOAD_IRISDMCWS loads waveforms using the IRIS Web Services Java Library
% For more information about the IRIS Web Services Library for Java,
% check out
%
% http://www.iris.edu/manuals/javawslibrary/
%
% See also javaaddpath waveform

% Rich Karstens & Celso Reyes
% IRIS DMC, December 2011
% Modified by Dane Ketner 10/15/2015 to work with new 'irisFetch.m'

wavef = waveform;
allSCNLs = dataRequest.scnls;
disp('Requesting Data from the DMC...');

for n=1:numel(allSCNLs)
    scnl = allSCNLs(n);
    traces=irisFetch.Traces(get(scnl,'network'), get(scnl,'station'), ...
        get(scnl,'location'), get(scnl,'channel'), ...
        datestr(dataRequest.startTimes,'yyyy-mm-dd HH:MM:SS.FFF'), ...
        datestr(dataRequest.endTimes,'yyyy-mm-dd HH:MM:SS.FFF'));
    wavef(n) = convertTraces(traces, combine_waves);
end

wavef = addhistory(clearhistory(wavef),'Imported from IRIS');
end

function ws = convertTraces(traces, combine_waves)
for i = 1:length(traces)
    w = waveform;
    myscnl = scnlobject(traces(i).station, traces(i).channel, ...
                        traces(i).network, traces(i).location);
    w = set(w,'scnlobject',myscnl,'freq',traces(i).sampleRate);
    w = set(w,'start', traces(i).startTime);
    w = addfield(w,'latitude',traces(i).latitude);
    w = addfield(w,'longitude', traces(i).longitude);
    w = addfield(w,'elevation',traces(i).elevation);
    w = addfield(w,'depth',traces(i).depth);
    w = addfield(w,'azimuth',traces(i).azimuth);
    w = addfield(w,'dip',traces(i).dip);
    w = addfield(w,'sensitivity',traces(i).sensitivity);
    w = addfield(w,'sensitivityFrequency',traces(i).sensitivityFrequency);
    w = addfield(w,'instrument',traces(i).instrument);
    w = set(w,'units',traces(i).sensitivityUnits);
    w = addfield(w,'calib',1 ./ traces(i).sensitivity);
    w = addfield(w,'calib_applied','NO');
    w = set(w,'data', traces(i).data);
    ws(i) = w;
end
if combine_waves
    ws = combine(w);
end
end

