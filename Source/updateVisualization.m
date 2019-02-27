%%
 % SpotDetectionAndColocalizationGUI.
 % Copyright (C) 2017 J. Stegmaier, M. Schwarzkopf, H. Choi, A. Cunha
 %
 % Licensed under the Apache License, Version 2.0 (the "License");
 % you may not use this file except in compliance with the License.
 % You may obtain a copy of the License at
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
 % Bartschat, A.; Hübner, E.; Reischl, M.; Mikut, R. & Stegmaier, J. 
 % XPIWIT - An XML Pipeline Wrapper for the Insight Toolkit, 
 % Bioinformatics, 2016, 32, 315-317.
 %
 % Stegmaier, J.; Otte, J. C.; Kobitski, A.; Bartschat, A.; Garcia, A.; Nienhaus, G. U.; Strähle, U. & Mikut, R. 
 % Fast Segmentation of Stained Nuclei in Terabyte-Scale, Time Resolved 3D Microscopy Image Stacks, 
 % PLoS ONE, 2014, 9, e90036
 %
 %%

%% get the global settings
global settings;

%% ensure current slice is valid
settings.currentSlice = min(max(1, settings.currentSlice), size(settings.rawImage,3));

%% filter the detections
%% ...
settings.colormap = settings.colormapStrings{settings.colormapIndex};
figure(settings.mainFigure);
clf;
set(settings.mainFigure, 'Color', 'black');
set(gca, 'Units', 'normalized', 'Position', [0,0,1,1]);
% colordef black;
% set(gcf, 'Color', 'black');
% set(gca, 'Color', 'black');

if (settings.maximumProjectionMode == true)
    set(settings.mainFigure, 'Name', ['Maximum Projection']);
    
    %% plot the background images
    imagesc(imadjust(settings.maxProjectionImage, [settings.minIntensity, settings.maxIntensity], [], settings.gamma)); colormap(settings.colormap); hold on;

    %% plot group association of the detections
    for i=0:4
        validIndices = find(settings.currentDetections(:,settings.groupIdIndex) == i);
    
        %% plot detections of the red channel
        %plot(settings.currentDetections(validIndices,3), settings.currentDetections(validIndices,4), 'or', 'Color', settings.groupColors(i+1, :), 'MarkerSize', settings.markerSize);
        plot(settings.currentDetections(validIndices,3), settings.currentDetections(validIndices,4), '.r', 'Color', settings.groupColors(i+1, :), 'MarkerSize', settings.markerSize);
    end
    
    hold off;
else
    set(settings.mainFigure, 'Name', ['Current Slice: ' num2str(settings.currentSlice) '/' num2str(size(settings.rawImage,3))]);

    %% plot the background images
    imagesc(imadjust(settings.rawImage(:,:,settings.currentSlice), [settings.minIntensity, settings.maxIntensity], [], settings.gamma)); colormap(settings.colormap); hold on;
    
    %% plot detections of the red channel
    validDetectionsNear = find(settings.currentDetections(:,5) <= settings.currentSlice+2 & settings.currentDetections(:,5) >= settings.currentSlice-2);
    validDetectionsCurrentSlice = find(settings.currentDetections(:,5) == settings.currentSlice);

    %% plot group association of the detections
    for i=0:4
        validDetectionsNear = find(settings.currentDetections(:,settings.groupIdIndex) == i & settings.currentDetections(:,5) <= settings.currentSlice+2 & settings.currentDetections(:,5) >= settings.currentSlice-2);
        validIndices = find(settings.currentDetections(:,settings.groupIdIndex) == i & settings.currentDetections(:,5) == settings.currentSlice);
        
        %% plot detections of the red channel
        plot(settings.currentDetections(validDetectionsNear,3), settings.currentDetections(validDetectionsNear,4), '.r', 'Color', settings.groupColors(i+1, :), 'MarkerSize', settings.markerSize);
        plot(settings.currentDetections(validIndices,3), settings.currentDetections(validIndices,4), 'or', 'Color', settings.groupColors(i+1, :), 'MarkerSize', settings.markerSize);
    end
end

textColors = {'white', 'red'};
text('String', ['#Unassigned: ' num2str(sum(settings.currentDetections(:,settings.groupIdIndex) == 0))], 'FontSize', settings.fontSize + ((settings.selectedGroup == 0) * 5), 'Color', settings.groupColors(1, :), 'Units', 'normalized', 'Position', [0.01 0.98], 'Background', 'black');
text('String', ['#Group 1: ' num2str(sum(settings.currentDetections(:,settings.groupIdIndex) == 1))], 'FontSize', settings.fontSize + ((settings.selectedGroup == 1) * 5), 'Color', settings.groupColors(2, :), 'Units', 'normalized', 'Position', [0.01 0.94], 'Background', 'black');
text('String', ['#Group 2: ' num2str(sum(settings.currentDetections(:,settings.groupIdIndex) == 2))], 'FontSize', settings.fontSize + ((settings.selectedGroup == 2) * 5), 'Color', settings.groupColors(3, :), 'Units', 'normalized', 'Position', [0.01 0.90], 'Background', 'black');
text('String', ['#Group 3: ' num2str(sum(settings.currentDetections(:,settings.groupIdIndex) == 3))], 'FontSize', settings.fontSize + ((settings.selectedGroup == 3) * 5), 'Color', settings.groupColors(4, :), 'Units', 'normalized', 'Position', [0.01 0.86], 'Background', 'black');
text('String', ['#Group 4: ' num2str(sum(settings.currentDetections(:,settings.groupIdIndex) == 4))], 'FontSize', settings.fontSize + ((settings.selectedGroup == 4) * 5), 'Color', settings.groupColors(5, :), 'Units', 'normalized', 'Position', [0.01 0.82], 'Background', 'black');



if (settings.axesEqual == true)
    axis equal;
end
axis off;

set(gca, 'XLim', settings.xLim);
set(gca, 'YLim', settings.yLim);
