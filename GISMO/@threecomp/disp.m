function disp(TC)

%DISP Display threecomp object
%   DISP(TC)

% Author: Michael West, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date$
% $Revision$


 
% TEST FOR NON-EMPTY TRACE DATA
minNumberOfSamples = min(get(TC(1).traces,'DATA_LENGTH'));

if numel(TC)>1
    [n,m] = size(TC); % char returns a cell array
    disp([num2str(n) ' x ' num2str(m) ' threecomp object'])

elseif numel(TC)==1 & ~minNumberOfSamples      % empty waveform(s)
    disp('     -- empty, or partially empty, threecomp object --');

elseif numel(TC)==1 & minNumberOfSamples

    net = get(TC.traces(1),'NETWORK');
    sta = get(TC.traces(1),'STATION');
    chan1 = get(TC.traces(1),'CHANNEL');
    chan2 = get(TC.traces(2),'CHANNEL');
    chan3 = get(TC.traces(3),'CHANNEL');
    chan = [chan1(1:end-1) '[' chan1(end) chan2(end) chan3(end) ']'];
    loc = get(TC.traces(1),'LOCATION');
    disp(['    net_sta_chan_loc:    ' net '_' sta '_' chan '_' loc]);
        
    disp(['    type:                ' char(get(TC,'TYPE')) ]);

    if isempty(TC.backAzimuth)
        disp(['    backAzimuth:         ' 'property not set' ]);
    else
        disp(['    backAzimuth:         ' TC.backAzimuth ]);
    end
    
    if isempty(TC.rectilinearity)
        disp(['    rectilinearity:      property not set' ]);
    else
        disp(['    rectilinearity:      property if filled' ]);
    end
    
    if isempty(TC.planarity)
        disp(['    planarity:           property not set' ]);
    else
        disp(['    planarity:           property if filled' ]);
    end
       
    if isempty(TC.energy)
        disp(['    energy:              property not set' ]);
    else
        disp(['    energy:              property if filled' ]);
    end 
    
    if isempty(TC.azimuth)
        disp(['    azimuth:             property not set' ]);
    else
        disp(['    azimuth:             property if filled' ]);
    end

    if isempty(TC.inclination)
        disp(['    inclination:         property not set' ]);
    else
        disp(['    inclination:         property if filled' ]);
    end
    
end