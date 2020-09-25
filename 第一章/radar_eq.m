function[snr]=radar_eq(pt,freq,g,sigma,te,b,nf,loss,range)
% pt:峰值功率 freq：雷达中心频率 g：天线增益 sigma：目标截面积 te：有效目标噪声温度 
% b:带宽 nf：噪声系数 loss：雷达损失 range：目标距离 snr：SNR
c = 3.0e+8; % speed of light
lambda = c / freq; % wavelength
p_peak = 10*log10(pt); % convert peak power to dB
lambda_sqdb = 10*log10(lambda^2); % compute wavelength square in dB
sigmadb = 10*log10(sigma); % convert sigma to dB
four_pi_cub = 10*log10((4.0 * pi)^3); % (4pi)^3 in dB
k_db = 10*log10(1.38e-23); % Boltzman's constant in dB
te_db = 10*log10(te); % noise temp. in dB
b_db = 10*log10(b); % bandwidth in dB
range_pwr4_db = 10*log10(range.^4); % vector of target range^4 in dB
% Implement Equation (2.22)
num = p_peak + g + g + lambda_sqdb + sigmadb;
den = four_pi_cub + k_db + te_db + b_db + nf + loss + range_pwr4_db;
snr = num - den;
return