function mapper = createFeatureMapper(rawTrainingX)
	meanX = mean(rawTrainingX);
	rangeX = max(rawTrainingX)-min(rawTrainingX);
	mapper = @(rawX) [ones(size(rawX, 1), 1), transformFeatures(bsxfun(@rdivide, bsxfun(@minus, rawX, meanX), rangeX .* 0.5))];
end