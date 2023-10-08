function [delta,dist,epicaz,stataz]=distazim(statlat,statlon,epilat,epilon);
%------------------------------------------------------------------------------- 
%  
%[delta,dist,epicaz,stataz]=distazim(statlat,statlon,epilat,epilon); 
%    
%     DISTAZIM calculates the epicentral distance and the azimuth between
%     station and source and vice versae.
%     
%     Input:
%      statlon     longitude station in degrees(+E,-W)
%      statlat     latitude station in degrees(+N,-S)
%      epilon      longitude epicenter in degrees(+E,-W)
%      epilat      latitude epicenter in degrees(+N,-S)
%      
%     Output:
%      delta         epicentral distance in degrees
%      dist          epicentral distance in km
%      stataz        azimuth of station 
%      epicaz        azimuth of epicenter
%      
%     Reference: Elementary Seismology, Richter, p317ff.
%                Handbuch der Mathematik, p331
%                
%     Stefan Fasthoff, 25.10.1993;revised, Xu Lisheng, Paris, Aug. 1998
%------------------------------------------------------------------------------     
      
%     constant 2*pi/360
      k=pi./180;
      
%     conversion deg-rad
      slon=statlon*k;
      elon=epilon*k;

%     conversion deg-rad and into geocentric latitude
      slat=atan(0.9933*tan(statlat*k));
      elat=atan(0.9933*tan(epilat*k));

%     calculation of delta in rad
      drad=acos(sin(slat)*sin(elat)+cos(slat)*cos(elat)*cos(slon-elon));

%     calculation of the azimuth
      saz=acos((sin(elat)-sin(slat)*cos(drad))/(cos(slat)*sin(drad)));
      eaz=acos((sin(slat)-sin(elat)*cos(drad))/(cos(elat)*sin(drad)));

%     conversion rad-deg                        
      delta=drad/k;
      epicaz=eaz/k;
      stataz=saz/k;
      
%     make sure the azimuth is measured from N clockwise
      if (sin(slon-elon)>0) 
         stataz=360-stataz;
      elseif (sin(elon-slon)>0)
         epicaz=360-epicaz;
      end

%Adjustment------------------------xu did--------------------
tempstat=stataz;
stataz=epicaz;
epicaz=tempstat;
%------------------------------------------------------------
%c     distance in km
      dist=delta*110.2;

%     end
%===============================End==============================================
