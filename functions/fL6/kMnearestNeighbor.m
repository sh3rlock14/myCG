function newSeeds = kMnearestNeighbor(X,S)
%NEARESTNEIGHBOR Summary of this function goes here
%   Detailed explanation goes here
%{
@param X: sono tutti i punti colore dell'immagne forniti con la tripla rgb uint8 
@param S: sono i seed che fungeranno da "kluster points"

per ogni punto in X, devo trovare quale sia il punto in S pi� vicino
@param x: � la terna rgb di un punto in X
@param s: � la terna rgb di un punto in S
distanzaColore: norm( x(:) - s(:)  )
%}

nPunti = length(X);

% il vettDist conterr� coppie (punto, indiceClusterInS)
vettDist = cell(nPunti,2);

%per ogni punto in X
for punto=1: nPunti
    % il risparmio di tempo con la seguente ottimizzazione � di circa 12s.
    if punto>1 & (X(punto,:) == X(punto-1,:))
        % se un punto che sto controllando � uguale ad uno immediatamente
        % precedente, non cerco un cluster: gi� ce l'ho! � quello calcolato
        % per il punto precedente
        vettDist(punto,1) = {X(punto,:)};
        vettDist(punto,2) = vettDist(punto-1,2);
        continue
    end
    
    % piazzo in vettDist(punto,1) il punto
    vettDist(punto,1) = {X(punto,:)};
    % piazzo in vettDist(punto,2) il Seed pi� vicino al punto
    vettDist(punto,2) = {vicino(X(punto,:),S)}; 
end

% inizializzo il nuovo array di dimensioni pari a S
% che ospiter� i nuovi Seeds
newSeeds = zeros(length(S),3);
% devo tenere il conto di quanti vettori sono in un cluster
occorrenze = zeros(length(S),1);

% per ogni elemento in vettDist
% nb: un elemento in vettDist � una coppia (punto e indice del Cluster di appartenenza)
for elemento=1:length(vettDist)
    % nella riga specificata dall'indice del cluster, devo sommare il
    % vettore che fa riferimento a quel cluster
    newSeeds(vettDist{elemento,2},:) = newSeeds(vettDist{elemento,2},:) + vettDist{elemento,1};
    occorrenze(vettDist{elemento,2}) = occorrenze(vettDist{elemento,2}) + 1;    
end

% devo calcolare i centroidi per ciascun Cluster
% e ritorno l'elenco dei nuovi Seeds
newSeeds = newSeeds ./ occorrenze;

end

