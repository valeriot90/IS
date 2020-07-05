function error = compute_errors(trainingX, trainingT, testingX, testingT)
%trainscg is a network training function that updates weight and bias 
%values according to the scaled conjugate gradient method	 
    traingFcn = 'trainscg';
	
	hiddenLayerSize = 25;
	net = patternnet(hiddenLayerSize);
	
	net.divideParam.trainRatio = 85/100;
	net.divideParam.valRatio = 15/100;
	net.divideParam.testRatio = 0/100;
	
	[net, tr] = train(net, trainingX, trainingT);
	
	y = net(testingX);
	tind = vec2ind(testingT);
	yind = vec2ind(y);
	error = sum(tind ~= yind);
end
	
