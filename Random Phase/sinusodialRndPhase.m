phase = pi*(-1 + 2*rand(1,1)); % uniformly distributed vals in range [-pi, pi]

fs = 44100; T = 1; N = fs*T; Nphase = 10000; t = (0:N-1)*(1/fs); phaseAxis = linspace(-pi,pi,Nphase);
f0 = 20; w0 = 2*pi*f0; n_ = (0:N-1); m_ = (0:2*N-1);
xt =@(n,ph) sin((n/fs).*w0 + ph);
mu_x = [];
for k = (n_ + 1)
    mu_x = [mu_x; mean(xt(k,phaseAxis))]; 
    % (1/(2*pi))*sum(xt(k,phaseAxis))]; <-- why it doesn't work ?
end
subplot(311); stem(n_(1:15000), xt(n_(1:15000),phase)); grid on; title("x[n] = sin(n*w0 + ph), for phase randomly distributed over [-{\pi},{\pi}]");
xlabel("n [samples]"); ylabel("x[n]");
subplot(312);stem(n_,mu_x); axis([0 N-1 -1 1]); grid on; title("{\mu}[n] for x[n] = sin(n*w0 + ph)");
xlabel("n [samples]"); ylabel("{\mu}[n]");

r_xt = (1/N)*xcorr(xt(n_,phase),xt(m_,phase));
subplot(313);stem([-N/2:N/2-1],r_xt(N:2*N-1)); grid on; title("R_x_x of Process X[n]"); xlabel("k [time interval]"); ylabel("R_x_x[n]"); axis tight; ylim([-1,1]);