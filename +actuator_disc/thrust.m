function [thrust,propellerEfficiency,inducedVelocity,idealEfficiency] = ...
    thrust(shaftPower,density,area,velocity,discEfficiency)
% Actuator disc thrust calculation (inverse classic momentum theory).
% 
%   Syntax:
%   [thrust,propellerEfficiency,inducedVelocity,idealEfficiency] = ...
%       actuator_disc.thrust(shaftPower,density,area,velocity,discEfficiency)
% 
%   discEfficiency, inducedPower/shaftPower, is the efficiency of shaft power
%   adding momentum to the flow in the useful (i.e. axial) direction, which
%   captures losses from effects such as swirl and viscosity. Default
%   discEfficiency = 1 (shaftPower = inducedPower).
% 
%   propellerEfficiency is the efficiency of converting shaft power to thrust
%   power, thrust*velocity/shaftPower.
% 
%   idealEfficiency is momentum theory ideal efficiency, 
%   velocity/(velocity + inducedVelocity).
% 
%   There is no unit conversion, so units must be consistent, e.g. power in
%   ft-lbf/s instead of horsepower.
% 
%   See also actuator_disc.

% Copyright Sky Sartorius.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 

if nargin < 5
    discEfficiency = 1;
end
if nargin < 4 || isempty(velocity)
    velocity = 0;
end

inducedPower = shaftPower.*discEfficiency;

k = density.*area;
mu = k.*(2/3.*velocity).^3;
alpha = inducedPower.^(3/2).*sqrt(mu + inducedPower) + inducedPower.^2;
beta = k.^2.*inducedPower./(1 + sqrt(mu./inducedPower + 1));

thrust = (k.*alpha).^(1/3) - 2/3*velocity.*beta.^(1/3);
     
if nargout > 1
    inducedVelocity = actuator_disc.inducedvelocity(...
        thrust,density,area,velocity);
    idealEfficiency = velocity./(velocity+inducedVelocity);
    propellerEfficiency = thrust.*velocity./shaftPower;
end
end
