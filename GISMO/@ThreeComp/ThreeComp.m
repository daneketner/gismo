% Author: Michael West, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date$
% $Revision$


classdef ThreeComp
    properties
        traces
        type
        backAzimuth
        rectilinearity
        planarity
        energy
        azimuth
        inclination
    end
    
    
    methods
        function TC = ThreeComp(varargin)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% FUNCTIONS HAS A SINGLE (WAVEFORM) ARGUMENT
            if length(varargin)==1
                W = varargin{1};
                if ~isa(W,'WAVEFORM') || size(W,2)~=3
                    error('input VALUE must be an nx3 waveform object');
                end
                
                % MULTIPLE WAVEFORM TUPLES
                if size(W,1)>1
                    for n=1:size(W,1)
                        TC(n) = ThreeComp(W(n,:));
                    end
                end
                
                % SINGLE WAVEFORM TUPLE
                if numel(W)==3
                    TC.traces = reshape(W,1,3);
                end
                
            elseif nargin==0
                TC.traces  = [waveform waveform waveform];
                
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% FUNCTIONS HAS A SINGLE (WAVEFORM) ARGUMENT
            if length(varargin)==2
                W = varargin{1};
                if ~isa(W,'WAVEFORM') || size(W,2)~=3
                    
                    
                end
                
            end
            
        end
        
    end
end


