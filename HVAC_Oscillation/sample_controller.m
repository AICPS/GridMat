%#PARAM
%#I occupant_H_1/occupancy_fraction=occupantload(1);
%#B H_1/cooling_setpoint=house_2;
%#B H_1/heating_setpoint=house_3;
%#END

if(house_2 == 1)
    house_2 = 90;
    house_3 = 75;
else
    house_2 = 1;
    house_3 = 0;
end