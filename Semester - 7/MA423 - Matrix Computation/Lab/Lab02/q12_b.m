%% Section - b
clc;
accounts = 5000 * ones(100000, 1);

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
    amt_added_each_day(days) = temp(1) - accounts(1);
end

days
plot(amt_added_each_day);