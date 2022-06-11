module.exports = cds.service.impl(async function(){

    const {  EmployeeSet, POs  } = this.entities;

    this.before('UPDATE', EmployeeSet, (req, res) => {
            
            if(parseFloat(req.data.salaryAmount) >= 100000){
                req.error(500, "Salary must be below 1 mn");
            }

    });

    this.on('boost', async req => {
        try {
            const ID = req.params[0];
            console.log( ID);
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000},
                NOTE: "Boosted!!"
            }).where(ID);
            return "Boost was successful";
            
        } catch (error) {
            return "error" + error.toString();
        }

    });

    this.on('largestOrder', async(req, res) => {
        try {
            // const ID = req.params[0];
            // console.log("Your purchase Order: " + ID + "Will be boosted");
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);
            return reply;
            
        } catch (error) {
            return "error" + error.toString();
        }

    });

});