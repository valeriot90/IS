%ritorna la rete di riconoscimento migliore
function best_net = compute_network(trX, trT, tstX, tstT)
	trainFcn = 'trainscg';
	%Scaled conjugate gradient backpropagation
    %trainscg is a network training function that updates weight and bias 
    %values according to the scaled conjugate gradient method.
    
	hiddenLayerSize = 25;
	net = patternnet(hiddenLayerSize);
	
	perc_error = 1;
	
    %alleno e testo 10 volte
    %train 85%
    %validazione 15%
	for i=1:10
		net.divideParam.trainRatio = 85/100;
		net.divideparam.valRatio = 15/100;
		net.divideParam.testRatio = 0/100;
		
		[net, tr] = train(net, trX', trT');
		
		y = net(tstX');
		tind = vec2ind(tstT');
		yind = vec2ind(y);
		
		percentError = sum(tind ~=yind)/numel(tind);
		
		if(percentError <perc_error)
			best_net = net;
			perc_error = percentError;
		end
	end
	
	y = best_net(tstX');
	
%plotconfusion(targets,outputs) returns a confusion matrix plot 
%for the target and output data in targets and outputs, respectively.
	plotconfusion(tstT', y)
end	
	
		
		
