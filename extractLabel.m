function X = extractLabel(rawData)
	X = rawData(:, 6) == 1;
end