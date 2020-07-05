%input è la matrice fs_trainX da 207x45 elementi

%imposta gli intervalli che verranno poi stampati
%sui grafici per segnalare gli intervalli di indentificazione
%per le membership function del sistema mamdani

function [features_intervals, x_values] = calcola_intervalli(input)

    %input=fs_trainX;
	num_elem = numel(input(:,1));
	x_values = 1:num_elem;
    %struttura da 4x1 elementi, in cui inserirò vettori
	features_intervals = cell(4,1);
    features = zeros(16, num_elem);
	
    %features_intervals 4 array da 4x207 elementi
    %una volta selezionate le features tramite la features selection definisco gli intervalli per discriminare
    %le varie attivita'
    
	for i=1:4 % il numero di features
		for j=1:4 %il numero di soglie per le 3 feature selection     
            if i==1
				if j==1
					features(1,:) = 3000;
				elseif j==2
					features(2,:) = 7000;
				elseif j==3
					features(3,:) = 10000;
				elseif j==4
					features(4,:) = 16000;
                end
			
            features_intervals{1,1} = features(1:4,:);
                
			elseif i==2
	       		    if j==1
	       		    features(5,:) = 5000;
	       		elseif j==2
	       			features(6,:)= 7900;
	       		elseif j==3
	       			features(7,:) = 10000;
	       		elseif j==4
	       			features(8,:) = 21000;
            end	       		
	       	features_intervals{2,1} = features(5:8,:);
                
	       	elseif i==3
	       		if j==1
	       			features(9,:) = 4100;	       			
	       		elseif j==2
	       			features(10,:) = 7000;
	       		elseif j==3
	       			features(11,:) = 15000;
	       		elseif j==4
	       			features(12,:) = 27000;
           	end	       		
	       	features_intervals{3,1}=features(9:12,:);
	       		
	       		else
	       			if j==1
	       				features(13,:) = 3500;
	       			elseif j==2
	       				features(14,:) = 12000;
	       			elseif j==3
	       				features(15,:) = 25000;
	       			elseif j==4
	       				features(16,:) = 71500;
                    end
            features_intervals{4,1} = features(13:16,:);
            end
        end%for with j
    end%for with i
end%function
