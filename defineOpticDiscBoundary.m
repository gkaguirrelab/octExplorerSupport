
%% Tool to select coordinates on an SLO image and save those values

stillPicking=true;

while stillPicking
    
    % Select an OCT vol file using a UI file picker
    [file,path] = uigetfile('*.vol');
    
    if file==0
        break
    end
    
    % Load the vol file contents
    [header, BScanHeader, slo, BScans] = openVol([path file],'nodisp');
    
    % Set up a structure variable to hold the info and results
    border.meta.timestamp = char(datetime('now'));
    border.meta.timestamp = char(java.lang.System.getProperty('user.name'));
    border.meta.hostname = char(java.net.InetAddress.getLocalHost.getHostName);
    border.meta.filepath = [path file];
    border.meta.volHeader = header;
    
    % Open a figure and display the slo image
    figHandle = figure();
    imagesc(slo);
    hold on
    
    % Invite the user to click on the image. Store the coordinates
    coords = [];
    stillClicking=true;
    while stillClicking
        [x,y]=ginput(1);
        if isempty(x)
            stillClicking=false;
        else
            plot(x,y,'+r');
            coords(end+1,:)=[x,y];
        end
    end
    
    % Store the coordinates
    border.coords = coords;
    
    % Close the figure
    close(figHandle)
    
    % Save the file
    outFileName = fullfile(path,[extractBefore(file,'.vol') '_opticDiscBorder.mat']);
    save(outFileName,'border');
    
    % Echo the outFileName to screen
    fprintf([outFileName '\n']);
    
end