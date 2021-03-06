function inducedVelocity = inducedvelocity(thrust,density,area,velocity)
% Actuator disc induced velocity calculation (classic momentum theory).
% 
%   Syntax:
%   inducedvelocity(thrust,density,area,velocity)
% 
%   See also actuator_disc.

% Copyright Sky Sartorius.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 

inducedVelocity = sqrt(thrust./(2*density.*area)); % Static.

if nargin > 3
    inducedVelocity = -velocity/2 + sqrt((velocity/2).^2 + inducedVelocity.^2);
end