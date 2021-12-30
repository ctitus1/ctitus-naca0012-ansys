clear;clc;

% path = "C:\Users\titus\Documents\Fluent\CHAMPS\naca0012_hi_res_v2\re_23000\aoa_1\v1\";
root_path = "C:\Users\titus\Documents\Fluent\CHAMPS\final_naca0012_hd_partial\";
re_nums = ["23000","33000","48000"];
re_idx = 0;
a_nums = ["1","2","3","4","5"];
a_idx = 0;

for re = re_nums
    re_idx = re_idx + 1;
    for alpha = a_nums
        a_idx = a_idx + 1;

path = root_path+re+"\"+alpha+"\";

cl_all = importfile(path+"cl-rfile.out");
cd_all = importfile(path+"cd-rfile.out");
xforce_all = importfile(path+"x-force-rfile.out");
yforce_all = importfile(path+"y-force-rfile.out");

last_n = 500;
cl = tail(cl_all,last_n);
cd = tail(cd_all,last_n);
xforce = tail(xforce_all,last_n);
yforce = tail(yforce_all,last_n);

fig_idx = re_idx*100+a_idx*10;

figure(fig_idx+1)
clf
X = cl.flowtime;
Y = cl.value;
plot(X,Y)
hold on
yline(mean(Y))
title("cl vs flow time (Re = "+re+", alpha = "+alpha+")")
legend(["cl","average cl = "+string(mean(Y))])

figure(fig_idx+2)
clf
X = cd.flowtime;
Y = cd.value;
plot(X,Y)
hold on
yline(mean(Y))
title("cd vs flow time (Re = "+re+", alpha = "+alpha+")")
legend(["cd","average cd = "+string(mean(Y))])

figure(fig_idx+3)
clf
X = xforce.flowtime;
Y = xforce.value;
plot(X,Y)
hold on
yline(mean(Y))
title("xforce vs flow time (Re = "+re+", alpha = "+alpha+")")
legend(["xforce","average xforce = "+string(mean(Y))])

figure(fig_idx+4)
clf
X = yforce.flowtime;
Y = yforce.value;
plot(X,Y)
hold on
yline(mean(Y))
title("yforce vs flow time (Re = "+re+", alpha = "+alpha+")")
legend(["yforce","average yforce = "+string(mean(Y))])

    end
end

function file = importfile(filename)
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["timestep", "value", "flowtime"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
file = readtable(filename, opts);

end