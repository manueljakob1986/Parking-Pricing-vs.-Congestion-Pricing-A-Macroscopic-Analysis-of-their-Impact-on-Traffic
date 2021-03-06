function [average_searching_time, average_searching_distance, final_cum_revenue, cum_revenue_PR, cum_revenue_congestion_toll, cum_revenue_parking_pricing] = ...
    b_new_outputs_from_the_matrix(Nns, Ns, Np, Nns_1, Nns_3, Npr, speed, cum_enterthearea, cum_enterthearea_3, cum_enter_pr, decideforparking_3, parking_pricing, enterthearea_1, enterthearea_3, enter_pr, parkingduration_expectation)

a = size(Nns,1);

% we are looking for values below.
% 1. �Total searching time� and �total searching distance�.
% 2. �Total non-searching time by parkers�, and �Total non-searching distance by parkers�.
% 3. �Total non-searching time by through traffic�, and �Total non-searching distance by through traffic�.
% 4. �Total waiting time to enter the area�.
% 5. All average values of the values above.

    
n_state_Nns = zeros(a-1,1);
n_state_Ns = zeros(a-1,1);
n_state_Np = zeros(a-1,1);
n_state_Nns_parkers = zeros(a-1,1);
n_state_Nns_1 = zeros(a-1,1);
n_state_Nns_3 = zeros(a-1,1);
n_state_Npr = zeros(a-1,1);
v = zeros(a-1,1);

for i=1:a-1
    n_state_Nns(i,1) = Nns(i,1);
    n_state_Ns(i,1) = Ns(i,1);
    n_state_Np(i,1) = Np(i,1);
    n_state_Nns_parkers(i,1) = Nns_1(i,1) + Nns_3(i,1);
    n_state_Nns_1(i,1) = Nns_1(i,1);
    n_state_Nns_3(i,1) = Nns_3(i,1);
    n_state_Npr(i,1) = Npr(i,1);

    v(i,1) = speed(i,1);
    t=1/60;
end

total_searching_time=0;
total_searching_distance=0;
total_non_searching_time_parkers=0;
total_non_searching_distance_parkers=0;
% total_non_searching_time_throughtraffic=0;
% total_non_searching_distance_throughtraffic=0;
% total_waiting_time=0;
total_number_of_vehicles_ns_external=0;
total_number_of_vehicles_ns_internal=0;
total_number_of_vehicles_s=0;
total_number_of_vehicles_p=0;
total_number_of_vehicles_pr=0;

total_number = cum_enterthearea(a-1);
total_number_parkers = cum_enterthearea_3(a-1) + cum_enter_pr(a-1);
% total_number_throughtraffic = cum_enterthearea_1(a-1);
 
for i=1:a-1
total_searching_time=total_searching_time+n_state_Ns(i,1)*t*60; % unit is minutes.
total_searching_distance= total_searching_distance + n_state_Ns(i,1)*v(i,1)*t;

% total_non_searching_time_parkers= total_non_searching_time_parkers+ n_state_Nns(i,1)*t*60; % unit is minutes.
total_non_searching_time_parkers= total_non_searching_time_parkers+ n_state_Nns_parkers(i,1)*t*60; % unit is minutes.
% total_non_searching_distance_parkers= total_non_searching_distance_parkers+ n_state_Nns(i,1)*v(i,1)*t;
total_non_searching_distance_parkers= total_non_searching_distance_parkers+ n_state_Nns_parkers(i,1)*v(i,1)*t;

% total_non_searching_time_throughtraffic= total_non_searching_time_throughtraffic+ n_state_Nns_throughtraffic(i,1)*t*60; % unit is minutes.
% total_non_searching_distance_throughtraffic= total_non_searching_distance_throughtraffic+ n_state_Nns_throughtraffic(i,1)*v(i,1)*t;

% total_non_searching_time = total_non_searching_time_parkers+ total_non_searching_time_throughtraffic;
% total_non_searching_distance = total_non_searching_distance_parkers+ total_non_searching_distance_throughtraffic;

total_number_of_vehicles_ns_external = total_number_of_vehicles_ns_external + n_state_Nns_1(i,1);
total_number_of_vehicles_ns_internal = total_number_of_vehicles_ns_internal + n_state_Nns_3(i,1);
total_number_of_vehicles_s = total_number_of_vehicles_s + n_state_Ns(i,1);
total_number_of_vehicles_p = total_number_of_vehicles_p + n_state_Np(i,1);
total_number_of_vehicles_pr = total_number_of_vehicles_pr + n_state_Npr(i,1);

end

average_searching_time =total_searching_time /total_number_parkers; % unit is minutes.
average_searching_distance= total_searching_distance/ total_number_parkers;

average_non_searching_time_parkers= total_non_searching_time_parkers/ total_number_parkers; % unit is minutes.
average_non_searching_distance_parkers= total_non_searching_distance_parkers/total_number_parkers;

total_time = total_searching_time + total_non_searching_time_parkers;
% total_delay = total_time - (618*1.92+2069*3.84);
total_delay = total_time - (618*0.8592+2069*1.7184);
average_total_time = total_time / total_number;
% average_delay = average_total_time - ((618*1.92+2069*3.84)/2687);
average_delay = average_total_time - ((618*0.8592+2069*1.7184)/2687);

total_distance = total_searching_distance + total_non_searching_distance_parkers;
average_total_distance = total_distance / total_number_parkers;

% average_non_searching_time_throughtraffic= total_non_searching_time_throughtraffic/total_number_throughtraffic; % unit is minutes.
% average_non_searching_distance_throughtraffic= total_non_searching_distance_throughtraffic/ total_number_throughtraffic;

% average_non_searching_time = total_non_searching_time/total_number; % unit is minutes.
% average_non_searching_distance = total_non_searching_distance/total_number;

%------------------------------------------------------------------------------------------------

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Total revenue from on-street parking:
% % Idea: Number of vehicles n_s_p * on-street parking fee
% 
% revenue(:,1) = zeros(size(findparking_3(:,1),1) - 1,1);
% cum_revenue(:,1) = zeros(size(findparking_3(:,1),1) - 1,1);
% correct_parking_pricing(:,1) = zeros(size(findparking_3(:,1),1) - 1,1);
% 
% % Get the correct parking pricing value (update only every 5 minutes and
% % rounded to next 0.5 CHF):
% for j = 1:5:size(parking_pricing(:,1),1)
%     
%     correct_parking_pricing(j,1) = round(2*parking_pricing(j,1))/2;
%     if j ~= size(parking_pricing(:,1),1)
%         correct_parking_pricing(j + 1,1) = correct_parking_pricing(j,1);
%         correct_parking_pricing(j + 2,1) = correct_parking_pricing(j,1);
%         correct_parking_pricing(j + 3,1) = correct_parking_pricing(j,1);
%         correct_parking_pricing(j + 4,1) = correct_parking_pricing(j,1);
%     end
% end
%     
% %  get revenue value from corrected parking pricing value for every 5 minutes:   
% for i = 2:size(findparking_3(:,1),1)
%     revenue(i-1,1) = findparking_3(i,1)*correct_parking_pricing(i-1,1);
% 
%     if i ~= 2
%         cum_revenue(i-1,1) = cum_revenue(i-2,1) + revenue(i-1,1);
%     elseif i == 2
%         cum_revenue(i-1,1) = revenue(i-1,1);
%     end
% end
% max_cum_revenue = max(cum_revenue);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Total revenue from parking pricing (Constant on-street parking fee):
% Number of vehicles n_s_p * parking fee (constant):
total_revenue_parking = sum(decideforparking_3(:,1)*parking_pricing(1,1))*parkingduration_expectation/60;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Total revenue from congestion toll:
% Number of vehicles (n_/nse + n_/nsi) * congestion toll:
total_revenue_congestion = sum((enterthearea_1(:,1) + enterthearea_3(:,1))*c16_input_toll);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Total revenue from P+R and PT:
% Number of vehicles n_/PR * P+R fee + PT fee:
total_revenue_PR = sum(enter_pr(:,1)*c21_input_park_ride_price) + sum(enter_pr(:,1)*c27_input_PT_price);

%------------------------------------------------------------------------------------------------
% average_searching_time
% total_searching_time

% average_non_searching_time_parkers
% total_non_searching_time_parkers

% total_searching_distance
% total_non_searching_distance_parkers

% average_searching_distance
% average_non_searching_distance_parkers

% average_delay
% total_delay

%------------------------------------------------------------------------------------------------
avg_searching_time = round(average_searching_time,3)
tot_searching_time = round(total_searching_time,3)

avg_non_searching_time_parkers = round(average_non_searching_time_parkers,3)
tot_non_searching_time_parkers = round(total_non_searching_time_parkers,3)

avg_delay = round(average_delay,3)
tot_delay = round(total_delay,3)

peak_queue = max(n_state_Ns)

avg_number_of_vehicles_ns_external = round(total_number_of_vehicles_ns_external/1440,3)
avg_number_of_vehicles_ns_internal = round(total_number_of_vehicles_ns_internal/1440,3)
avg_number_of_vehicles_s = round(total_number_of_vehicles_s/1440,3)
avg_number_of_vehicles_p = round(total_number_of_vehicles_p/1440,3)
avg_number_of_vehicles_pr = round(total_number_of_vehicles_pr/1440,3)

% avg_total_time = round(average_total_time,3)
% tot_time = round(total_time,3)
% tot_time_VOT = round(total_time * 0.425,3)

% avg_total_distance = round(average_total_distance,3)
% tot_distance = round(total_distance,3)

cum_revenue_PR = round(total_revenue_PR,0)
cum_revenue_congestion_toll = round(total_revenue_congestion,0)
cum_revenue_parking_pricing = round(total_revenue_parking,0)
final_cum_revenue = cum_revenue_parking_pricing + cum_revenue_congestion_toll + cum_revenue_PR

%------------------------------------------------------------------------------------------------

% avg_total_time_percentage = avg_total_time/9.408 * 100
% tot_time_percentage = tot_time/19465.681 * 100
% tot_time_VOT_percentage = tot_time_VOT/8272.914 * 100
% 
% avg_total_distance_percentage = avg_total_distance/1.96 * 100
% tot_distance_percentage = tot_distance/4055.35 * 100
% 
% cum_revenue_percentage = round(final_cum_revenue/12712 * 100,1)

end
