const Employee = artifacts.require('Employee');
const Account = artifacts.require('Account');

contract("Account", accounts => {
    it('Reward size should increase', async () => {
            
            let employeeAccount1 = await Employee.new("12-11-13");
    
            await employeeAccount1.createnNewAccount();
            const accountAddress = await employeeAccount1.getArrayofAccounts.call();
            const accountInstance = await Account.at(accountAddress[0]);
    
            const currentReward = accountInstance.RewardSize;
            accountInstance.increaseRewardSize(100);
            const newRewardSize = accountInstance.RewardSize;
    
            assert.Equal(currentReward, newRewardSize, 'Reward size not increased ')
    
        });
    it('Should Decrease reward size' , async () =>{
        let employeeAccount1 = await Employee.new("12-13-14");
        
        await employeeAccount1.createnNewAccount();
        const accountAddress = await employeeAccount1.getArrayofAccounts.call();
        const accountInstance = await Account.at(accountAddress[0]);

        const currentReward = accountInstance.RewardSize;
        accountInstance.decreaseRewardSize(100);
        const newRewardSize = AccountInstance.RewardSize;

        assert.Equal(currentReward, newRewardSize, 'Reward size no decremented')
        });

        it('Should increase PayoutFrequency' , async () =>{
            let employeeAccount1 = await Employee.new("12-13-14");
            
            await employeeAccount1.createnNewAccount();
            const accountAddress = await employeeAccount1.getArrayofAccounts.call();
            const accountInstance = await Account.at(accountAddress[0]);
    
            const currentFrequency = accountInstance.PayoutFrequency;
            accountInstance.increasePayoutFrequency(100);
            const newPayoutFrequency = AccountInstance.PayoutFrequency;
    
            assert.Equal(currentFrequency, newPayoutFrequency, 'PayoutFrequency not increased')
        });

            it('Should decrease PayoutFrequency' , async () =>{
                let employeeAccount1 = await Employee.new("12-13-14");
                
                await employeeAccount1.createnNewAccount();
                const accountAddress = await employeeAccount1.getArrayofAccounts.call();
                const accountInstance = await Account.at(accountAddress[0]);
        
                const currentFrequency = accountInstance.PayoutFrequency;
                accountInstance.decreasePayoutFrequency(100);
                const newPayoutFrequency = AccountInstance.PayoutFrequency;
        
                assert.Equal(currentFrequency, newPayoutFrequency, 'PayoutFrequency not decreased')
            });
})
