%#PARAM
%#I occupant_H_1/occupancy_fraction=occupantload(1);
%#O H_1/cooling_setpoint=house_2;
%#O H_1/heating_setpoint=house_3;
%#I EVSE/power=evcharger_det_3;
%#END

if(occupantload(1)<1)
    house_2 = 1;
    house_3 = 0;
else
    house_2 = 73;
    house_3 = 68;
end