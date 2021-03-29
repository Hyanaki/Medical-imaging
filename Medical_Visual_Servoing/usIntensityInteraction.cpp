/*!
  \file cptImgLs.cpp
  \brief Compute interaction matrix for visual servoing based on intensity features
*/


#include "usIntensityInteraction.h"

#define TO_COMPLETE


/*!
  \brief compute the interaction matrix used in the control law
  \param dIdx,dIdy,dIdz: gradient images along x,y and z directions
  \param sx,sy: scaling parameters (in meter)
  \param ip0,ipf: upper left and lower right corners of the ROI (in pixels)
  \return Ls: interaction matrix used in the control law of size nbP*6 (with nbP the number of features)
*/

vpMatrix cptImgLs::Ls( vpImage<double> &dIdx, vpImage<double> &dIdy, vpImage<double> &dIdz, double sx, double sy, vpImagePoint ip0, vpImagePoint ipf )
{
    int imgW = dIdx.getWidth() ; // ultrasound image width in number of pixels
    int imgH = dIdx.getHeight() ; // ultrasound image height in number of pixels
    int Wmin = (int)ip0.get_u(); // pixel u coordinate of the ROI left-top corner
    int Wmax = (int)ipf.get_u(); // pixel u coordinate of the ROI right-bottom corner
    int Hmin = (int)ip0.get_v(); // pixel v coordinate of the ROI left-top corner
    int Hmax = (int)ipf.get_v(); // pixel v coordinate of the ROI right-bottom corner
    int nbPx = (Hmax-Hmin+1)*(Wmax-Wmin+1) ; // number of visual features
    
    int ROIW = (Wmax-Wmin+1); // Width of the ROI in number of pixels
    int ROIH = (Hmax-Hmin+1); // Height of the ROI in number of pixels
    int u0 = imgH/2;
    int v0 = imgW/2;

    vpMatrix Ls(nbPx, 6);

#ifdef TO_COMPLETE
    // Question 4
    // compute the interaction matrix related to the visual features
    
    for(int u=Hmin, i=0 ; u<Hmax+1 ; u++, i++){

        double y = sy*(u-u0);
        for(int v=Wmin, j=0 ; v<Wmax+1 ; v++, j++){

            double x = sx*(v-v0);
            Ls[i*ROIW + j][0] = dIdx[u][v];
            Ls[i*ROIW + j][1] = dIdy[u][v];
            Ls[i*ROIW + j][2] = dIdz[u][v];
            Ls[i*ROIW + j][3] = y * dIdz[u][v];
            Ls[i*ROIW + j][4] = -x * dIdz[u][v];
            Ls[i*ROIW + j][5] = x * dIdy[u][v] - y * dIdx[u][v];
        }
    }


#endif

    return Ls ;
}



