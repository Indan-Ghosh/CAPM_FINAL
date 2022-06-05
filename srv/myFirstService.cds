using { capm.db.master, capm.db.transaction } from '../db/datamodel';

service service1 {

    function myfunction(msg: String) returns String;

@readonly
entity ReadEmployeeSrv as projection on master.employees;
@insertonly
entity InsertEmployeeSrv as projection on master.employees;
@updateonly
entity UpdateEmployeeSrv as projection on master.employees;
@deleteonly
entity DeleteEmployeeSrv as projection on master.employees;

}