const cds = require("@sap/cds");
const { employees }= cds.entities("capm.db.master");

const myServiceDemo = function (srv) {
//     srv.on('myfunction', (req, res) => {
//         return "Hello " + req.data.msg;
//     });

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
        // results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst": "Susan"}));

        // CDS Query Language with user pass /Entity/Key details
        // passing the key values to get the data
        var whereCondition = req.data;
        if (whereCondition.hasOwnProperty("ID")) {
            results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
        }else{
            results = await cds.tx(req).run(SELECT.from(employees).limit(1));
        };

        return results; 

    });

    function makeid(length) {
        var result           = '';
        var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for ( var i = length; i > 0; --i ) 
          result += characters[Math.floor(Math.random() * charactersLength)];       
        return result;
    }
    
    srv.on("CREATE", "InsertEmployeeSrv", async(req,res) => {
    //   Let is keyword which is used to define the variable whose value cannot be changed within the function
    // CDS.tx and CDS.transaction both are same
    // all DML action like insert, update delete can be done through cds.transaction
    // you can multiple DML action like one insert, two update and one delete and at the end you will commit using CDS.tramsaction
    console.log(req.data);    
    var dataSet = [];
        for (let i = 0; i < req.data.length; i++) {
            
            const element = req.data[i];
            var rString = makeid(32); 
            element.ID = rString;
            dataSet.push(element);
            
        }
        
        let returnData = await cds.transaction(req).run([
            // this is an array where i can do multiple action
            INSERT.into('employees').entries([dataSet])
        ]).then((resolve,reject)=>{
            if (typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "Issue in inserting the data");
            }

        }).catch(err => {
            req.error(500, "there was an error" + err.toString());
        });
       
        return returnData;


    });

    srv.on("UPDATE", "UpdateEmployeeSrv", async(req,res) => {
        let returnData = await cds.transaction(req).run([
            
            UPDATE(employees).set({
                nameFirst: req.data.nameFirst
            }).where({ ID: req.data.ID }),

            UPDATE(employees).set({
                nameLast: req.data.nameLast
            }).where({ ID: req.data.ID }),

            UPDATE(employees).set({
                nameMiddle : req.data.nameMiddle
            }).where({ ID: req.data.ID })
        ]).then( (resolve, reject) =>{

            if (typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "Issue in Updating the data");
            }

        }).catch(err =>{
            req.error(500, "there was an error" + err.toString());
        });
        
        
        return returnData;
    });
    srv.on("DELETE", "DeleteEmployeeSrv", async(req,res) => {
        let returnData = await cds.transaction(req).run([
            
            DELETE.from(employees).where( req.data)

            
        ]).then( (resolve, reject) =>{

            if (typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "Issue in Deleting the data");
            }

        }).catch(err =>{
            req.error(500, "there was an error" + err.toString());
        });
        
        
        return returnData;
    });



}

module.exports = myServiceDemo;