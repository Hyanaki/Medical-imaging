close all;clear;clc

load('IRM_cerveau_avecbiais.mat');
im2d = CoupeVolume(M0,80,3);

%on genere les donnees de l image avec biais
n = size(im2d,1);
p = size(im2d,2);
[x,y]=ndgrid(1:n,1:p);
z = im2d;

%z = 2*x-5*y+3 + randn(1,n); %Equation du plan z=2x-5y+3 et on ajoute du bruit blanc gaussien(mu=0 std=1)
% c'est cette �quation qu'on veut retrouver malgr� le bruit pr�sent dans les donn�es
% on cherche donc � estimer a,b et c tel que a*X + b*Y + c soit le plus proche de Z possible

%on affiche les donn�es
L=plot3(x,y,z,'ro'); % affiche les points (x,y,z) (donn�es)
%set(L,'Markersize',2*get(L,'Markersize')) % augmente la taille des cercles
%set(L,'Markerfacecolor','r') % remplit les cercles

pause %appuyez sur une touche pour continuer

Xcolv = x(~isnan(im2d)); % on transforme en vecteur colonne
Ycolv = y(~isnan(im2d)); 
Zcolv = z(~isnan(im2d)); 
Const = ones(size(Xcolv)); %vecteur de 1 pour le terme constant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Coefficients = [Xcolv Ycolv Const]\Zcolv; % Trouve les coefficients (moindre carr�)
%help \   -->  
%     If A is an M-by-N matrix with M < or > N and B is a column
%     vector with M components, or a matrix with several such columns,
%     then X = A\B is the solution in the least squares sense to the
%     under- or overdetermined system of equations A*X = B.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XCoeff = Coefficients(1); % coefficient dvt le terme en X (a)
YCoeff = Coefficients(2); % coefficient dvt le terme en Y (b)
CCoeff = Coefficients(3); % terme constant (c)
% avec les variables ci-dessus on a z " � peu pr�s �gal �" XCoeff * x + YCoeff * y + CCoeff
% il s'agit du plan qui "explique" le mieux les donn�es.

% On affiche le plan pour v�rifier
hold on
[xx, yy]=ndgrid(0:2:n,0:2:p); % g�n�re une grille r�guli�re pour l'affichage du plan estim�
zz = XCoeff * xx + YCoeff * yy + CCoeff;
surf(xx,yy,zz) % affiche le plan donn� par l'�quation estim�e
title(sprintf('Plan z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff)) %�quation du plan estim� (doit �tre proche de z=2x-5y+3)
% En tournant autour de la surface on voit que les points (x,y,z) sont "� peu pr�s" sur le plan estim�

result = im2d-((XCoeff)*x+(YCoeff)*y);
diff = im2d-result;
figure;
imshow(result,[]);
figure;
imshow(im2d,[]);
figure;
imshow(diff,[]);