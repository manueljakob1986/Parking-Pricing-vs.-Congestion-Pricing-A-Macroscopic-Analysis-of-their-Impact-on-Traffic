function switch_on_real_time_information_parking_pr_capacity = c19_input_switch_on_real_time_information_parking_pr_capacity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This input parameter describes the parking and P+R capacity real-time
% information, switch it on or off.
% parking and P+R capacity real-time information switched on = 1
% parking and P+R capacity real-time information switched off = 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% switch_on_real_time_information_parking_pr_capacity = 0;
switch_on_real_time_information_parking_pr_capacity = h2_getGlobal_parking_pr_capacity_information;

end