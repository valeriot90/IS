function recog_percentage = sugeno(inputs, targets, feature_sel, fuzzy_sugeno)
	match=0;
	TRAIN_ELEMS = numel(inputs(:,1));
	
	for i=1:TRAIN_ELEMS
		y = evalfis(inputs(i, feature_sel), fuzzy_sugeno);
		
		t = vec2ind(targets(i,:)');
		
		y = round(y);
		
		if y==t
			match=match+1;
		end
	end
	recog_percentage = (match/TRAIN_ELEMS)*100;
end
