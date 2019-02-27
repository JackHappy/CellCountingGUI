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