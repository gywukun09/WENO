function u0 = CommonIC(x,ICcase)
% Create vector u0 with an Initial Condition. 8 cases are available.
%**************************************************************************
%
% 4 cases available: 
% {1} Gaussian wave for Advection problems
% {2} Gaussian wave for Diffusion problems
% {3} Lifted Sinusoidal wave
% {4} Centered Sinusoidal wave
% {5} HyperTangent for Burgers' Equation problem
% {6} Riemann IC
% {7} HyperTangent
% {8} Square Jump
% {9} Oleg's trapezoidal
%
% Coded by Manuel Diaz 2012.12.06
%**************************************************************************
% References: 
% [1] High-Order Methods for Diffusion Equation with Energy Stable Flux
% Reconstruction Scheme. K. Ou, P. Vincent, and A. Jameson. AIAA 2011-46.
%
%**************************************************************************
Lx=x(end)-x(1); xmid=0.5*(x(end)+x(1));
% Create the selected IC
switch ICcase
    case 1 % Gaussian wave for [-1,1] 
           % for advection test with periodic BCs. See ref [1].
        u0 = exp(-20*(x-xmid).^2);
        
    case 2 % Gaussian wave for [-3,3] 
           % for diffusion test with Dirichlet BCs. See ref [1].
        mu = 0.01;
        u0 = exp(-(x-xmid).^2/(4*mu));
               
    case 3 % Centered sinusoidal wave for [-1,1] for advection.
        u0 = sin(pi*x);
        
	case 4 % Lifted sinusoidal wave for [-1,1] for advection.
        u0 = 0.5 - sin(pi*x);
        
    case 5 % Hyperbolic Tangent in [-,2,2] 
           % for Viscous Burgers' equation with Dirichlet BCs. See ref [1].
        mu = 0.02;
        u0 = 0.5*(1-tanh(x/(4*mu)));
        
    case 6 % Riemann problem
        % u = 1 for x <  x_mid
        % u = 2 for x >= x_mid
        u0 = ones(size(x));
        u0(x<=xmid) = 2;
    
    case 7 % Hyperbolic Tangent
        % u = 1 for x <  x_mid
        % u = 0 for x >= x_mid
        a = x(1); b = x(end);
        xi = (4-(-4))/(b-a)*(x - a) - 4;
        u0 = 1/2*(tanh(-4*xi)+1);
        
    case 8 % Square Jump
        u0 = rectangularPulse(xmid-0.1*Lx,xmid+0.1*Lx,x)+1;
        
	case 9 % Displaced square Jump
        xmid = -0.25;
        u0 = rectangularPulse(xmid-0.125*Lx,xmid+0.125*Lx,x)+1;
        
    case 10 % Oleg's trapesoidal
        u0 = exp(-x).*rectangularPulse(xmid-0.1*Lx,xmid+0.1*Lx,x)*exp(.1);
        
    otherwise
        error('case not in the list')
end