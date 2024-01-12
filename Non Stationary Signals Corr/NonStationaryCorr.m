% signal is eval'd at fs*duration = 44.1k points, plotting length
% is controlled with parameter 'portion'

clc; clear;
fs = 44100; f0 = 25; portion = 1500; duration = 1; Ts = 1/fs;
N = fs*duration;
t = (0:N-1)*Ts;

xt = sin(2*pi*f0.*t); %sig
xt_noise = xt + 0.5*randn([1, length(xt)]); %sig with added noise
at = sin(2*pi*2500.*t); %env for sig
xt_env = at.*xt; % sig multiplied by env
xt_chirp = sin(2*pi*f0.*(t.^2));
r_xt_noise = xcorr(xt_noise,xt_noise,"normalized"); % auto-corr of sig with added noise
r_xt_env = xcorr(xt_env,xt_env,"normalized");
r_xt_chirp = xcorr(xt_chirp,xt_chirp,"normalized");

%addative noise: 
ylimits = max(abs(xt_noise)) + 0.1;
figure(1); subplot(211); stem([0:portion-1],xt_noise(1:portion)); grid on; ylim([-ylimits ,ylimits]);
title("x(t) = sin + noise"); xlabel("samples"); ylabel("x(t)");
subplot(212); stem([-portion:portion-1], r_xt_noise(length(xt) - portion:length(xt) + portion - 1)); grid on; ylim([-1.5,2]);
title("r[k] = auto-corr of x(t) (Normalized)"); xlabel("k"); ylabel("r[k]");

figure(2);
ylimits = max(abs(xt_env)) + 0.1;
subplot(211); stem([0:portion-1],xt_env(1:portion)); grid on; ylim([-ylimits ,ylimits]);
title("x(t) = sin*env"); xlabel("samples"); ylabel("x(t)");
subplot(212); stem([-portion:portion-1], r_xt_env(length(xt) - portion:length(xt) + portion - 1)); grid on; ylim([-ylimits,ylimits]);
title("r[k] = auto-corr of x(t) (Normalized)"); xlabel("k"); ylabel("r[k]");

figure(3);
subplot(211); stem([0:portion-1],xt_chirp(1:portion)); grid on; ylim([-ylimits ,ylimits]);
title("x(t) = sin*env"); xlabel("samples"); ylabel("x(t)");
subplot(212); stem([-portion:portion-1], r_xt_chirp(length(xt) - portion:length(xt) + portion - 1)); grid on; ylim([-1.5,2]);
title("r[k] = auto-corr of x(t) (Normalized)"); xlabel("k"); ylabel("r[k]");