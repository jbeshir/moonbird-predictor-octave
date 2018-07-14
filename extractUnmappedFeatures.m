function X = extractUnmappedFeatures(rawData)
	X = [rawData(:, 4),rawData(:, 5),rawData(:, 4).*rawData(:, 5)];
end