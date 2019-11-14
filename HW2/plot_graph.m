%this function plots the graph

function plot_graph(NL, M, color, axis_clearance)

x = [M(:,1) M(:,3)];
y = [M(:,2) M(:,4)];
plot(x',y', color, 'LineWidth', 2.5);
hold on
axis([min(NL(:,1)) - axis_clearance, max(NL(:,1)) + axis_clearance, min(NL(:,2)) - axis_clearance, max(NL(:,2)) + axis_clearance]);

end