%#PARAM
%#I occupant_H_1/occupancy_fraction=occupantload(1);
%#B TM_1_T_1_AS_632/service_status=triplex_meter_2;
%#END

if(occupantload(1) == 0)
    triplex_meter_2 = 0;
else
    triplex_meter_2 = 1;
end