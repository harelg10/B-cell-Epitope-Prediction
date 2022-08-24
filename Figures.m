function [] = Figures(b,a,s,h,total,name)
%FIGURES create a window with figure for each parameter
    figure('Name','Epitope Prediction','NumberTitle','off','WindowState','maximized');
    
    subplot(5,1,1)
    plot(b);
    title("Beta-turn")
    xlabel("Position")
    ylabel("Score")
    
    subplot(5,1,2)
    plot(a);
    title("Antigenicity")
    xlabel("Position")
    ylabel("Score")
    
    subplot(5,1,3)
    plot(s);
    title("Surface accessabilty")
    xlabel("Position")
    ylabel("Score")
    
    subplot(5,1,4)
    plot(h);
    title("Hydropathy")
    xlabel("Position")
    ylabel("Score")
    
    subplot(5,1,5)
    
    % Display the area above the line first so it will be in the background.
    t_positive = (total + abs(total))/2;
    area(1:length(total), t_positive,'FaceColor','#4DBEEE');
    alpha(.4)
    
    hold on
    plot(total,'r')
    yline(mean(total))
    title("Total Score")
    xlabel("Position")
    ylabel("Score")
    sgtitle(name+" Analysis");
end

