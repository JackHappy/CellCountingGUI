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

helpText = {'1,2,3,4,5: Toggles the selected group (group 1, 2, 3, 4, unassigned)', ...
            'Up Arrow: Increase selected threshold (highlighted in red)', ...
            'Down Arrow: Decrease selected threshold (highlighted in red)', ...
            'Left Arrow: Go to previous slice (only works in slice mode)', ...
            'Right Arrow: Go to next slice (only works in slice mode)', ...
            'A: Add a new detection at the cursor location (only works in slice-mode)', ...
            'B: Toggle background detections for intensity comparisons (auto-detection uses convex hull of colocalized dots and freehand tool allows arbitary masks)', ...
            'C: Toggle color map', ...
            'E: Export results (two csv files *_grouped.csv and *_counts.csv)', ...
            'H: Show this help dialog', ...
            'M: Switch between slice-mode and maximum projection mode', ...
            'O: Zoom out to the original view', ...
            'R: Reset group ids (cannot be undone!)', ...
            'S: Select region of interest and assign selected detections to the current group', ...
            'Mouse Wheel: Scroll through slices (only works in slice-mode)', ...
            'CTRL + Mouse Wheel: Zoom in/out in a Google-Maps like behavior', ...
            '', ...
            'Hint: In case key presses show no effect, left click once on the image and try hitting the button again. This only happens if the window looses the focus.'};

helpdlg(helpText);