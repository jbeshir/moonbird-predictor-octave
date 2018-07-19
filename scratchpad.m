% Initial environment preparation. %
fileData = csvread('summarydata.csv')(:, 1:6);
resolvedUnshuffledData = fileData(fileData(:, 6) != 0, :);
allData = resolvedUnshuffledData(randperm(size(resolvedUnshuffledData,1)),:);
trainingData = allData(1:floor(size(allData, 1)*0.6), :);
cvData = allData(floor(size(allData, 1)*0.6)+1:floor(size(allData, 1)*0.8), :);
testData = allData(floor(size(allData, 1)*0.8)+1:size(allData, 1), :);
responseData = csvread('responsedata.csv')(:, 1:3);

% Training! %
Xtrainraw = extractUnmappedFeatures(trainingData, responseData);
mapper = createFeatureMapper(Xtrainraw);
Xtrain = mapper(Xtrainraw);
ytrain = extractLabel(trainingData);
lambda = 1;
theta = trainLinearReg(Xtrain, ytrain, lambda);

% Determine learning curve. %
Xval = mapper(extractUnmappedFeatures(cvData, responseData));
yval = extractLabel(cvData);

curvePoints = 100;
error_train = zeros(curvePoints, 1);
error_val = zeros(curvePoints, 1);
i = 1;
for count = (size(Xtrain, 1) / curvePoints):(size(Xtrain, 1) / curvePoints):size(Xtrain, 1)
	thisX = Xtrain(1:count, :);
	thisY = ytrain(1:count);
	theta = trainLinearReg(thisX, thisY, lambda);
	error_train(i) = costFunctionReg(theta, thisX, thisY, 0);
	error_val(i) = costFunctionReg(theta, Xval, yval, 0);
	i = i + 1;
end
plot(1:curvePoints, error_train, 1:curvePoints, error_val);

% Compare with naive algorithm using regular cost function and mean squared error. %
Xval = mapper(extractUnmappedFeatures(cvData, responseData));
yval = extractLabel(cvData);
Jvalmse = mseCostFunction(theta, Xval, yval);
Jvalnaivemse = mseCostFunctionNaive(cvData(:, 4), yval);
Jval = costFunctionReg(theta, Xval, yval, 0);
Jvalnaive = costFunctionNaive(cvData(:, 4), yval);