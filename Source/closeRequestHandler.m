
function closeRequestHandler(src,callbackdata)
    % Construct a questdlg with three options
    choice = questdlg('Would you like to save the current selection and counts before closing?', ...
        'Save before exiting?', ...
        'Yes','No','Cancel','Cancel');
    % Handle response
    switch choice
        case 'Yes'
            exportProject;
            delete(gcf);
        case 'No'
            delete(gcf);
        case 'Cancel'
            return;
    end
    delete(gcf);
    close all;
end