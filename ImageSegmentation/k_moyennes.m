function [Segmentation,Seuils] = k_moyennes(im3d,k)
Moyennes = zeros(1,k);

% Initialisation de la segmentation de même dimension que le volume 3D
Segmentation = im3d;

% Recuperation des valeurs min/max de l'image 3D
maxValue = max(im3d(:));
minValue = min(im3d(:));

%initialisation des k seuils
Seuils=linspace(minValue,maxValue,k+1);

Seuils_old = Seuils+1;
while (norm(Seuils-Seuils_old)>0) %tant que les seuils bougent

	%Mise a jour des moyennes de chaque classe 
	for i=1:k
		Moyennes(i) = mean(im3d(im3d>Seuils(i) & im3d<Seuils(i+1)));
	end
  
   Seuils_old = Seuils;
   %Mise a jour des seuils s�parant chaque classe
   Seuils(2:k) = (Moyennes(2:k)+Moyennes(1:k-1))/2;
end

%Construction de la segmentation 
Segmentation(im3d<Seuils(2)) = (Seuils(2)+Seuils(1))/2;
for i =2:k+1
    Segmentation(im3d<Seuils(i) & im3d>Seuils(i-1)) = (Seuils(i)+Seuils(i-1))/2;
end
% On met les valeurs de NaN à 0
Segmentation(isnan(im3d))=0;

% Affichage des coupes successives suivant les 3 differentes vues en fausse couleur
figure;
length = size(im3d);
for i=1:3
    for j=1:length(i)
        im2d = CoupeVolume(Segmentation,j,i);
        imagesc(im2d);axis equal;axis off;
        drawnow;
    end
end



