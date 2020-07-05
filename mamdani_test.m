    %function recog_percentage = mamdani_test(inputs, targets, feature_sel, mamdani)
function recog_percentage = mamdani_test(inputs, targets, feature_sel)

    mamdani = readfis('mamdani.fis');
	match=0;
    %TRAIN_ELEMS il numero di elementi è pari a 240
	TRAIN_ELEMS = numel(inputs(:,1));
	OUTPUT_INTERVAL_LENGTH = 2;
	for i=1:TRAIN_ELEMS
        %uscita del sistema fuzzy
		y = evalfis(inputs(i,feature_sel), mamdani);
        %target->ha valori da 1 a 4
		t = vec2ind(targets(i,:)');
		y = fix(1+(y-1)/OUTPUT_INTERVAL_LENGTH);
		if y==t	
			match=match+1;
        end
    end
	recog_percentage = (match/TRAIN_ELEMS)*100;
end	
