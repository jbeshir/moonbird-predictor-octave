function X = extractUnmappedFeatures(rawSummaryData, rawResponseData)
	respFeatures = zeros(size(rawSummaryData, 1), 2);
	for i = 1:size(rawSummaryData, 1)
		responses = sortrows(rawResponseData(rawResponseData(:, 1) == rawSummaryData(i, 1), :), 2);
		predictingResponses = responses(~isnan(responses(:, 3)), :);
		respFeatures(i, 1) = predictingResponses(1, 3);
		respFeatures(i, 2) = predictingResponses(size(predictingResponses, 1), 3);
	end
	X = [rawSummaryData(:, 4),rawSummaryData(:, 5), respFeatures];
end