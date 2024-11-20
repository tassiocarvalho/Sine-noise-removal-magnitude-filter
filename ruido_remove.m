clc;
clear all;
close all;

% Leitura da Imagem
Read = imread('lena 256x256.tif');  % Certifique-se de que o arquivo está no mesmo diretório do código
f = double(Read);  % Conversão para double

[N, ~] = size(f);
Maximo = max(max(f));

% Cálculo da Transformada de Fourier da Imagem Original
F = fft2(f);
F_centralizado = fftshift(F);
espectro_log = log(1 + abs(F_centralizado));   % usada para melhorar a visualização.

% Adição de Ruído Senoidal à Imagem Original
fre = 100 / N;
R = zeros(N, N);  % Inicialização da matriz de ruído
for I = 1:N
    for J = 1:N
       R(J, I) = 100 * sin((2 * pi * fre) * I);
    end
end
fn = f + R;

% Cálculo da Transformada de Fourier da Imagem com Ruído
F2 = fft2(fn);
F_centralizado2 = fftshift(F2);
espectro_log2 = log(1 + abs(F_centralizado2));

% Definindo o limite de corte (log(1 + |F|) >= 16.38)
% limite = exp(16.38) - 1;  % Magnitude mínima para cortar, Calcula 𝑒^16.38, onde 𝑒 é a base do logaritmo natural. Isso resulta em um valor muito alto, cerca de 8886110.52. O limite é usado para criar uma máscara, eliminando frequências acima desse valor.
limite = exp(15) - 1; %testando para ampllitude de ruido 100* sen


% Criar a máscara para cortar frequências com |F| >= limite
[X, Y] = meshgrid(-N/2:N/2-1, -N/2:N/2-1);
D = sqrt(X.^2 + Y.^2);  % Distância no espaço de frequências
F_magnitude = abs(F_centralizado2);

% Máscara de corte: remove as frequências de magnitude maior ou igual ao limite
mascara = F_magnitude < limite; %é uma matriz lógica (0s e 1s), aplicada ao espectro para remover frequências indesejadas.

% Aplicar a máscara ao espectro com ruído
F_filtrado = F_centralizado2 .* mascara;

% Transformada Inversa para obter a imagem filtrada
F_filtrado_shifted = ifftshift(F_filtrado);  % Desfazer o deslocamento para o centro
imagem_filtrada = ifft2(F_filtrado_shifted);
imagem_filtrada = real(imagem_filtrada);  % Tomar apenas a parte real

% Plotar os resultados
figure;
colormap(gray(Maximo));

% Imagem Original
subplot(2, 3, 1);
imshow(f, []);
title('Imagem Original');

% Imagem com Ruído
subplot(2, 3, 2);
imshow(fn, []);
title('Imagem com Ruído');

% Espectro da Imagem Original
subplot(2, 3, 4);
imshow(espectro_log, []);
title('Espectro da Imagem Original (Escala Logarítmica)');
%colormap('jet');
colorbar;

% Espectro da Imagem com Ruído
subplot(2, 3, 5);
imshow(espectro_log2, []);
title('Espectro da Imagem com Ruído (Escala Logarítmica)');
%colormap('jet');
colorbar;

% Espectro da Imagem Filtrada
espectro_log_filtrado = log(1 + abs(F_filtrado));
subplot(2, 3, 6);
imshow(espectro_log_filtrado, []);
title('Espectro da Imagem Filtrada');
%colormap('jet');
colorbar;

% Imagem Filtrada
subplot(2, 3, 3);
imshow(imagem_filtrada, []);
title('Imagem Filtrada');


% Gráfico 3D do Espectro da Imagem Original
figure;
surf(X, Y, espectro_log, 'EdgeColor', 'none');
title('Espectro 3D da Imagem Original');
xlabel('Frequência X');
ylabel('Frequência Y');
zlabel('Magnitude (log)');
colormap('jet');
colorbar;
view(3); % Visão em perspectiva

% Gráfico 3D do Espectro da Imagem com Ruído
figure;
surf(X, Y, espectro_log2, 'EdgeColor', 'none');
title('Espectro 3D da Imagem com Ruído');
xlabel('Frequência X');
ylabel('Frequência Y');
zlabel('Magnitude (log)');
colormap('jet');
colorbar;
view(3); % Visão em perspectiva

% Gráfico 3D do Espectro da Imagem Filtrada
figure;
surf(X, Y, espectro_log_filtrado, 'EdgeColor', 'none');
title('Espectro 3D da Imagem Filtrada');
xlabel('Frequência X');
ylabel('Frequência Y');
zlabel('Magnitude (log)');
colormap('jet');
colorbar;
view(3); % Visão em perspectiva


