function mag=eng2mag(eng);
% mag=eng2mag(eng)
% eng2mag converts an energy to a magnitude using the conversion:
%   mag = log10(eng)/1.5 - 3.7
% All that matters is that energy is roughly proportional to the peak
% amplitude to the power of 1.5.
% The correction factor of 3.7 worked well for events at Montserrat.
% It cancels out if computing cumulative magnitude from a set of
% magnitudes.
%
% Glenn Thompson, MVO, 2001
%
% 2009/08/06
% while 3.7 may be an appropriate factor for montserrat, based on the output
% of the energy algorithm I used, a quite different form value is suggested
% by Hanks and Kanamori 1979, as referenced in my swarm alarm paper
% rather than
% 	mag=(log10(eng)/1.5)-3.7;
% it suggests (using Joules instead of ergs)

	mag = (log10(eng) - 4.7) / 1.5; 	

