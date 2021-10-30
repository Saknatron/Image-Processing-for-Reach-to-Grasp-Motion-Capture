%% Image Processing for Reach-to-Grasp Motion Capture
% Project of *3C-KMITL* .
% _LIANGSORN Natsakorn_.
%% Height
Hset = 10;
MakeDataH = [];
for i = Hset:(Rnd-Hset+1)
    MakeDataH(i,1) = mean(DataH((i-Hset+1):(i+Hset-1),1));
end
MakeDataH(1:Hset,1) = 11.9;
MakeDataH(i:i+Hset-1,1) = MakeDataH(i,1);

figure,
g1 = subplot(2,1,1);
hold on
plot(g1,1:Rnd,DataH(:,1),'b-','Linewidth',1)
plot(g1,1:Rnd,MakeDataH,'r:','Linewidth',1.5)
title('Height real detected vs average #10')
xlabel('Frame')
ylabel('Height (cm)')
legend('Detected','Average')
grid on
hold off
g2 = subplot(2,1,2);
hold on
plot(g2,1:Rnd,MakeDataH,'k-','Linewidth',1)
title('Height optimized #10')
xlabel('Frame')
ylabel('Height (cm)')
grid on
hold off
%% Hand speed
DataV(1,:) = [1, 0];
for iV = 2:Rnd
    Bluepxdis = sqrt(sum((DataB(iV,:) - DataB(iV - 1,:)).^2));
    dH = MakeDataH(iV,1) - MakeDataH(iV - 1,1);
    Vall = sqrt((Bluepxdis*2/round(DataG(iV,2)))^2 + dH^2);
    BlueV = Vall*videoFileReader.FrameRate;
    DataV(iV,:) = [iV, BlueV];
end
figure,
hold on
plot(1:Rnd,DataV(:,2),'b-','Linewidth',1)
title('Hand speed')
xlabel('Frame')
ylabel('Speed (cm/s)')
grid on
hold off
%% Hand speed Electromagnetic vs Image processing
figure,
g1 = subplot(2,1,1);
hold on
plot(g1,1:numel(emagV),emagV,'b-','Linewidth',1)
title(TextVe)
xlabel('Frame')
ylabel('Speed')
grid on
hold off
g2 = subplot(2,1,2);
hold on
plot(g2,1:Rnd,DataV(:,2),'m-','Linewidth',1)
title(TextVi)
xlabel('Frame')
ylabel('Speed (cm/s)')
grid on
hold off
%% Distance by Electromagnetic vs Image processing
figure,
g1 = subplot(2,1,1);
hold on
plot(g1,1:numel(emagD),emagD,'b-','Linewidth',1)
title(TextDe)
xlabel('Frame')
ylabel('Distance')
grid on
hold off
g2 = subplot(2,1,2);
hold on
plot(g2,1:Rnd,DataD(:,2),'m-','Linewidth',1)
title(TextDi)
xlabel('Frame')
ylabel('Distance (cm)')
grid on
hold off
%% Height by Electromagnetic vs Image processing
figure,
g1 = subplot(2,1,1);
hold on
plot(g1,1:numel(emagH),emagH,'b-','Linewidth',1)
title(TextHe)
xlabel('Frame')
ylabel('Height')
grid on
hold off
g2 = subplot(2,1,2);
hold on
plot(g2,1:Rnd,MakeDataH(:,1),'m-','Linewidth',1)
title(TextHi)
xlabel('Frame')
ylabel('Height (cm)')
grid on
hold off
