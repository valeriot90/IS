%dato l'intero set di dati, li divide in 6 intervalli, ognuno dei quali composto da 5 sottointervalli
%l'uno: passo da circa 1000 features a 45

function [dati, target] = max_min_med(DATA)
	
    intervalli = 6;
    sottointervalli = 5;
	%inizializzo le matrici input X e target T
    %T di dimensioni 240x45
    %X di dimensioni 240x45
	dati = zeros(40*intervalli, sottointervalli*3*3);
	target = zeros(40*intervalli, 4);
	
	for i=0:intervalli-1 %scorro tutti i 6 INTERVALLI (da 0 a 5)
		for v=0:9 %scorro i 10 VOLONTARI (da 0 a 9)
			for p=0:3 %scorro le 4 POSIZIONI (da 0 a 3)
                %creo la matrice dei target, mettendo ad 1 quello rispetto
                %ad una posizione
				target(40*i+v*4+p+1,p+1) = 1;
%40 numero di dati, *l i 6 intervalli, scorro i 10 volontari(per scorrere un volontario
%scorro di 4 (le posizioni/attività), +j+1 per scorrere effettivamente le
%posizioni(+1 perchè l'indice del for parte da 0 ma quello della matrice da 1)
                
                
				for s=0:2 %scorro i 3 SENSORI (da 0 a 2)
                    %fix prende la parte intera inferiore di un numero
                    %numel numero di elementi dell'array
					iniziosottointervallo = fix( numel(DATA{v+1, 4*p+s+1})/intervalli)*i+1;
                    %start ha la dimensione di un intervallo, li scorro con
                    %l, +1 per l'indice
                    %10/2/2=2.5 continua a dividere
					finesottointervallo = fix( numel(DATA{v+1, 4*p+s+1})/intervalli/sottointervalli);
                    %pass ha la dimensione di un sottointervallo.
                    %li scorro sommando a start il valore di pass per ogni
                    %sottointervallo
					for si=0:sottointervalli-1 %scorro i 5 SOTTOINTERVALLI (da 0 a 4)
					
%in maniera simile scorro la matrice degli input per riga
%la colonna 1,2,3 gli indici di valore minimo, medio e massimo
%3*sensori*sottointervalli+3*sottointervalli, l'ultimo 3 è dato dai dati per ogni
%sottointervallo, appunto 3
%prendo il minimo, massimo e medio di un vettore
%il sottovettore degli elementi del vettore in DATA a
%partire da start a start+pass-1
						dati(40*i+v*4+p+1, sottointervalli*3*s+3*si+1) = min(DATA{v+1,4*p+s+1}(iniziosottointervallo:iniziosottointervallo+finesottointervallo-1));
						
						dati(40*i+v*4+p+1, sottointervalli*3*s+3*si+2) = mean(DATA{v+1,4*p+s+1}(iniziosottointervallo:iniziosottointervallo+finesottointervallo-1));
						
 						dati(40*i+v*4+p+1, sottointervalli*3*s+3*si+3) = max(DATA{v+1,4*p+s+1}(iniziosottointervallo:iniziosottointervallo+finesottointervallo-1));
						
						iniziosottointervallo = iniziosottointervallo+finesottointervallo;
					end
				end
			end
		end
	end
end
						
						
						
					
