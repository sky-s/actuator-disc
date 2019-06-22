% A short demo of the usage of actuator_disc tools.
% 
%   <a href="matlab:actuator_disc.demo">Run demo</a>.
%   <a href="matlab:edit actuator_disc.demo">Open demo</a>.
% 
%   Part of the demo (but not the tools) uses the Pysical Units Toolbox:
%       https://www.mathworks.com/matlabcentral/fileexchange/38977.
% 
%   See also actuator_disc.

% Copyright Sky Sartorius.
% Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715 

%% Find power to produce a constant amount of thrust over a range of speeds.
density = 1.225; % kg/m^3
area = 2; % m^2
discEfficiency = 0.85;
velocity = -10:100; % m/s
thrust = 2000; % N

[shaftPower,propellerEfficiency,~,idealEfficiency] = ...
    actuator_disc.power(thrust,density,area,velocity,discEfficiency);

% Plotting.
subplot(2,1,2)
plot(velocity,shaftPower)
xlabel('Velocity (m/s)')
ylabel('Shaft power (W)')

subplot(2,1,1)
plot(velocity,idealEfficiency*100,velocity,propellerEfficiency*100)
ylabel('Efficiency (%)')
legend('\eta_{ideal}','\eta_{propeller}')
title('Constant thrust')

%% Find thrust available with constant shaft power over a range of speeds.
density = 0.002*u.slug/u.ft^3;
area = 30*u.ft^2;
discEfficiency = 0.85;
velocity = (-20:200)*u.kts;
shaftPower = 200*u.hp;

[thrust,propellerEfficiency,inducedVelocity,idealEfficiency] = ...
    actuator_disc.thrust(shaftPower,density,area,velocity,discEfficiency);

% Plotting.
figure
subplot(3,1,3)
plot(velocity/u.kts,thrust/u.lbf)
xlabel('Velocity (ktas)')
ylabel('Thrust (lb_f)')

subplot(3,1,2)
plot(velocity/u.kts,inducedVelocity/u.fps)
ylabel('Induced velocity (fps)')

subplot(3,1,1)
plot(velocity/u.kts,idealEfficiency*100,velocity/u.kts,propellerEfficiency*100)
ylabel('Efficiency (%)')
legend('\eta_{ideal}','\eta_{propeller}')
title('Constant power')

%% Validate the inverse equations.
sz = [1e5,1];
density = rand(sz); % kg/m^3
area = rand(sz); % m^2
discEfficiency = rand(sz);
velocity = rand(sz); % m/s
thrust_1 = rand(sz); % N

[shaftPower,propellerEfficiency_1] = ...
    actuator_disc.power(thrust_1,density,area,velocity,discEfficiency);

[thrust_2,propellerEfficiency_2] = ...
    actuator_disc.thrust(shaftPower,density,area,velocity,discEfficiency);

thrustError = thrust_2 - thrust_1;
efficiencyError = propellerEfficiency_2 - propellerEfficiency_1;

tol = sqrt(eps);
if any(abs(thrustError) > tol)
    warning("Thrust mismatch found.")
end
if any(abs(efficiencyError) > tol)
    warning("Efficiency mismatch found.")
end
figure
plot(thrustError)
ylabel('Thrust error')
fprintf('Max error: %g\n',max(abs(thrustError(:))))

if isnan(actuator_disc.thrust(0,1,1,1,1))
    warning('T=NaN when P=0')
end
