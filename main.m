clc; 
clear;

Ms = [100 150 200];

prompt = "Choose Value for M =  ";
'M = 100'
'M = 150'
'M = 200'
n = input(prompt)
p=n;
M = n
playerscost=[];
playerscost(1:p,1)=0;

% Path SAD[1] = SA[1] {unique} + AD[2]
% Path SD[2] = SD[3]
% Path SABD[3] = SA[4] {unique} + AB[5] + BD[6] {unique}
% Path SBD[4] = SB[7] + BD[8] {unique}

% SA[1]
% AD[2]
% SD[3]
% SA[4]
% AB[5]
% BD[6]
% SB[7]
% BD[8]

breaker=[]
breaker(1:p,1)=0;

memory(1:p,1)=1;
memory(1:p,2)=2;
sum(memory(:) == 1);
congestion=[];
congestion(1:8,1)=0;
path=[];
congestion(1,1)=sum(memory(:) == 1);
congestion(2,1)=sum(memory(:) == 2);
congestion(3,1)=sum(memory(:) == 3);
congestion(4,1)=sum(memory(:) == 4);
congestion(5,1)=sum(memory(:) == 5);
congestion(6,1)=sum(memory(:) == 6);
congestion(7,1)=sum(memory(:) == 7);
congestion(8,1)=sum(memory(:) == 8);
path(1,1)=(congestion(1,1)+congestion(2,1))/2;
path(2,1)=congestion(3,1);
path(3,1)=(congestion(4,1)+congestion(5,1)+congestion(6,1))/3;
path(4,1)=(congestion(7,1)+congestion(8,1))/2;
for l=1:M
    if memory(l,1)==1
        playerscost(l,1)=(((congestion(1,1))/10) + 15 + 10 + ((congestion(1,1))/20));
    elseif memory(l,1)==3
        playerscost(l,1)=15+(congestion(3,1)/5)
    elseif memory(l,1)==4
        playerscost(l,1)=(congestion(4,1)/10) + 15 + 11 + 12;
    elseif memory(l,1)==7
        playerscost(l,1)=15+(congestion(7,1)/8)+12;
    end
end
m=p;
k=0;
stop=1000000;
exitloop = false;
flag=0;
T=[];
for i=1:100
    for p=1:M
        congestion(1,1)=sum(memory(:) == 1);
        congestion(2,1)=sum(memory(:) == 2);
        congestion(3,1)=sum(memory(:) == 3);
        congestion(4,1)=sum(memory(:) == 4);
        congestion(5,1)=sum(memory(:) == 5);
        congestion(6,1)=sum(memory(:) == 6);
        congestion(7,1)=sum(memory(:) == 7);
        congestion(8,1)=sum(memory(:) == 8);
        path(1,1)=congestion(1,1);
        path(2,1)=congestion(3,1);
        path(3,1)=congestion(4,1);
        path(4,1)=congestion(7,1);
        for l=1:M
            if memory(l,1)==1
                playerscost(l,1)=(((congestion(1,1))/10) + 15 + 10 + ((congestion(1,1))/20));
            elseif memory(l,1)==3
                playerscost(l,1)=15+(congestion(3,1)/5);
            elseif memory(l,1)==4
                playerscost(l,1)=(congestion(4,1)/10) + 15 + 11 + 12;
            elseif memory(l,1)==7
                playerscost(l,1)=15+(congestion(7,1)/8)+12;
            end
        end
        T(k+1,1)=sum(playerscost);
%         if (((15+((congestion(3,1)+1)/5)) < 1:playerscost(1:M,1) & memory(1:M,1) ~= 3) & (((((congestion(1,1)+1)/10) + 15 + 10 + ((congestion(1,1)+1)/20))) < 1:playerscost(1:M,1) & memory(1:M,1) ~= 1) & ((15+((congestion(3,1)+1)/5)) < 1:playerscost(1:M,1) & memory(1:M,1) ~= 3) & ((((congestion(4,1)+1)/10) + 15 + 11 + 12) < 1:playerscost(1:M,1) & memory(1:M,1) ~= 4) & ((15+((congestion(7,1)+1)/8)+12) < 1:playerscost(1:M,1) & memory(1:M,1) ~= 7)) == 0
%             'that it'
%             return
%         end        
        breaker=(((15+((congestion(3,1)+1)/5)) < playerscost(1:M,1) & memory(1:M,1) ~= 3) | (((((congestion(1,1)+1)/10) + 15 + 10 + ((congestion(1,1)+1)/20))) < playerscost(1:M,1) & memory(1:M,1) ~= 1) | ((15+((congestion(3,1)+1)/5)) < playerscost(1:M,1) & memory(1:M,1) ~= 3) | ((((congestion(4,1)+1)/10) + 15 + 11 + 12) < playerscost(1:M,1) & memory(1:M,1) ~= 4) | ((15+((congestion(7,1)+1)/8)+12) < playerscost(1:M,1) & memory(1:M,1) ~= 7)) == 0;
        if all(breaker(:) > 0) == 1
            flag=1;
        end
        if(flag==1)
            break
        end
        k=k+1

        if ((((((congestion(1,1)+1)/10) + 15 + 10 + ((congestion(1,1)+1)/20))) < playerscost(p,1)) || ((15+((congestion(3,1)+1)/5)) < playerscost(p,1)) || ((((congestion(4,1)+1)/10) + 15 + 11 + 12) < playerscost(p,1)) || ((15+((congestion(7,1)+1)/8)+12) < playerscost(p,1))) == 0
            'no better option';
        end
        if ((((congestion(1,1)+1)/10) + 15 + 10 + ((congestion(1,1)+1)/20))) < playerscost(p,1) && memory(p,1) ~= 1
            memory(p,1)=1;
            memory(p,2)=2;
            'found better option in path 1';
        end
        if (15+((congestion(3,1)+1)/5)) < playerscost(p,1) && memory(p,1) ~= 3
            memory(p,1)=3;
            'found better option in path 2';
        end
        if (((congestion(4,1)+1)/10) + 15 + 11 + 12) < playerscost(p,1) && memory(p,1) ~= 4
            memory(p,1)=4;
            memory(p,2)=5;
            memory(p,3)=6;
            'found better option in path 3';
        end
        if (15+((congestion(7,1)+1)/8)+12) < playerscost(p,1) && memory(p,1) ~= 7
            memory(p,1)=7;
            memory(p,2)=8;
            'found better option in path 4';
        end
    end
    if(flag==1)
         break
    end
end
plot(1:k+1,T)
xlabel('Number of iterations')
ylabel('Potential function')