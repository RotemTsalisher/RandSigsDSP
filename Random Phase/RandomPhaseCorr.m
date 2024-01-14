phase = pi*(-1 + 2*rand(1,2)); % uniformly distributed vals in range [-pi, pi]


fs = 44100; T = 1; N = fs*T; t = (0:N-1)*(1/fs); f0 = 20; portion = 15000;

xtMat = [sin(2*pi*f0.*t + phase(1)); sin(2*pi*f0.*t + phase(2)) + 0.5*randn([1, N])];    
subplot(311); plot(t(1:portion),xtMat(1,[1:portion])); grid on; axis tight; 
title("Original Sinusodial Sig x(t)"); ylabel("x(t)"); xlabel("t [sec]");
subplot(312); plot(t(1:portion),xtMat(2,[1:portion])); grid on; axis tight;
title("Recieved Sig (y(t) = x(t) at a rand phase + noise)"); xlabel("t [sec]"); ylabel("y(t)");

r_xt = xcorr(xtMat(1,:), xtMat(2,:), "normalized");
subplot(313); stem([-portion:portion-1], r_xt(N - portion:N + portion - 1)); grid on;
title("R_x_y (Cross-corr)"); ylabel("R_x_y[k]"); xlabel("k [time diff]");
