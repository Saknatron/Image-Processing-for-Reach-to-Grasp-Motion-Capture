v = VideoReader('RG1.MOV');
okcensetH = [0 0;0 0]; dsetH = [0;0]; rH = 0;
for i = 1:10
    switch i
        case 1
            v.CurrentTime = 74;
        case 2
            v.CurrentTime = 78;
        case 3
            v.CurrentTime = 80.7;
        case 4
            v.CurrentTime = 83;
        case 5
            v.CurrentTime = 86;
        case 6
            v.CurrentTime = 88.5;
        case 7
            v.CurrentTime = 90;
        case 8
            v.CurrentTime = 92.3;
        case 9
            v.CurrentTime = 96;
        case 10
            v.CurrentTime = 100;
    end
    rH = rH + 1;
    bwH = imfill(createMask(readFrame(v)), 'holes');
    psetH = struct2table(regionprops(bwH, {'Area','centroid'}));
    censetH = table2array(psetH(:,2));
    m=0;
    for j=1:numel(censetH(:,1))
        if(table2array(psetH(j,1))>100)
            m=m+1;
            okcensetH(m,:) = censetH(j,:);
        end
    end
    dsetH(i,1) = sqrt((okcensetH(1,1)-okcensetH(2,1)).^2 + (okcensetH(1,2)-okcensetH(2,2)).^2);
end
%% 
hasFramef = hasFrame(v);
v.CurrentTime = 74;
test1 = readFrame(v);
v.CurrentTime = 100;
test2 = readFrame(v);
imshowpair(test1,test2,'montage')
% pset00 = struct2table(regionprops(bw00, {'Area','centroid'}));
% pset05 = struct2table(regionprops(bw05, {'Area','centroid'}));
% pset10 = struct2table(regionprops(bw10, {'Area','centroid'}));
% pset15 = struct2table(regionprops(bw15, {'Area','centroid'}));
% pset20 = struct2table(regionprops(bw20, {'Area','centroid'}));
% pset25 = struct2table(regionprops(bw25, {'Area','centroid'}));
% pset30 = struct2table(regionprops(bw30, {'Area','centroid'}));
% pset35 = struct2table(regionprops(bw35, {'Area','centroid'}));
% pset40 = struct2table(regionprops(bw40, {'Area','centroid'}));
% pset45 = struct2table(regionprops(bw45, {'Area','centroid'}));
% censet00 = table2array(pset00(:,2));
% CurrentTime=0;
% for i=1:numel(censet00(:,1))
%     if(table2array(pset00(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset00(CurrentTime,:) = censet00(i,:);
%     end
% end
% censet05 = table2array(pset05(:,2));
% CurrentTime=0;
% for i=1:numel(censet05(:,1))
%     if(table2array(pset05(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset05(CurrentTime,:) = censet05(i,:);
%     end
% end
% censet10 = table2array(pset10(:,2));
% CurrentTime=0;
% for i=1:numel(censet10(:,1))
%     if(table2array(pset10(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset10(CurrentTime,:) = censet10(i,:);
%     end
% end
% censet15 = table2array(pset15(:,2));
% CurrentTime=0;
% for i=1:numel(censet15(:,1))
%     if(table2array(pset15(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset15(CurrentTime,:) = censet15(i,:);
%     end
% end
% censet20 = table2array(pset20(:,2));
% CurrentTime=0;
% for i=1:numel(censet20(:,1))
%     if(table2array(pset20(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset20(CurrentTime,:) = censet20(i,:);
%     end
% end
% censet25 = table2array(pset25(:,2));
% CurrentTime=0;
% for i=1:numel(censet25(:,1))
%     if(table2array(pset25(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset25(CurrentTime,:) = censet25(i,:);
%     end
% end
% censet30 = table2array(pset30(:,2));
% CurrentTime=0;
% for i=1:numel(censet30(:,1))
%     if(table2array(pset30(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset30(CurrentTime,:) = censet30(i,:);
%     end
% end
% censet35 = table2array(pset35(:,2));
% CurrentTime=0;
% for i=1:numel(censet35(:,1))
%     if(table2array(pset35(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset35(CurrentTime,:) = censet35(i,:);
%     end
% end
% censet40 = table2array(pset40(:,2));
% CurrentTime=0;
% for i=1:numel(censet40(:,1))
%     if(table2array(pset40(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset40(CurrentTime,:) = censet40(i,:);
%     end
% end
% censet45 = table2array(pset45(:,2));
% CurrentTime=0;
% for i=1:numel(censet45(:,1))
%     if(table2array(pset45(i,1))>300)
%         CurrentTime=CurrentTime+1;
%         okcenset45(CurrentTime,:) = censet45(i,:);
%     end
% end
% dset00 = sqrt((okcenset00(1,1)-okcenset00(2,1)).^2 + (okcenset00(1,2)-okcenset00(2,2)).^2);
% dset05 = sqrt((okcenset05(1,1)-okcenset05(2,1)).^2 + (okcenset05(1,2)-okcenset05(2,2)).^2);
% dset10 = sqrt((okcenset10(1,1)-okcenset10(2,1)).^2 + (okcenset10(1,2)-okcenset10(2,2)).^2);
% dset15 = sqrt((okcenset15(1,1)-okcenset15(2,1)).^2 + (okcenset15(1,2)-okcenset15(2,2)).^2);
% dset20 = sqrt((okcenset20(1,1)-okcenset20(2,1)).^2 + (okcenset20(1,2)-okcenset20(2,2)).^2);
% dset25 = sqrt((okcenset25(1,1)-okcenset25(2,1)).^2 + (okcenset25(1,2)-okcenset25(2,2)).^2);
% dset30 = sqrt((okcenset30(1,1)-okcenset30(2,1)).^2 + (okcenset30(1,2)-okcenset30(2,2)).^2);
% dset35 = sqrt((okcenset35(1,1)-okcenset35(2,1)).^2 + (okcenset35(1,2)-okcenset35(2,2)).^2);
% dset40 = sqrt((okcenset40(1,1)-okcenset40(2,1)).^2 + (okcenset40(1,2)-okcenset40(2,2)).^2);
% dset45 = sqrt((okcenset45(1,1)-okcenset45(2,1)).^2 + (okcenset45(1,2)-okcenset45(2,2)).^2);

function [BW,maskedRGBImage] = createMask(RGB)
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder app. The colorspace and
%  range for each channel of the colorspace were set within the app. The
%  segmentation mask is returned in BW, and a composite of the mask and
%  original RGB images is returned in maskedRGBImage.

% Auto-generated by colorThresholder app on 19-Oct-2021
%------------------------------------------------------


% Convert RGB image to chosen color space
I = RGB;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 255.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 255.000;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

% Create mask based on selected regions of interest on point cloud projection
I = double(I);
[m,n,~] = size(I);
polyBW = false([m,n]);
I = reshape(I,[m*n 3]);

% Project 3D data into 2D projected view from current camera view point within app
J = rotateColorSpace(I);

% Apply polygons drawn on point cloud in app
polyBW = applyPolygons(J,polyBW);

% Combine both masks
BW = sliderBW & polyBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end

function J = rotateColorSpace(I)

% Translate the data to the mean of the current image within app
shiftVec = [202.130005 202.546715 186.259792];
I = I - shiftVec;
I = [I ones(size(I,1),1)]';

% Apply transformation matrix
tMat = [0.001900 -0.001581 0.000000 -0.063789;
    0.000738 0.000883 0.002375 -0.770557;
    0.001402 0.001677 -0.001251 8.270160;
    0.000000 0.000000 0.000000 1.000000];

J = (tMat*I)';
end

function polyBW = applyPolygons(J,polyBW)

% Define each manually generated ROI
hPoints(1).data = [0.065862 -1.224026;
    0.135292 -1.205842;
    0.094201 -1.435418;
    0.023353 -1.446783];

% Iteratively apply each ROI
for ii = 1:length(hPoints)
    if size(hPoints(ii).data,1) > 2
        in = inpolygon(J(:,1),J(:,2),hPoints(ii).data(:,1),hPoints(ii).data(:,2));
        in = reshape(in,size(polyBW));
        polyBW = polyBW | in;
    end
end

end
