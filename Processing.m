videoFileReader = VideoReader('RG1.mov');
myVideo = VideoWriter('Test05');
depVideoPlayer = vision.DeployableVideoPlayer;
marker = vision.CascadeObjectDetector();
%initial-----------
Rnd=0;
pasttonow = [0 0; 0 0];
Greenpxdis = 0; Dis2 = 0; BlueV = 0; high = 0;
myVideo.FrameRate = 60;
DataH = [0,0];
DataR = [0,0];
DataY = [0,0];
DataB = [0,0];
DataD = [0,0];
DataV = [0,0];
DataG = [0,0];
%------------------
open(myVideo);
videoFileReader.CurrentTime = 225;
while videoFileReader.CurrentTime < 229
    Rnd=Rnd+1;
    videoFrame = readFrame(videoFileReader);
    Gbw = imfill(GcreateMask(videoFrame), 'holes');
    Ybw = imfill(YcreateMask(videoFrame), 'holes');
    Rbw = imfill(RcreateMask(videoFrame), 'holes');
    Bbw = imfill(BcreateMask(videoFrame), 'holes');
    Gproperties = regionprops(Gbw, {'Area','centroid'});
    Yproperties = regionprops(Ybw, {'Area','centroid'});
    Rproperties = regionprops(Rbw, {'Area','centroid'});
    Bproperties = regionprops(Bbw, {'Area','centroid'});
    Gtable = struct2table(Gproperties); Ytable = struct2table(Yproperties);
    Rtable = struct2table(Rproperties); Btable = struct2table(Bproperties);
    Gt = table2array(Gtable(:,2)); Yt = table2array(Ytable(:,2));
    Rt = table2array(Rtable(:,2)); Bt = table2array(Btable(:,2));
%-----GREEN-ZONE----------------------------------------------------------
    if(~(size(Gt)==0))
        xAG = table2array(Gtable(:,1));
        yAG = xAG<1500;
        zAG = xAG.*yAG;
        [AGv1,AGp1] = max(zAG);
        zAG(AGp1) = 0;
        [AGv2,AGp2] = max(zAG);
        posi = [Gt(AGp1,1) Gt(AGp1,2) sqrt(AGv1./pi)];
        videoFrame = insertShape(videoFrame,'circle',posi,...
                    'LineWidth',5,'Color','green');
        posi = [Gt(AGp2,1) Gt(AGp2,2) sqrt(AGv1./pi)];
        videoFrame = insertShape(videoFrame,'circle',posi,...
                    'LineWidth',5,'Color','green');
        if(~size(AGv2)==0)
            Greenpxdis = sqrt((Gt(AGp1,1) - Gt(AGp2,1))^2 + (Gt(AGp1,2) - Gt(AGp2,2))^2);
        else
            Greenpxdis = 0;
        end
        DataG(Rnd,:) = [Rnd, Greenpxdis];
        for i=1:9
            switch i
                case 1
                    n = dsetH(1,1);
                    m = dsetH(2,1);
                case 2
                    n = dsetH(2,1);
                    m = dsetH(3,1);
                case 3
                    n = dsetH(3,1);
                    m = dsetH(4,1);
                case 4
                    n = dsetH(4,1);
                    m = dsetH(5,1);
                case 5
                    n = dsetH(5,1);
                    m = dsetH(6,1);
                case 6
                    n = dsetH(6,1);
                    m = dsetH(7,1);
                case 7
                    n = dsetH(7,1);
                    m = dsetH(8,1);
                case 8
                    n = dsetH(8,1);
                    m = dsetH(9,1);
                case 9
                    n = dsetH(9,1);
                    m = dsetH(10,1);

                otherwise
                    n = 1000;
                    m = 1500;
            end
            if(Greenpxdis>n && Greenpxdis<m)
                percentage = (Greenpxdis-n)/(m-n);
                high = i*5-5 + percentage*5;
                DataH(Rnd,:) = [high,n];
            else
            end
        end
%         if(Rnd>1)
%             dH = round(DataH(Rnd,1) - DataH(Rnd-1,1),0);
%         else
%             dH = 0;
%         end
    end
%------------------------------------------------------------------------
%-----RED-YELLOW-ZONE----------------------------------------------------
    if(~((size(Yt)==0)))
        if(~((size(Rt)==0)))
            xAR = table2array(Rtable(:,1));
            xAY = table2array(Ytable(:,1));
            yAR = xAR<1500; yAY = xAY<1500;
            zAR = xAR.*yAR; zAY = xAY.*yAY;
            [ARv,ARp] = max(zAR); [AYv,AYp] = max(zAY);
            posi = [Rt(ARp,1) Rt(ARp,2) sqrt(AGv1./pi)];
            videoFrame = insertShape(videoFrame,'circle',posi,...
                        'LineWidth',5,'Color','red'); 
            posi = [Yt(AYp,1) Yt(AYp,2) sqrt(AGv1./pi)];
            videoFrame = insertShape(videoFrame,'circle',posi,...
                        'LineWidth',5,'Color','yellow');
            DataR(Rnd,:) = [Rt(ARp,1) Rt(ARp,2)];
            DataY(Rnd,:) = [Yt(AYp,1) Yt(AYp,2)]; 
            for iRY = 1:Rnd
                videoFrame = insertShape(videoFrame,'circle',[DataR(iRY,:),3],...
                    'LineWidth',5,'Color','red');
                videoFrame = insertShape(videoFrame,'circle',[DataY(iRY,:),3],...
                    'LineWidth',5,'Color','yellow');
            end
            Dis2 = 2*sqrt(sum((DataR(Rnd,:) - DataY(Rnd,:)).^2))/(Greenpxdis+1);
            DataD(Rnd,:) = [Rnd/videoFileReader.FrameRate Dis2];
        end
    end
%-------------------------------------------------------------------------
%-----BLUE-ZONE-----------------------------------------------------------
    if(~((size(Bt)==0)))
        xAB = table2array(Btable(:,1));
        yAB = xAB<1500;
        zAB = xAB.*yAB;
        [ABv,ABp] = max(zAB); 
        posi = [Bt(ABp,1) Bt(ABp,2) sqrt(AGv1./pi)];
        videoFrame = insertShape(videoFrame,'circle',posi,...
                    'LineWidth',5,'Color','blue'); 
        DataB(Rnd,:) = [Bt(ABp,1) Bt(ABp,2)];
        for iB = 1:Rnd
            videoFrame = insertShape(videoFrame,'circle',[DataB(iB,:),3],...
                'LineWidth',5,'Color','blue');
        end
%         pasttonow(1, :) = [round(DataB(end,1)),round(DataB(end,2))];
    end
%     if(pasttonow(2, 1)==0)
%         pasttonow(2,:) = pasttonow(1,:);
%     end
%     Bluepxdis = sqrt(sum((pasttonow(1,:) - pasttonow(2,:)).^2));
%     Vall = sqrt((Bluepxdis*2/round(Greenpxdis))^2 + dH^2);
%     BlueV = Vall*videoFileReader.FrameRate;
%     pasttonow(2,:) = pasttonow(1,:);
%     DataV(Rnd,:) = [Rnd/videoFileReader.FrameRate BlueV];
%-------------------------------------------------------------------------
    text2 = "Round #05";
    text3 = "Frame : " + Rnd;
    videoFrame = insertText(videoFrame,[0 0],text2,'FontSize',30,...
        'BoxColor','blue','TextColor','white');
    videoFrame = insertText(videoFrame,[0 55],text3,'FontSize',30,...
        'BoxColor','magenta','TextColor','white');
    
    depVideoPlayer(videoFrame);
    writeVideo(myVideo, videoFrame);
end
close(myVideo);
%51f = 1.36.71 min
%1f = 1.9 s

function [BW,maskedRGBImage] = RcreateMask(RGB)
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder app. The colorspace and
%  range for each channel of the colorspace were set within the app. The
%  segmentation mask is returned in BW, and a composite of the mask and
%  original RGB images is returned in maskedRGBImage.

% Auto-generated by colorThresholder app on 22-Oct-2021
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
J = RrotateColorSpace(I);

% Apply polygons drawn on point cloud in app
polyBW = RapplyPolygons(J,polyBW);

% Combine both masks
BW = sliderBW & polyBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set backgRnd pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
function J = RrotateColorSpace(I)

% Translate the data to the mean of the current image within app
shiftVec = [207.293428 203.196057 192.059135];
I = I - shiftVec;
I = [I ones(size(I,1),1)]';

% Apply transformation matrix
tMat = [-0.000897 0.002284 0.000000 -0.278329;
    -0.002196 -0.000897 0.000508 0.540032;
    -0.000437 -0.000178 -0.002553 9.277424;
    0.000000 0.000000 0.000000 1.000000];

J = (tMat*I)';
end
function polyBW = RapplyPolygons(J,polyBW)

% Define each manually generated ROI
hPoints(1).data = [-0.541870 0.877204;
    -0.656965 0.870699;
    -0.616420 0.645195;
    -0.430699 0.656037];

% Iteratively apply each ROI
for ii = 1:length(hPoints)
    if size(hPoints(ii).data,1) > 2
        in = inpolygon(J(:,1),J(:,2),hPoints(ii).data(:,1),hPoints(ii).data(:,2));
        in = reshape(in,size(polyBW));
        polyBW = polyBW | in;
    end
end

end


function [BW,maskedRGBImage] = YcreateMask(RGB)
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
J = YrotateColorSpace(I);

% Apply polygons drawn on point cloud in app
polyBW = YapplyPolygons(J,polyBW);

% Combine both masks
BW = sliderBW & polyBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set backgRnd pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
function J = YrotateColorSpace(I)

% Translate the data to the mean of the current image within app
shiftVec = [195.528757 192.103509 174.096390];
I = I - shiftVec;
I = [I ones(size(I,1),1)]';

% Apply transformation matrix
tMat = [0.000887 -0.002441 -0.000000 0.295523;
    -0.001426 -0.000537 0.002309 -0.019875;
    0.001928 0.000726 0.001708 7.846453;
    0.000000 0.000000 0.000000 1.000000];

J = (tMat*I)';
end
function polyBW = YapplyPolygons(J,polyBW)

% Define each manually generated ROI
hPoints(1).data = [0.256100 -0.490520;
    0.319435 -0.189862;
    0.443518 -0.330940;
    0.328482 -0.497458];

% Iteratively apply each ROI
for ii = 1:length(hPoints)
    if size(hPoints(ii).data,1) > 2
        in = inpolygon(J(:,1),J(:,2),hPoints(ii).data(:,1),hPoints(ii).data(:,2));
        in = reshape(in,size(polyBW));
        polyBW = polyBW | in;
    end
end

end

function [BW,maskedRGBImage] = GcreateMask(RGB)
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder app. The colorspace and
%  range for each channel of the colorspace were set within the app. The
%  segmentation mask is returned in BW, and a composite of the mask and
%  original RGB images is returned in maskedRGBImage.

% Auto-generated by colorThresholder app on 22-Oct-2021
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
J = GrotateColorSpace(I);

% Apply polygons drawn on point cloud in app
polyBW = GapplyPolygons(J,polyBW);

% Combine both masks
BW = sliderBW & polyBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set backgRnd pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end

function J = GrotateColorSpace(I)

% Translate the data to the mean of the current image within app
shiftVec = [201.869296 203.714108 193.599791];
I = I - shiftVec;
I = [I ones(size(I,1),1)]';

% Apply transformation matrix
tMat = [-0.002473 -0.000129 0.000000 0.525580;
    0.000130 -0.002451 0.000000 0.473039;
    0.000000 0.000000 -0.002583 9.160254;
    0.000000 0.000000 0.000000 1.000000];

J = (tMat*I)';
end

function polyBW = GapplyPolygons(J,polyBW)

% Define each manually generated ROI
hPoints(1).data = [0.915270 0.697070;
    0.913155 0.452109;
    0.541971 0.414900;
    0.829612 0.718775];

% Iteratively apply each ROI
for ii = 1:length(hPoints)
    if size(hPoints(ii).data,1) > 2
        in = inpolygon(J(:,1),J(:,2),hPoints(ii).data(:,1),hPoints(ii).data(:,2));
        in = reshape(in,size(polyBW));
        polyBW = polyBW | in;
    end
end

end


function [BW,maskedRGBImage] = BcreateMask(RGB)
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder app. The colorspace and
%  range for each channel of the colorspace were set within the app. The
%  segmentation mask is returned in BW, and a composite of the mask and
%  original RGB images is returned in maskedRGBImage.

% Auto-generated by colorThresholder app on 22-Oct-2021
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
J = BrotateColorSpace(I);

% Apply polygons drawn on point cloud in app
polyBW = BapplyPolygons(J,polyBW);

% Combine both masks
BW = sliderBW & polyBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set backgRnd pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end

function J = BrotateColorSpace(I)

% Translate the data to the mean of the current image within app
shiftVec = [197.594466 196.312478 187.385635];
I = I - shiftVec;
I = [I ones(size(I,1),1)]';

% Apply transformation matrix
tMat = [-0.000624 0.002468 0.000000 -0.361238;
    -0.001772 -0.000454 0.001845 0.093441;
    -0.001696 -0.000434 -0.001928 9.441775;
    0.000000 0.000000 0.000000 1.000000];

J = (tMat*I)';
end

function polyBW = BapplyPolygons(J,polyBW)

% Define each manually generated ROI
hPoints(1).data = [-0.668843 0.326123;
    -0.577112 0.421048;
    -0.524520 0.330753;
    -0.533081 0.284448;
    -0.640712 0.217306];

% Iteratively apply each ROI
for ii = 1:length(hPoints)
    if size(hPoints(ii).data,1) > 2
        in = inpolygon(J(:,1),J(:,2),hPoints(ii).data(:,1),hPoints(ii).data(:,2));
        in = reshape(in,size(polyBW));
        polyBW = polyBW | in;
    end
end

end

