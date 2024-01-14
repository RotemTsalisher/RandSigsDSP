clc; clear;
fs = 44100; f0 = 440; portion = 1000; duration = 1; Ts = 1/fs;
N = fs*duration;
t = (0:N-1)*Ts;

figure(1)
xt_square = square(2*pi*f0.*t); %sig
xt_square_noise = xt_square + 0.5*randn([1, length(xt_square)]); %sig with added noise
r_xt_square_noise = xcorr(xt_square_noise,xt_square_noise,"normalized"); % auto-corr of sig with added noise
subplot(211); stem([0:portion-1],xt_square_noise(1:portion)); grid on; 
title("x(t) = square + noise"); xlabel("samples"); ylabel("x(t)");
subplot(212); stem([-portion:portion-1], r_xt_square_noise(length(xt_square) - portion:length(xt_square) + portion - 1)); grid on; ylim([-1.5,2]);
title("r[k] = auto-corr of x(t) (Normalized)"); xlabel("k"); ylabel("r[k]");

xt_saw = sawtooth(2*pi*f0.*t); %sig
xt_saw_noise = xt_saw + 0.5*randn([1, length(xt_saw)]); %sig with added noise
r_xt_noise = xcorr(xt_saw_noise,xt_saw_noise,"normalized"); % auto-corr of sig with added noise
figure(2)
subplot(211); stem([0:portion-1],xt_saw_noise(1:portion)); grid on; 
title("x(t) = saw + noise"); xlabel("samples"); ylabel("x(t)");
subplot(212); stem([-portion:portion-1], r_xt_noise(length(xt_saw) - portion:length(xt_saw) + portion - 1)); grid on; ylim([-1.5,2]);
title("r[k] = auto-corr of x(t) (Normalized)"); xlabel("k"); ylabel("r[k]");

xt_triangle = sawtooth(2*pi*f0.*t,1/2); %sig
xt_triangle_noise = xt_triangle + 0.5*randn([1, length(xt_triangle)]); %sig with added noise
r_xt_triangle_noise = xcorr(xt_triangle_noise,xt_triangle_noise,"normalized"); % auto-corr of sig with added noise
figure(3)
subplot(211); stem([0:portion-1],xt_triangle_noise(1:portion)); grid on; 
title("x(t) = triangle + noise"); xlabel("samples"); ylabel("x(t)");
subplot(212); stem([-portion:portion-1], r_xt_triangle_noise(length(xt_triangle) - portion:length(xt_triangle) + portion - 1)); grid on; ylim([-1.5,2]);
title("r[k] = auto-corr of x(t) (Normalized)"); xlabel("k"); ylabel("r[k]");