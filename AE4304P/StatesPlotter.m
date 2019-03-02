%% Plots State functions
function [] = StatesPlotter(Y,t,titlep)
if nargin < 2                                           %Function Input checks if the input is 
    error('myfuns:somefun2:InsufficientInputs', ...     %less than 2 it gives out a error. 
        'requires at leasr 2 inputs');  
end
                                             %Accepts plot title when available as function input
% Fill in unset optional values.
switch nargin
    case 2
        titlep = '';
end

figure;
title(titlep);
    for i=1:4
        subplot(2,2,i);
        plot(t,Y(:,i));
        xlabel('time [s]');
        switch(i)
            case 1 
                ylabel('Side Slip Angle [rad]')
                title('Aircraft Response Side Slip');
            case 2 
                ylabel('Pitch Angle [rad]')
                title('Aircraft Response Roll Angle');
            case 3 
                ylabel('pb/2V')
                title('Aircraft Response pb/2V');
            case 4 
                ylabel('rb/2V')
                title('Aircraft Response rb/2V');
        end
        grid on
    end
    
end