%prendo i dati e li importo in una matrice 10x16
%leggo i dati da 1 a 2200
%così non perdo nessun dato
function V = carica_dati()
	
	V=cell(10,16);
	
	for i=1:10
	
		f = strcat('Volunteer_',num2str(i));
        	f = strcat(f,'/V');
		f = strcat(f, num2str(i));
        
		f1 = strcat(f,' dorsiflexion.xlsx');
       	[V{i,1},V{i,2},V{i,3},V{i,4}] = importfile(f1);
		
		f1 = strcat(f,' stairs.xlsx');
		[V{i,5},V{i,6},V{i,7},V{i,8}] = importfile(f1);    
        
		f1 = strcat(f,' supine.xlsx');
		[V{i,9},V{i,10},V{i,11},V{i,12}] = importfile(f1);
		
		f1 = strcat(f,' walking.xlsx');      
		[V{i,13},V{i,14},V{i,15},V{i,16}] = importfile(f1);
		
	end
end
		
		
