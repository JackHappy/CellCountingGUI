%%
 % CellCountingGUI.
 % Copyright (C) 2019 D. Eschweiler, M. Gliksberg, J. Stegmaier
 %
 % Licensed under the Apache License, Version 2.0 (the "License");
 % you may not use this file except in compliance with the License.
 % You may obtain a copy of the Liceense at
 % 
 %     http://www.apache.org/licenses/LICENSE-2.0
 % 
 % Unless required by applicable law or agreed to in writing, software
 % distributed under the License is distributed on an "AS IS" BASIS,
 % WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 % See the License for the specific language governing permissions and
 % limitations under the License.
 %
 % Please refer to the documentation for more information about the software
 % as well as for installation instructions.
 %
 % If you use this application for your work, please cite the repository and one
 % of the following publications:
 %
 % TBA
 %
 %%

%% initialize the global settings variable
close all;
if (exist('settings', 'var'))
    clearvars -except settings;
else
    clearvars;
end
global settings;

%% add path to the tiff handling scripts
addpath('ThirdParty/');
addpath('ThirdParty/saveastiff_4.3/');
addpath('ThirdParty/bfmatlab/');

%% open the input image
[filenameCSV, pathnameCSV] = uigetfile('*.csv', 'Select the CSV file containing the detections.');
previousPath = pwd;
cd(pathnameCSV)
[filenameTIF, pathnameTIF] = uigetfile({'*.ti*', 'TIF-Files (*.tif)';'.tiff', 'OME-TIFF-Files (*.ome.tiff)'}, 'Select the CSV file containing the detections.');
settings.csvFile = [pathnameCSV filenameCSV];
settings.rawImageFile = [pathnameTIF filenameTIF];
settings.resultFileNameGrouped = strrep(settings.csvFile, '.csv', '_grouped.csv');
settings.resultFileNameCounts = strrep(settings.csvFile, '.csv', '_counts.csv');
cd(previousPath);

%% load the csv files
if (~exist(settings.resultFileNameGrouped, 'file') || (exist(settings.resultFileNameGrouped, 'file') && strcmp('No', questdlg('Load previous group assignments?'))))
    settings.currentDetections = dlmread(settings.csvFile, ';', 1, 0);
    settings.currentDetections(:,end+1) = 0;
else
    settings.currentDetections = dlmread(settings.resultFileNameGrouped, ';', 1, 0);
end
settings.groupIdIndex = size(settings.currentDetections, 2);

%% load the raw image with the appropriate loader
if (contains(settings.rawImageFile, '.ome.'))
    settings.rawImage = imread_structured(settings.rawImageFile);
else
    settings.rawImage = loadtiff(settings.rawImageFile);
end
settings.rawImage = double(settings.rawImage);
settings.rawImage = settings.rawImage / max(settings.rawImage(:));
settings.maxProjectionImage = max(settings.rawImage, [], 3);

%% initialize the settings
settings.maximumProjectionMode = true;
settings.currentSlice = 1;
settings.colormapIndex = 1;
settings.selectedGroup = 1;
settings.markerSize = 15;
settings.gamma = 1;
settings.minIntensity = min(settings.rawImage(:));
settings.maxIntensity = max(settings.rawImage(:));
settings.axesEqual = false;
settings.fontSize = 14;
settings.thresholdMode = 1;
settings.colormapStrings = {'gray', 'parula', 'jet'};
settings.groupColors = lines(5);

%% specify the figure boundaries
settings.xLim = [0, size(settings.rawImage,1)];
settings.yLim = [0, size(settings.rawImage,2)];


%% open the main figure
settings.mainFigure = figure(1);

%% mouse, keyboard events and window title
set(settings.mainFigure, 'WindowScrollWheelFcn', @scrollEventHandler);
set(settings.mainFigure, 'KeyReleaseFcn', @keyReleaseEventHandler);
% set(settings.mainFigure, 'WindowButtonDownFcn', @mouseUp);
% set(settings.mainFigure, 'WindowButtonMotionFcn', @mouseMove);
set(settings.mainFigure, 'CloseRequestFcn', @closeRequestHandler);

%% update the visualization
updateVisualization;