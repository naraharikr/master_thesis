function cvrg_res = addopt_with_delays(stepsize)

total_delay = [1 2 3 4 5 6 7 8 9 10];
n_total_delay = length(total_delay);

for k=1:n_total_delay
    % column-stochastic weight matrix
    B = [1/3 0 0 1/2 0; 1/3 1/3 0 0 0; 1/3 1/3 1/2 0 1/3; 0 0 0 1/2 1/3; 0 1/3 1/2 0 1/3];
    n = length(B);
    xd = [4 1 5 2 3]';
    vd = ones(n,1);
    yd = zeros(n,1);
    alpha = [2 4 5 3 1]';
    zd = vd./xd;
    
    % initialization for network with delays
    maxDelay = total_delay(k);
    vd_k = [vd' zeros(1,n*maxDelay)]';
    xd_k = [xd' zeros(1,n*maxDelay)]';
    yd_k = [yd' zeros(1,n*maxDelay)]';
    xd_0 = xd_k; xd_arxiv = xd;
    yd_0 = yd_k; yd_arxiv = yd;
    zd_arxiv = zd; vd_arxiv = vd;

    % initialization of cost function
    n_aug = n+(n*maxDelay);
    alpha = [alpha' zeros(1,n*maxDelay)]';
    gradientEstimatordelay = zeros(n_aug,1);
    for m=1:n_aug
        yd_0(m)=compute_gradient(xd_0(m),xd_0(m),alpha(m));
    end
    gradientEstimatordelay_arxiv=yd_0;

    % consensus value (linear convergence to optimal value of x)
    average_x = mean(xd_0);
    optimal_x = sum(alpha.*xd_0)/sum(alpha);

    %% ADD-OPT Algorithm (Delays)
    itr = 2000; step=stepsize;
    for i=1:itr
        % create weight matrix with delay
        B_aug = gen_aug_weight_matrix(B,maxDelay);

        vd_k = B_aug*vd_k;
        vd_arxiv = [vd_arxiv vd_k(1:n)];
        
        xd_k = B_aug*xd_k - step*yd_k;
        xd_arxiv = [xd_arxiv xd_k(1:n)];
        
        zd_k = xd_k./vd_k;
        zd_arxiv = [zd_arxiv zd_k(1:n)];
        
        for j=1:n_aug
            gradientEstimatordelay(j) = ...
                                compute_gradient(zd_k(j),xd_0(j),alpha(j));
        end
        yd_k = B_aug*yd_k+gradientEstimatordelay...
                                     - gradientEstimatordelay_arxiv(:,end);
        yd_arxiv = [yd_arxiv yd_k(1:n)];
        
        gradientEstimatordelay_arxiv = ...
                     [gradientEstimatordelay_arxiv gradientEstimatordelay];
    end
    cvrg_res = zd_k(1:n);
    % Residual computation
    for i=1:itr
    temp=0;
        for j=1:n
            mean_square_error = (zd_arxiv(j,i)-optimal_x)^2;
            temp = temp + mean_square_error; 
        end
        residual(i)=temp/n;
    end
	%% Save results
    fprintf("\n****** STEP-SIZE = %f, DELAY = %d, %d ITERATIONS ****** \n",...
                     step,maxDelay,itr);
	fprintf("\nOptimal value of 'x' = %.4f \n",optimal_x);
	fprintf("\nConvergence result \n");
	fprintf("\t\t%.4d \n",cvrg_res);
	
	% generate a string of stepsize, delay and iterations with
    % current date and timestamp
    str_step = strrep(string(step),'.','_');
    fn = sprintf("resultLog_delay_%d_step_%s_itr_%d",maxDelay,str_step,itr);
    fprintf("\nWorkspace variables are saved with name >>>> \n");
    fprintf("  '%s.mat' \n",fn);
	fprintf("\n********************** END OF EXECUTION **********************");
    fprintf("\n");
    
    % save workspace with generated string name to home directory
    fp = sprintf("logs/step_%s/%s.mat",str_step,fn);
    save(fp,'vd_arxiv','xd_arxiv','zd_arxiv','yd_arxiv','maxDelay','step',...
            'itr','residual','cvrg_res');
end %% END: for m=1:n_total_delay

end %% END: function cvrg_res = addopt_with_delays(alpha)