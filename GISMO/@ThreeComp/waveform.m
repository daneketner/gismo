function w = waveform(TC)

%WAVEFORM Get waveforms from a ThreeComp object
%   W = WAVEFORM(TC) Extracts waveforms from a ThreeComp object where W is
%   a waveform object and TC is a ThreeComp object.

% Author: Michael West, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date$
% $Revision$


w = TC.traces;