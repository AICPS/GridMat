%#PARAM
%#I occupant_H_1/occupancy_fraction=occupantload(1);
%#B light_H_1/installed_power=lights(1);
%#END

if(occupantload(1)<1)
    lights(1)=0;
else
    lights(1)=0.9;
end