%#PARAM
%#I occupant_H_1/occupancy_fraction=occupantload(2);
%#B light_H_1/installed_power=lights(2);
%#END


if (occupantload(2)==0)
    lights(2)=0;
else
    lights(2)=10;
end