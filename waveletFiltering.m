function [sal, apn] = waveletFiltering(spo2, apn)

% Si comienza con error lo elimino

while spo2(1) < 40
    spo2(1) = [];
    apn(1) = [];
end

while spo2(end)<40
    spo2(end) = [];
    apn(end) = [];
end

% sino es igual al valor anterior
index = find(spo2 < 40);
 for i = 1:length(index)
%     spo2(index(i))=spo2(index(i)-1);
     % apn(index(i))=300; % error
      apn(index(i)) = 0; % error
 end
dindex = diff(index);


% pongo una rampa cuando hay un error

j = 0;
for i = 1:length(index)-1
    if dindex(i) == 1
        j = j+1;
    else
        rampa = interp1([index(i-j)-1 index(i)+1],[spo2(index(i-j)-1)...
            spo2(index(i)+1)],index(i-j)-1:index(i)+1,'linear');
        spo2(index(i-j)-1:index(i)+1) = rampa;
        j = 0;
    end
   
end
if j ~= 0
    i = i+1;
    rampa = interp1([index(i-j)-1 index(i)+1],[spo2(index(i-j)-1)...
        spo2(index(i)+1)],index(i-j)-1:index(i)+1,'linear');
    spo2(index(i-j)-1:index(i)+1) = rampa;
    j = 0;
end

% filtrado
wsize = 256;
win = boxcar(wsize)';
paso = 32;
level = 8;

% Daubechies 1 is a Haar type
[sal, ~] = wavedetrendbanda(spo2, win, paso, level, 'Daubechies', 2); 
% Si comienza con error lo elimino
index = isnan(sal);
while index(1) == 1
    sal(1) = [];
    apn(1) = [];
    index = isnan(sal);
end
% sino es igual al valor anterior
index = find(index == 1);
for i = 1:length(index)
    sal(index(i)) = sal(index(i)-1);
end
end