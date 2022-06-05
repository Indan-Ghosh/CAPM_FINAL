const cds = require("@sap/cds");
const { employees }= cds.entities("capm.db.master");

const myServiceDemo = function (srv) {
    srv.on('myfunction', (req, res) => {
        return "Hello " + req.data.msg;
    });

    srv.on("READ","ReadEmployeeSrv", async(req,res) => {

        var results = [];

        // results.push({
        //     "ID": "02BD2137-0890-1EEA-A6C2-BB55C19799FB",
        //     "nameFirst": "Sultan",
        //     "nameMiddle": "Chicha",
        // });

        // The await operator is used to wait for a Promise . 
        // It can only be used inside an async function within regular JavaScript code; 
        // however it can be used on its own with JavaScript modules.

        // async makes a function return a Promise

        // await makes a function wait for a Promise
        // CDS query language - Select * from DB   
        // results = await cds.tx(req).run(SELECT.from(employees).limit(3));

        // CDS QUery Language with Where condition
        // results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst": "Sally"}));

        // CDS Query Language with /Entity/Key details
        // passing the key values to get the data
        var whereCondition = req.data;
        if (whereCondition.hasOwnProperty("ID")) {
            results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
        }else{
            results = await cds.tx(req).run(SELECT.from(employees).limit(1));
        };

        return results; 

    });
    
}

module.exports = myServiceDemo;