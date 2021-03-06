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
 
%% the key event handler
function keyReleaseEventHandler(~,evt)
    global settings;

    settings.xLim = get(gca, 'XLim');
    settings.yLim = get(gca, 'YLim');

    %% switch between the images of the loaded series
    if (strcmp(evt.Key, 'rightarrow'))
        settings.currentSlice = min(size(settings.rawImage,3), settings.currentSlice+1);
        updateVisualization;
    elseif (strcmp(evt.Key, 'leftarrow'))
        settings.currentSlice = max(1, settings.currentSlice-1);
        updateVisualization;
        %% not implemented yet, maybe use for contrast or scrolling
    elseif (strcmp(evt.Character, '+') || strcmp(evt.Key, 'uparrow'))
        settings.gamma(1) = min(5, settings.gamma(1)+0.1);
        updateVisualization;
    elseif (strcmp(evt.Character, '-') || strcmp(evt.Key, 'downarrow'))
        settings.gamma(1) = max(0, settings.gamma(1) - 0.1);
        updateVisualization;
        
    %% add a new detection if in slice-mode
    elseif (strcmp(evt.Character, 'a'))

        if (settings.maximumProjectionMode == true)
            errordlg('Adding and deleting detections only works in slice mode!');
        else
            [x, y] = ginputc(1, 'Color', 'r', 'LineWidth', 1);
            settings.currentDetections(end+1,:) = [size(settings.currentDetections,1), 1, x, y, settings.currentSlice, settings.selectedGroup];
            updateVisualization;
        end
        
    %% toggle correct aspect ratio
    elseif (strcmp(evt.Character, 'v'))
        settings.axesEqual = ~settings.axesEqual;
        updateVisualization;
    
    %% export the results
    elseif (strcmp(evt.Character, 'e'))
        exportProject();
        
    %% select a region of interest and assign the current group to contained detections
    elseif (strcmp(evt.Character, 's'))
        
        %% open a freehand drawing tool
        h = imfreehand;
        currentMask = createMask(h);
        
        %% loop through all detections and check for mask intersection
        for i=1:size(settings.currentDetections,1)
            if (settings.maximumProjectionMode == true)
                currentPosition = round(settings.currentDetections(i,3:4));
                if (currentMask(currentPosition(2), currentPosition(1)) > 0)
                    settings.currentDetections(i, settings.groupIdIndex) = settings.selectedGroup;
                end
            else
                currentPosition = round(settings.currentDetections(i,3:5));
                if (currentMask(currentPosition(2), currentPosition(1)) > 0 && currentPosition(3) == settings.currentSlice)
                    settings.currentDetections(i, settings.groupIdIndex) = settings.selectedGroup;
                end
            end
        end
        updateVisualization;

    %% toggle maximum projection / slice mode
    elseif (strcmp(evt.Character, 'm'))
        settings.maximumProjectionMode = ~settings.maximumProjectionMode;
        updateVisualization;
        
	%% toggle the color map
    elseif (strcmp(evt.Character, 'c'))
        settings.colormapIndex = mod(settings.colormapIndex+1, 3)+1;
        updateVisualization;
        
    %% reset the current group selection
    elseif (strcmp(evt.Character, 'r'))
        answer = questdlg('Really reset current group selection (no undo available!)?');
        if (strcmp(answer, 'Yes'))
            settings.currentDetections(:,settings.groupIdIndex) = 0;
            updateVisualization;
        end
        
    %% reset the zoom
    elseif (strcmp(evt.Character, 'o'))
        settings.xLim = [1, size(settings.rawImage,1)];
        settings.yLim = [1, size(settings.rawImage,2)];
        updateVisualization;

    %% show the help dialog
    elseif (strcmp(evt.Character, 'h'))    
        showHelp;
        
	%% set group 1 for selection
    elseif (strcmp(evt.Character, '1'))
        settings.selectedGroup = 1;
        updateVisualization;
    
    %% set group 2 for selection
    elseif (strcmp(evt.Character, '2'))
        settings.selectedGroup = 2;
        updateVisualization;
    
	%% set group 3 for selection
    elseif (strcmp(evt.Character, '3'))
        settings.selectedGroup = 3;
        updateVisualization;

    %% set group 4 for selection
    elseif (strcmp(evt.Character, '4'))
        settings.selectedGroup = 4;
        updateVisualization;
    
	%% set group unassigned for selection
    elseif (strcmp(evt.Character, '5'))
        settings.selectedGroup = 0;
        updateVisualization;
    end
end