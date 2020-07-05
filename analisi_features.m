% seleziona un sottoinsieme di feature di 4 a partire dalle 7 ricavate
% affinchè le regole del sistema fuzzy non siano troppo complicate
% 
% avviene il model fitting: cioè per ogni features si visualizza la 
% distribuzione dei valori su cui ogni features è distribuita
% input è matrice di 207x45, cioè l'input(train) senza il test set

%CONTROLLO SOLO LE PRIME 4 FEATURES

function [r, l_vals]=analisi_features(input, target, history)

    n_features = 4;
	feature_sel = find(history.In(n_features, :)' == 1);
    
    %permette di creare un cell array di dimensioni 4x1
	pY = cell(4,1);
	pX = cell(4,1);
	
    %Find indices and values of nonzero elements
    %vec2ind converte un vettore in un indice
	for k=1:4
		pY{k,1} = input(find(vec2ind(target')==k), :);
		pX{k,1} = 1:numel(pY{k,1}(:,1));
    end
	    
    %calcola gli intervalli per le membership functions
    %in input accetta un vettore di 4 righe e tutte le colonne
    %il numero di intervalli ritornati è 4
	[features_intervals, x_values] = calcola_intervalli(input);
	%x_values  viene inizializzato con tutti i numeri che vanno
    %da 1 a 207 (la sua dimensione)
    
    %subplot divide la figura corrente in pannelli rettangolari di un
    %numero dato
	for i=1:n_features
        %hist() disegna istogrammi
        %fs_redux: plotto solo le prime 4 features
		
		start=0;
		
		for j=1:4
			app = pX{j,1}+start;
			%subplot(2,n_features, 4+i)
            subplot(1,n_features, i)
			plot(app, pY{j,1}(:, feature_sel(i))')
			hold on
			start = start + numel(pX{j,1});
		end
		
		title(strcat('features ', num2str(i)));
		legend('Dorsi', 'Scale', 'Supino', 'Cammin')
        
		for j=1:4
            %k-- black dashed line
			%plot(x_values, features_intervals{i,1}, 'm--')  
            plot(x_values, features_intervals{i,1}, 'k-')  
        end
    end
    %r è la matrice che contiene i range di definizione delle funzioni
	r=zeros(n_features, 2);
	for i=1:n_features
		r(i,1) = min(input(:, feature_sel(i)));
		r(i,2) = max(input(:, feature_sel(i)));
	end
	
	l_vals = cell(2,1);
	
	for i=1:n_features
		for j=1:4
			l_vals{1,1}(i,j) = min(pY{j,1}(:,feature_sel(i)));
			l_vals{2,1}(i,j) = max(pY{j,1}(:, feature_sel(i)));            
		end
	end			
end
			
			
			
			
