function eng=mag2eng(mag);
% eng=mag2eng(mag)
% mag2eng converts a magnitude into energy using the conversion:
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
%	eng=power(10,(mag+3.7)*1.5);
% it suggests, using Joules instead of ergs

% for events without a magnitude, change it to -0.5 for energy calculation purposes

	mag(find(isnan(mag))) = -0.5;
	eng = power(10, (1.5 * mag + 4.7));


