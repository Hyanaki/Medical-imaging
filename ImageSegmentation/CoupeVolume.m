%Faire defiler les images mais flemme là
function IM = CoupeVolume(image,indice,vue)

    maxValue = max(image(:));
    minValue = min(image(:));
	
    if(vue==1)
        im = image(indice,:,:);
    elseif(vue==2)
        im = image(:,indice,:);
    else
        im = image(:,:,indice);
    end
    
    IM = squeeze(im);
	
    % Affichage de la coupe
    % imshow(IM,[minValue maxValue]);
end