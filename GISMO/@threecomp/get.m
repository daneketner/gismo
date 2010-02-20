function val = get(TC,varargin)

%GET    Get threecomp object properties.
%   V = GET(TC,'PropertyName') returns the value of the specified
%   property for the threecomp object specified by TC. Allowable properties
%   include:
%   WAVEFORM          waveform object containing the three component traces
%   BACKAZIMUTH       backazimuth to source
%   RECTILINEARITY    rectilinearity stored in a waveform object
%   PLANARITY         stored in a waveform object
%   ENERGY            energy stored in a waveform object
%   AZIMUTH           azimuth stored in a waveform object
%   INCLINATION       inclination stored in a waveform object
% See also threecomp object

% Author: Michael West, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date$
% $Revision$


% Check inputs
if ~isa(TC,'threecomp')
    error('First argment must be a threecomp object');
end
if nargin~=2
    error('Incorrect number of arguments');
end
property = varargin{1};
if ~isa(property,'char')
    error('Second argument must be a character string');
end


[objSize1,objSize2] = size(TC);
numObj = numel(TC);

% Prepare property values
switch upper(property)
    
    case 'WAVEFORM'
        if numObj==1
            val = TC.traces;
        elseif objSize1>1 && objSize2==1
            for n = 1:numObj
                val(n,1:3) = TC.traces;
            end
        elseif objSize2>1
            for n1 = 1:objSize1
                for n2 = 1:objSize2
                    val(n1,n2,1:3) = TC.traces;
                end
            end
        else
            error('threecomp object is not 1x1, nx1, or nxm in size');
        end
        
    case 'BACKAZIMUTH'
        for n = 1:numObj
            if isempty(TC(n).backAzimuth)
                val(n) = NaN;
            else
                val(n) = TC(n).backAzimuth;
            end
        end
        val = reshape(val,objSize1,objSize2);
    case 'STATION'
        for n = 1:numObj
            w = TC(n).waveform;
            val(n) = {get(w(1),'STATION')};
        end
        val = reshape(val,objSize1,objSize2);
    case 'CHANNEL'
        for n = 1:numObj
            w = TC(n).waveform;
            val(n) = {get(w,'CHANNEL')};
        end
        val = reshape(val,objSize1,objSize2);  
    case 'TYPE'
        for n = 1:numObj
            val(n) = gettype(TC(n));
        end
        val = reshape(val,objSize1,objSize2);
        
    case 'RECTILINEARITY'
        for n = 1:numObj
            if isempty(TC(n).rectilinearity)
                val(n) = waveform;
            else
                val(n) = TC(n).rectilinearity;
            end
        end
        val = reshape(val,objSize1,objSize2);
    
    case 'PLANARITY'
        for n = 1:numObj
            if isempty(TC(n).planarity)
                val(n) = waveform;
            else
                val(n) = TC(n).planarity;
            end
        end
        val = reshape(val,objSize1,objSize2);
    
    case 'ENERGY'
        for n = 1:numObj
            if isempty(TC(n).energy)
                val(n) = waveform;
            else
                val(n) = TC(n).energy;
            end
        end
        val = reshape(val,objSize1,objSize2);
    
    case 'AZIMUTH'
        for n = 1:numObj
            if isempty(TC(n).azimuth)
                val(n) = waveform;
            else
                val(n) = TC(n).azimuth;
            end
        end
        val = reshape(val,objSize1,objSize2);
    
    case 'INCLINATION'
        for n = 1:numObj
            if isempty(TC(n).inclination)
                val(n) = waveform;
            else
                val(n) = TC(n).inclination;
            end
        end
        val = reshape(val,objSize1,objSize2);
    
    otherwise
        error('Property not recognized.');
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DETERMINE TYPE PROPERTY
% where TC and val are scalars
%
function val = gettype(TC)


chan = get(TC,'CHANNEL');
chan = chan{1};
for n = 1:3
   val(1) = {[ chan{1}(end) chan{2}(end) chan{3}(end) ]};
end
