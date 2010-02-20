% LOAD TEST DATA


function cookbook

whichgismo('WestPCBranch');


clear classes

load threecomp_demo_traces
w1 = [w31300127];
w = [
   w31300127
   w31300800
   w31301753
   w31300192
];
TC = threecomp(w);




w = get(TC,'WAVEFORM')
backAzimuth = get(TC,'BACKAZIMUTH')
type = get(TC,'TYPE')




% TEST INAPPROPRIATE WAVEFORMS
wBad(1) = set(w1(1),'STATION','XXA');
wBad(2) = set(w1(2),'STATION','XXB');
wBad(3) = set(w1(3),'STATION','XXC');
verify(threecomp(wBad))

wBad(1) = set(w1(1),'CHANNEL','BHX');
wBad(2) = set(w1(2),'CHANNEL','BHY');
wBad(3) = set(w1(3),'CHANNEL','BHZ');
verify(threecomp(wBad))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST SYNCHRONIZE
load threecomp_demo_traces
w = [w31300127];
w(2) = set(w(2),'START',datenum('2006-01-05 03:58:25.63'));
get(w,'START_STR')
get(w,'DATA_LENGTH')
synchronize(w)
