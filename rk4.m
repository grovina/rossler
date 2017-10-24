function [ dx ] = rk4( f,h,x )
%RK4 4th-order Runge-Kutta
    k1 = h*f(x);
    k2 = h*f(x+k1/2.);
    k3 = h*f(x+k2/2.);
    k4 = h*f(x+k3);
    dx = (k1+2*k2+2*k3+k4)/6.;
end