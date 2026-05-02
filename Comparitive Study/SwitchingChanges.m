%% Changes in Switching states in PI
clc;
a = 0;b = 0;c = 0;
Sa = double(Sa);
Sb = double(Sb);
Sc = double(Sc);

changes = 0;

for i = 1:length(Sa)

    changes = changes + ((a ~= Sa(i)) + (b ~= Sb(i)) + (c ~= Sc(i))) * 2;
    a = Sa(i);
    b = Sb(i);
    c = Sc(i);

end

disp(changes)

%% Changes in Switching States in MPC 

clc;
a = 0;b = 0;c = 0;

changes_MPC = 0;

for i = 1:length(Changes_MPC)

    changes_MPC = changes_MPC + Changes_MPC(i);

end

disp(changes_MPC)

%% Changes in Switching States in Switching MPC


clc;
a = 0;b = 0;c = 0;

changes_MPC_opt = 0;

for i = 1:length(Changes_MPC_Switching)

    changes_MPC_opt = changes_MPC_opt + Changes_MPC_Switching(i);
end

disp(changes_MPC_opt)

%% Changes in Switching States in ANN


clc;
a = 0;b = 0;c = 0;

changes_ANN = 0;

for i = 1:length(Sa)

    changes_ANN = changes_ANN + ((a ~= Sa_ANN(i)) + (b ~= Sb_ANN(i)) + (c ~= Sc_ANN(i))) * 2;
    a = Sa_ANN(i);
    b = Sb_ANN(i);
    c = Sc_ANN(i);

end

disp(changes_ANN)