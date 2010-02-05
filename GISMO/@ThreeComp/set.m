function TC = set(TC, prop_name, val)

% SET Set properties for ThreeComp object
% TC = SET(TC,PROPERTY,VALUE)
%

% Author: Michael West, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date$
% $Revision$



if nargin <= 1
    error('Not enough inputs');
end

if ~strcmpi(class(TC),'ThreeComp')
    error('First argument must be a ThreeComp object');
end


switch upper(prop_name)
    case {'WAVEFORM'}
        if numel(TC)>1
            error('WAVEFORM property must be set on individual ThreeComp elements');
        end
        if ~isa(val,'WAVEFORM') || numel(val)~=3
           error('input VALUE must be a 1x3 waveform'); 
        end
        %TODO: no checking is done to see if trace is suitable
        TC.traces = reshape(val,1,length(val));
            
    %case {'TYPE'}
    %    c.trig = reshape(val,length(val),1);
    
    
    
    case {'CORR'}
        c.C = val;
    case {'LAG'}
        c.L = val;
    case {'STAT'}
        c.stat = val;
    case {'LINK'}
        c.link = val;
    case {'CLUST'}
        c.clust = val;
    otherwise
        warning('can''t understand property name');
        help correlation/set
end;


