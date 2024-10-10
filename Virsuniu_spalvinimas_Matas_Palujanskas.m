clc; clear; close all;
 
% briaunM  = [ 1 3 5 7 8 7;
%              2 4 4 8 9 9 ]; %Gretimumo matrica
% briaunM = [ 2 3 4 5 8 7 4 6 6 5 5 5;
%          3 6 7 3 3 2 8 2 8 2 1 4];
briaunM = [1 4 7 8 5;
           2 2 1 6 4];


virsKiek = max(max(briaunM)); %– viršūnių kiekis, 
briaunKiek = length(briaunM(1,:)); %– briaunų kiekis, 
d(1:virsKiek) = 0; %– viršūnių spalvų masyvas; 
virsSar = 1:virsKiek; % Viršūnių sąrašas
briaunAib = []; % į briaunAib struktūrą perrašoma briaunu matrica briaunM
for BrNr = 1:briaunKiek
    briaunAib{BrNr} = briaunM(:, BrNr);
end
 
% Viršūnių laipsnių apskaičiavimas
for i = 1:2
    for j = 1:briaunKiek
        k = briaunM(i,j);
        d(k) = d(k) + 1;
    end
end
 
% { BLlst(n, m, b, L, lst) }
lst(1:virsKiek+1) = 0;
for i = 1:virsKiek
    lst(i+1) = lst(i) + d(i);
end
fst = lst + 1;
L(1:2*briaunKiek) = 0;
for j = 1:briaunKiek
    k = briaunM(1,j);
    L(fst(k)) = briaunM(2,j);
    fst(k) = fst(k) + 1;
    k = briaunM(2,j);
    L(fst(k)) = briaunM(1,j);
    fst(k) = fst(k) + 1;
end
 
tic
 
% Kintamiesiems ir masyvams pradinių reikšmių priskyrimas  
for i = 1:virsKiek
    v(i) = i; %{ Masyve v iš eilės surašomi viršūnių numeriai } 
    s(i) = lst(i+1) - lst(i); %{s[i] – i-tosios viršūnės laipsnis } 
    d(i) = 0; 
end
 
% Viršūnės rikiuojamos laipsnių mažėjimo tvarka  
for k = 1:virsKiek-1
    for i = 1:virsKiek-k
        if s(i) < s(i+1) % Keičiame vietomis s[i] su s[i + 1] ir v[i] su v[i + 1]  
            z = s(i); 
            s(i) = s(i+1); 
            s(i+1) = z; 
            
            z = v(i); 
            v(i) = v(i+1); 
            v(i+1) = z; 
        end
    end
end
 
%jei d[i] = k, tai reiškia, kad i-oji viršūnė dažoma k-ąja spalva.  
sp = 0; % spalvų kiekis 
nud = 0; % nudažytų viršūnių kiekis 
while nud < virsKiek % vykdoma kol yra nors viena nenudazyta virsune
    sp = sp + 1; 
    for i = 1:virsKiek 
        u = v(i); 
        if d(u) == 0 % Jei virsune nera nudazyta 
            % ar is nenudazytu virsuniu yra virsune kuri yra gretima u
            % virsunei nudazyta sp spalva
            j = lst(u) + 1; 
            t = false; 
            while (j <= lst(u+1)) && ~t
                x = L(j); 
                if d(x) == sp 
                    t = true; 
                else
                    j =j+1;
                end
            end
            if ~t % jei ne t, tai virsune galima dazyti sp spalva 
                d(u) = sp; 
                nud = nud + 1; 
            end
        end
    end
end
 
%skaiciavimoLaikas = toc;

figure(1)
title('Grafo virsunes nudazytos pagal algoritma')
Vkor = plotGraphVU1(virsSar, briaunAib, 0, 0, [], 0, 10, 1, 'b');
vspalvos='rgbcmyk';
disp('Virsune   Virsune buvo nudazyta');
for i = 1:virsKiek
    fprintf('%5d %6d\n',i,d(i));
    Vkor1 = Vkor(i,:);
    figure(1);
    r = 0.08; % viršūnės spindulys
    x = Vkor1(1); y = Vkor1(2); % virsSar(i) viršūnės koordinatės
    rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1],'FaceColor',vspalvos(d(i)));
    if abs(i)<10 
        shiftx = 0.2*r; 
    else
        shiftx = 0.6*r;
    end
    str = sprintf('%d', abs(i));
    text(x-shiftx, y, str);
end
 
disp('Panaudotu spalvu kiekis(chromatinis skaicius):');
disp(sp);
%disp('Skaiciavimo laikas:');
%disp(skaiciavimoLaikas);


