%prelevo i dati e li carico in una matrice
if(not(exist('DATA','var')))
	DATA = carica_dati();
end

%se la matrice di input e quella di target non esiste creala
%prendendo il max, min e media di ogni sottointervallo di 6 secondi
%se uno dei due non esiste..
if(not(exist('fs_inputs','var')&& exist('fs_targets','var')))
	[inputs, targets] = max_min_med(DATA);
end

%prelevo un set di campioni per il test (15%)
%questo sarà il training set per la rete neurale e il sistema fuzzy
% preleva un numero pari a test size dalla matrice fs_inputs e ritorna matrici
% inputs e target per train e test
dimensione_test = fix(numel(inputs(:,1))*0.15);

%prelevo un set di campioni per il test (15%)
%questo sarà il training set per la rete neurale e il sistema fuzzy
% preleva un numero pari a test size dalla matrice fs_inputs e ritorna matrici
% inputs e target per train e test

%unisco matrice input e target
dati = [inputs, targets];
%rand(x,y) ritorna una matrice di dimensione x*y con valori casuali tra 0 e 1
%il test ha una dimensione pari al 15%
righe = fix( (rand(dimensione_test,1))*numel(dati(:,1))+1 );    
colonne = numel(dati(1,:));  
%inizializzo dati_test con tutti 0  
dati_test = zeros(dimensione_test, colonne);    
dati_test = dati(righe,:);    
dati(righe,:) = [];
%prendo i dati per il train
input_train = dati(:, 1:colonne-4);    
target_train = dati(:, colonne-3:colonne);	
%e per il test
input_test = dati_test(:, 1:colonne-4);    
target_test = dati_test(:, colonne-3:colonne);

if(not(exist('fs','var')&& exist('history','var')))    
    %(vedi esempio su mathworks)
    %per eseguire la feature selection, è necessario definire una funzione fun!
	% [inmodel,history] = sequentialfs(fun,X,...) returns information on which feature is chosen at each step. history is a scalar structure with the following fields:
    % Crit — A vector containing the criterion values computed at each step.
    % In — A logical matrix in which row i indicates the features selected at step i.    
    %feature selection
    opts = statset('display','iter');
    fun = @(trainingX, trainingT, testingX, testingT)compute_errors(trainingX', trainingT', testingX', testingT');
	[fs, history] = sequentialfs(fun, input_train, target_train, 'options', opts);
end

%prendo solo gli elementi selezionati dalla features selection
%per l'input prendo un numero di colonne pari a fs
input_train_fs = input_train(:,fs);
target_train_fs = target_train;
%test è il 15% del totale, quindi 36
input_test_fs = input_test(:,fs);
target_test_fs = target_test;

if(not(exist('net','var')))
%   ritorna la rete di riconoscimento migliore
%   allenata 10 volte
%   hidden layers: 25
%   train 85% validazione 15% test 0%
%   per il train do le features selezionate dalla funzione
%   il test rimane uguale
	net = compute_network(input_train_fs, target_train_fs, input_test_fs, target_test_fs);
end

y = net(input_test_fs')	;
plotconfusion(target_test_fs',y);

%do in ingresso 4 features selezionate e visualizzo la distribuzione delle
%features
[ranges, lin_val] = analisi_features(inputs, targets, history);

feature_sel = find(history.In(4, :)' == 1);
mamdani_ris = mamdani_test(inputs, targets, feature_sel);

sugeno_input_train = input_train(:,feature_sel);

%inserisco i dati numerici da 1 a 4 -> DA FARE CON IL CICLO FOR
sugeno_target_train = vec2ind(target_train(:,:)')';

sugeno_train = [sugeno_input_train, sugeno_target_train];

%PER IL SUGENO TESTING
sugeno_input_test = input_test(:,feature_sel);
sugeno_target_test = vec2ind(target_test(:,:)')';
sugeno_test = [sugeno_input_test, sugeno_target_test];

%7 è il numero di funzioni membro associate ad ogni input
fuzzy_sugeno = genfis1(sugeno_train, 7, 'gaussmf', 'constant');
fuzzy_sugeno = anfis(sugeno_train, fuzzy_sugeno);

sugeno_recognition_perc = sugeno(inputs, targets, feature_sel, fuzzy_sugeno);

sugeno_test_recognition = sugeno(input_test, target_test, feature_sel, fuzzy_sugeno);
sugeno_train_recognition = sugeno(input_train, target_train, feature_sel, fuzzy_sugeno);


