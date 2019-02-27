function prepend2file( string, filename, newline )
% function prepend2file( string, filename, newline )
%
%  newline: is an optional boolean, that if true will append a \n to the end
%  of the string that is sent in such that the original text starts on the
%  next line rather than the end of the line that the string is on
%  string: a single line string
%  filename: the file you want to prepend to
%
% The function prepend2file is part of the MATLAB toolbox SciXMiner. 
% Copyright (C) 2017  [KIT, IAI]


% Last file change: 12-Mrz-2018 10:36:55
% 
% This program is free software; you can redistribute it and/or modify,
% it under the terms of the GNU General Public License as published by 
% the Free Software Foundation; either version 2 of the License, or any later version.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License along with this program;
% if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA.
% 
% You will find further information about SciXMiner in the manual:
% 
% Mikut, R.; Bartschat, A.; Doneit, W.; Ordiano, J. Á. G.; Schott, B.; Stegmaier, J.; Waczowicz, S. & Reischl, M.:
% The MATLAB Toolbox SciXMiner: User's Manual and Programmer's Guide. arXiv:1704.03298, 2017
% 
% or in the following paper:
% 
% R. Mikut, J. Stegmaier, A. Bartschat, W. Doneit, A. González Ordiano, N. Peter, B. Schott, S. Waczowicz, M. Reischl: 
% SciXMiner: A MATLAB Toolbox for Data Mining of Multidimensional Data.  
% Submitted paper, Preprint will be available at www.arxiv.org; 2017 
% 
% SciXMner is online available at: https://sourceforge.net/projects/scixminer
% 
% Please refer to the manual or to this paper, if you use SciXMiner for your scientific work.

tempFile = tempname;
fw = fopen( tempFile, 'wb' );
if nargin < 3
newline = false;
end
if newline
fwrite( fw, sprintf('%s\n', string ) );
else
fwrite( fw, string );
end

fclose( fw );
appendFiles( filename, tempFile );
copyfile( tempFile, filename );
delete(tempFile);

% append readFile to writtenFile
function status = appendFiles( readFile, writtenFile )
fr = fopen( readFile, 'rb' );
fw = fopen( writtenFile, 'ab' );

while feof( fr ) == 0
tline = fgetl( fr );
fwrite( fw, sprintf('%s\n',tline ) );
end
fclose(fr);
fclose(fw);