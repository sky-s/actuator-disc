function [shaftPower,propellerEfficiency,inducedVelocity,idealEfficiency] = ...
    power(thrust,density,area,velocity,discEfficiency)
% Actuator disc power calculation (classic momentum theory).
% 
%   Syntax:
%   [shaftPower,propellerEfficiency,inducedVelocity,idealEfficiency] = ...
%       actuator_disc.power(thrust,density,area,velocity,discEfficiency)
% 
%   area is the effective area of the actuator disc.
% 
%   discEfficiency, inducedPower/shaftPower, is the efficiency of shaft power
%   adding momentum to the flow in the useful (i.e. axial) direction, which
%   captures losses from effects such as swirl and viscosity. Default
%   discEfficiency = 1 (shaftPower = inducedPower).
% 
%   propellerEfficiency is the efficiency of converting shaft power to thrust
%   power, thrust*velocity/shaftPower.
% 
%   idealEfficiency is, given the effective area, momentum theory ideal
%   efficiency, velocity/(velocity + inducedVelocity).
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

inducedVelocity = actuator_disc.inducedvelocity(thrust,density,area,velocity);
inducedPower = thrust.*(velocity + inducedVelocity);

shaftPower = inducedPower./discEfficiency;

if nargout > 1
    idealEfficiency = velocity./(velocity + inducedVelocity);
    propellerEfficiency = thrust.*velocity./shaftPower;
end
end
