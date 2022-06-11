
using { capm.db.master, capm.db.transaction } from '../db/datamodel';

service CatalogService@(path:'/CatalogService') {
@Capabilities : { Insertable,Updatable,Deletable, }
entity EmployeeSet as projection on master.employees;
entity ProductSet as projection on master.product;
@readonly
entity BPSet as projection on master.businesspartner;
// entity ProductText as projection on master.prodtext;
entity AddressSet as projection on master.address;

entity POs @(title : '{i18n>poheader}') as projection on transaction.purchaseorder{
    *,
    round(GROSS_AMOUNT,2) as GROSS_AMOUNT: Decimal(15, 2),
    Items: redirected to poitems
}actions{
    function largestOrder() returns array of POs;
    action boost();
}
    
    entity poitems@(title: '{i18n>poitems}') as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }

}

