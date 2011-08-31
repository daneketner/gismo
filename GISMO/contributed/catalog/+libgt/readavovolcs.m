function [sourcelon, sourcelat, minlon, maxlon, minlat, maxlat] = readavovolcs(volcano, pffile)
% READAVOVOLCS Read the avo_volcs.pf file.
%

libgt.print_debug(sprintf('> %s', mfilename),4)

if ~exist('pffile', 'var') 
	pffile=(['pf/avo_volcs.pf']);
	if ~exist('pffile', 'file') 
		pffile=(['/avort/oprun/pf/avo_volcs.pf']);
	end
end
if exist(pffile, 'file')
	volcano = libgt.camelcase2underscore(volcano);
	
	libgt.print_debug(sprintf('Trying to read %s for %s\n', pffile,volcano),2)
	A=importdata(pffile);
	
	for c=1:length(A.rowheaders)
		if strcmp(lower(A.rowheaders{c}), lower(volcano))
			sourcelon = A.data(c, 2);
			sourcelat = A.data(c, 1);
			minlon = A.data(c, 5);
			maxlon = A.data(c, 6);
			minlat = A.data(c, 3);
			maxlat = A.data(c, 4);
		end
	end
else
	error(sprintf('%s: %s does not exist',mfilename, pffile));
end

libgt.print_debug(sprintf('< %s', mfilename),4)


