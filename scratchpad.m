% Initial environment preparation. %
fileData = csvread('summarydata.txt')(:, 1:6);
resolvedUnshuffledData = fileData(fileData(:, 6) != 0, :);
allData = resolvedUnshuffledData(randperm(size(resolvedUnshuffledData,1)),:);
trainingData = allData(1:floor(size(allData, 1)*0.6), :);
cvData = allData(floor(size(allData, 1)*0.6)+1:floor(size(allData, 1)*0.8), :);
testData = allData(floor(size(allData, 1)*0.8)+1:size(allData, 1), :);

% Training! %
Xtrainraw = extractUnmappedFeatures(trainingData);
mapper = createFeatureMapper(Xtrainraw);
Xtrain = mapper(Xtrainraw);
ytrain = extractLabel(trainingData);
lambda = 1;
theta = trainLinearReg(Xtrain, ytrain, lambda);

% Determine learning curve. %
Xval = mapper(extractUnmappedFeatures(cvData));
yval = extractLabel(cvData);

error_train = zeros(10, 1);
error_val = zeros(10, 1);
i = 1;
for count = 1:ceil(size(Xtrain, 1) / 10):size(Xtrain, 1)
	thisX = Xtrain(1:count, :);
	thisY = ytrain(1:count);
	theta = trainLinearReg(thisX, thisY, lambda);
	error_train(i) = costFunctionReg(theta, thisX, thisY, 0);
	error_val(i) = costFunctionReg(theta, Xval, yval, 0);
	i = i + 1;
end
plot(1:10, error_train, 1:10, error_val);