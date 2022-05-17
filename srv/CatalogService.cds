
using { capm.db.master, capm.db.transaction } from '../db/datamodel';

service CatalogService@(path:'/CatalogService') {

entity EmployeeSet as projection on master.employees;
entity ProductSet as projection on master.product;
entity BPSet as projection on master.businesspartner;
// entity ProductText as projection on master.prodtext;
entity AddressSet as projection on master.address;

entity POs @(title : '{i18n>poheader}') as projection on transaction.purchaseorder{
    *,
    Items: redirected to poitems
}
    
    entity poitems@(title: '{i18n>poitems}') as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }

}

