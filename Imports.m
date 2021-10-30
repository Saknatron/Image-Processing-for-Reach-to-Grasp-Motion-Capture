%% Imports
%% #01
%% #02
%% #03
%% #04
%% #05
typeF = 05; emagN = emag05; load('Detected05.mat')
DataB = Detected05(:,1:2);
DataD = Detected05(:,3:4);
DataG = Detected05(:,5:6);
DataH = Detected05(:,7:8);
DataR = Detected05(:,9:10);
DataV = Detected05(:,11:12);
DataY = Detected05(:,13:14);
MakeDataH = Detected05(:,15);
%% #06
typeF = 06; emagN = emag06; load('Detected06.mat')
DataB = Detected06(:,1:2);
DataD = Detected06(:,3:4);
DataG = Detected06(:,5:6);
DataH = Detected06(:,7:8);
DataR = Detected06(:,9:10);
DataV = Detected06(:,11:12);
DataY = Detected06(:,13:14);
MakeDataH = Detected06(:,15);
%% #07
typeF = 07; emagN = emag07; load('Detected07.mat')
DataB = Detected07(:,1:2);
DataD = Detected07(:,3:4);
DataG = Detected07(:,5:6);
DataH = Detected07(:,7:8);
DataR = Detected07(:,9:10);
DataV = Detected07(:,11:12);
DataY = Detected07(:,13:14);
MakeDataH = Detected07(:,15);
%% #08
typeF = 08; emagN = emag08; load('Detected08.mat')
DataB = Detected08(:,1:2);
DataD = Detected08(:,3:4);
DataG = Detected08(:,5:6);
DataH = Detected08(:,7:8);
DataR = Detected08(:,9:10);
DataV = Detected08(:,11:12);
DataY = Detected08(:,13:14);
MakeDataH = Detected08(:,15);
%% #09
typeF = 09; emagN = emag09; load('Detected09.mat')
DataB = Detected09(:,1:2);
DataD = Detected09(:,3:4);
DataG = Detected09(:,5:6);
DataH = Detected09(:,7:8);
DataR = Detected09(:,9:10);
DataV = Detected09(:,11:12);
DataY = Detected09(:,13:14);
MakeDataH = Detected09(:,15);
%% #10
typeF = 10; emagN = emag10; load('Detected10.mat')
DataB = Detected10(:,1:2);
DataD = Detected10(:,3:4);
DataG = Detected10(:,5:6);
DataH = Detected10(:,7:8);
DataR = Detected10(:,9:10);
DataV = Detected10(:,11:12);
DataY = Detected10(:,13:14);
MakeDataH = Detected10(:,15);
%%
emagV = emagN(:,1);
emagD = emagN(:,2);
emagH = emagN(:,3);
TextVe = "Hand speed by Electromagnetic #" + typeF;
TextVi = "Hand speed by Image processing #" + typeF;
TextDe = "Distance two Fingers by Electromagnetic #" + typeF;
TextDi = "Distance two Fingers by Image processing #" + typeF;
TextHe = "Height by Electromagnetic #" + typeF;
TextHi = "Height by Image processing #" + typeF;