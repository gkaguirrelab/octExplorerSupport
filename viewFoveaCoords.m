[file,path] = uigetfile();

load([path file]);

layers = zeros(size(mask));
layers(mask==2)=1;
layers(mask==3)=1;

layer=sum(layers,3);

xSize = size(layer,1);
ySize = size(layer,2);

% Find the X and Y coords of points with layer thickness <= foveaThickThresh
foveaThickThresh = 5;
idx = find(layer <= foveaThickThresh);
[X,Y] = ind2sub(size(layer),idx);

% Take the mean of those coordinates that are within the central 3rd of the
% image
xInBounds = logical((X>(xSize*0.33)).*(X<(xSize*0.67)));
yInBounds = logical((Y>(ySize*0.33)).*(Y<(ySize*0.67)));

foveaCoord = [mean(X(xInBounds)),mean(Y(yInBounds))];

% Create an image of the RGC+IPL layer thickness
figure
imagesc(layer)
axis square
hold on
plot(foveaCoord(2),foveaCoord(1),'+r');
