%% Section - a

format long
% Create Accounts
accounts = 100 + (100000-100) * rand(50000,1);
% Sets up 50,000 accounts with balances between $100 and $100000.
accounts = floor(100 * accounts)/100;
% Deletes fractions of a cent from initial balances.


illegal_acc_bal = 0;
days = 0;
r = (5/(365*100));

amt_added_each_day = zeros(1, 1);

while(illegal_acc_bal < 1e6)
    accounts = accounts*(1+r);
    temp = accounts;
    accounts = floor(100 * accounts)/100;
    illegal_acc_bal = illegal_acc_bal*(1+r) + sum(temp - accounts);
    days = days + 1;
    amt_added_each_day(days) = sum(temp - accounts);
end

days
plot(amt_added_each_day);