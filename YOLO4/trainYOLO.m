data = load("dataset.mat");
trainingDataTable = objectDetectorTrainingData(data.gTruth);

rng("default");
shuffledIndices = randperm(height(trainingDataTable));
idx = floor(0.85 * length(shuffledIndices) );

% Create train,valid,test splits
trainingIdx = 1:idx;
trainingDataTbl = trainingDataTable(shuffledIndices(trainingIdx),:);

validationIdx = idx+1:length(shuffledIndices);
validationDataTbl = trainingDataTable(shuffledIndices(validationIdx),:);

%testIdx = validationIdx(end)+1 : length(shuffledIndices);
%testDataTbl = trainingDataTable(shuffledIndices(testIdx),:);

% Use imageDatastore and boxLabelDatastore to create datastores for loading
% the image and label data during training and evaluation.
imdsTrain = imageDatastore(trainingDataTbl{:,"imageFilename"});
bldsTrain = boxLabelDatastore(trainingDataTbl(:,["bottle","can","pouch"]));

imdsValidation = imageDatastore(validationDataTbl{:,"imageFilename"});
bldsValidation = boxLabelDatastore(validationDataTbl(:,["bottle","can","pouch"]));

%imdsTest = imageDatastore(testDataTbl{:,"imageFilename"});
%bldsTest = boxLabelDatastore(testDataTbl(:,["bottle","can","pouch"]));

% Combine image and box label datastores.
trainingData = combine(imdsTrain,bldsTrain);
validationData = combine(imdsValidation,bldsValidation);
%testData = combine(imdsTest,bldsTest);

% Display one image
% data = read(trainingData);
% I = data{1};
% bbox = data{2};
% annotatedImage = insertShape(I,"Rectangle",bbox);
% annotatedImage = imresize(annotatedImage,2);
% figure
% imshow(annotatedImage)
% reset(trainingData);

inputSize = [960,1280,3];
classNames = {'bottle','can','pouch'};

% Estimate anchor boxes
rng("default")
% trainingDataForEstimation = transform(trainingData,@(data)preprocessData(data,inputSize));
numAnchors = 10;
% https://it.mathworks.com/help/vision/ref/estimateanchorboxes.html
[anchors,meanIoU] = estimateAnchorBoxes(trainingData,numAnchors);

area = anchors(:, 1).*anchors(:,2);
[~,idx] = sort(area,"descend");

anchors = anchors(idx,:);
anchorBoxes = {anchors(1:5,:)
    anchors(6:10,:)
    %anchors(7:9,:)
    };

% YOLO
detector = yolov4ObjectDetector("tiny-yolov4-coco",classNames,anchorBoxes,InputSize=inputSize);

% Training options
options = trainingOptions("adam",...
    GradientDecayFactor=0.9,...
    SquaredGradientDecayFactor=0.999,...
    InitialLearnRate=0.001,...
    LearnRateSchedule="none",...
    MiniBatchSize=16,...
    L2Regularization=0.0005,...
    MaxEpochs=100,...
    BatchNormalizationStatistics="moving",...
    DispatchInBackground=true,...
    ResetInputNormalization=false,...
    Shuffle="every-epoch",...
    VerboseFrequency=60,...
    ValidationFrequency=100,...
    CheckpointPath=tempdir,...
    ValidationData=validationData,...
    ExecutionEnvironment='auto');

%options = trainingOptions("adam",...
%    GradientDecayFactor=0.9,...
%    SquaredGradientDecayFactor=0.999,...
%    InitialLearnRate=0.001,...
%    LearnRateSchedule="none",...
%    MiniBatchSize=4,...
%    L2Regularization=0.0005,...
%    MaxEpochs=70,...
%    BatchNormalizationStatistics="moving",...
%    DispatchInBackground=false,...
%    ResetInputNormalization=false,...
%    Shuffle="every-epoch",...
%    VerboseFrequency=20,...
%    ValidationFrequency=1000,...
%    CheckpointPath=tempdir,...
%    ValidationData=validationData,...
%    ExecutionEnvironment='cpu');

doTraining = true;
if doTraining       
    % Train the YOLO v4 detector.
    [detector,info] = trainYOLOv4ObjectDetector(trainingData,detector,options);
    save("detector.mat","detector");
else
    % Load pretrained detector for the example.
    detector = load("detector.mat");
end
