function trace = FnProcessData(xout, num_var, num_ud)

    chpoints = [];
    for i = 1:num_var
        chpoints = union(chpoints, changepoint(xout(:,i)));
    end
    
    % remove redundant chpoints
    dif_chpoints = diff(chpoints);
    ids = find(dif_chpoints==1);
    chpoints(ids,:) = [];
    xout_reduced= xout(:, 1:num_var);

    trace.x = xout_reduced;
    trace.chpoints = chpoints;
    trace.ud = [];
    trace.labels_num = []; 
    trace.labels_trace = [];  
end

function points_num = changepoint(values)
  valdif1 = [values(1); diff(values)];
  valdif2 =  diff(valdif1);
  indx = find(abs(valdif2) >=0.03);
  points_num = union(1,[indx; length(values)]);
end