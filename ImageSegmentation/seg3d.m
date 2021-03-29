function seg3d(M0, indice_seuil)
	nbclasse = 3;
    [Segmentation,Seuils] = k_moyennes(M0,nbclasse);
	
	% Affichage des differentes données
    % Seuils
    % unique(Segmentation)
	
    MarchingCubes(smooth3(Segmentation), Seuils(indice_seuil));
end