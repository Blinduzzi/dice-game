function [n,win] = playdice(agent,env,simopts,d)
% Not the same as in the course (Jose A Lazaro version)
simout = sim(agent,env,simopts);
n = zeros([simopts.NumSimulations,1]);
win = zeros([simopts.NumSimulations,1]);

for i = 1:simopts.NumSimulations
    experience = simout(i);
    disp('Target(1)  Die(1)      Sides(6)        Roll(1)')
    Target = squeeze(experience.Observation.obs1.Data);
    sizeTarget=size(Target,1);
    Die = [squeeze(experience.Action.act1.Data); 0];
    Sides = d(Die(1),:);
    for ii = 2:size(Die,1)-1
        Sides = [Sides; d(Die(ii),:)];
    end
    Sides = [Sides; zeros(1,6)];
    %     Reward = [squeeze(experience.Reward.Data); 0];
    IsDone = [squeeze(experience.IsDone.Data); 0];
    Roll = zeros(size(Target,1),1);
    for i3 = 1:sizeTarget-1
        Roll1 = Target(i3)-Target(i3+1);
        if Roll1 > 0
            Roll(i3) = Roll1;
        else
            Roll(i3) = Target(i3)+Target(i3+1);
        end
    end
%     M = [Target,Die,Sides,Roll];
    blankCol=blanks(sizeTarget)';
    blankCol6= [blankCol blankCol blankCol blankCol blankCol blankCol];
    Mstr=[blankCol6, num2str(Target),blankCol6,num2str(Die),blankCol6,...
        num2str(Sides),blankCol6,num2str(Roll)];
    %     disp(num2str(M))
    disp(Mstr)
    
    if IsDone(end-1) == 1
        message = ['Target reached in ' num2str(sizeTarget-1) ' steps'];
    disp (message)
        win(i) = 1;
        n(i) = sizeTarget-1;
    end
    %     T = table(Target,Die,Roll,Reward,IsDone);
    %     T.Properties.VariableNames = {'Target', 'Die','Roll','Reward','IsDone'}
end
end