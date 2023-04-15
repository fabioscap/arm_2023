%% change file names
data = load("dataset.mat");
gTruth = data.gTruth;
currentPath = "/home/coer/Documents/AIRO/Roboarm/templates-robocup-robot-manipulation-challenge-main/MATLAB_Simulink_Templates/2023/pictures/";
newPath = fileparts("/home/dennis/Desktop/arm_2023/YOLO4/RoboarmDataset/")
alternativePaths = {[currentPath newPath]};
unresolvedPaths = gTruth.changeFilePaths(alternativePaths)
save("dataset.mat","gTruth");
%% merge datasets
data1 = load("dataset1.mat");
data2 = load("dataset2.mat");
nDataSource=groundTruthDataSource([data.gTruth.DataSource.Source;data2.gTruth.DataSource.Source]);
nLabelDef=data.gTruth.LabelDefinitions;
nLabelData=[data.gTruth.LabelData;data2.gTruth.LabelData];
gTruth = groundTruth(nDataSource,nLabelDef,nLabelData);
save("dataset.mat","gTruth");
