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
 
global settings;
countsUnassinged = sum(settings.currentDetections(:,settings.groupIdIndex) == 0);
countsGroup1 = sum(settings.currentDetections(:,settings.groupIdIndex) == 1);
countsGroup2 = sum(settings.currentDetections(:,settings.groupIdIndex) == 2);
countsGroup3 = sum(settings.currentDetections(:,settings.groupIdIndex) == 3);
countsGroup4 = sum(settings.currentDetections(:,settings.groupIdIndex) == 4);
resultFileName = strrep(settings.csvFile, '.csv', '_counts.csv');
dlmwrite(resultFileName, [countsUnassinged, countsGroup1, countsGroup2, countsGroup3, countsGroup4], ';');
prepend2file('Unassigned;Group 1; Group 2; Group 3; Group 4;', resultFileName, 1);

resultFileName = strrep(settings.csvFile, '.csv', '_grouped.csv');
dlmwrite(resultFileName, settings.currentDetections, ';');
prepend2file('id;scale;xpos;ypos;zpos;groupID;', resultFileName, 1);