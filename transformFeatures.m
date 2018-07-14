function transformedX = transformFeatures(normalizedUnmappedX)
	transformedX = [normalizedUnmappedX, normalizedUnmappedX(:,1).*normalizedUnmappedX(:,2)];
end