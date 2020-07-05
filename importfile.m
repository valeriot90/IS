function [Sensor1, Sensor2, Sensor3, Times] = importfile(workbookFile)
		startRow = 1;
		endRow = 2200;
    
	[~,~, raw] = xlsread(workbookFile, sprintf('A%d:D%d', startRow(1), endRow(1)));
    
	for block=2:length(startRow)
		[~,~, tmpRawBlock] = xlsread(workbookFile, sprintf('A%d:D%d', startRow(block), endRow(block)));
		raw = [raw; tmpRawBlock]; 
	end
	
	raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x), raw)) = {''};
	
	I = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),raw),2);
	
	raw(I,:) = [];
	
	I = cellfun(@(x) ischar(x), raw);
	raw(I)={NaN};
	data = reshape([raw{:}], size(raw));
	
	Sensor1	= data(:,1);
	Sensor2 = data(:,2);
	Sensor3 = data(:,3);
	Times = data(:,4);
	
end	

	
			
