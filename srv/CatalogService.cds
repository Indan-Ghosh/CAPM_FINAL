
using { capm.db.master, capm.db.transaction } from '../db/datamodel';

service CatalogService@(path:'/CatalogService') {
@Capabilities : { Insertable,Updatable,Deletable, }
entity EmployeeSet as projection on master.employees;
entity ProductSet as projection on master.product;
@readonly
entity BPSet as projection on master.businesspartner;
// entity ProductText as projection on master.prodtext;
entity AddressSet as projection on master.address;

@odata.draft.enabled
entity POs @(title : '{i18n>poheader}') as projection on transaction.purchaseorder{
    *,
    // round(GROSS_AMOUNT,2) as GROSS_AMOUNT: Decimal(15, 2),
    round(GROSS_AMOUNT,2) as GROSS_AMOUNT: Decimal(15, 2),
    round(NET_AMOUNT,2) as NET_AMOUNT: Decimal(15, 2),
    round(TAX_AMOUNT,2) as TAX_AMOUNT: Decimal(15, 2),

    case LIFECYCLE_STATUS
    when 'N' then 'New'
    when 'D' then 'Delivered'
    when 'B' then 'Blocked'
    end as LIFECYCLE_STATUS: String(20),

    case LIFECYCLE_STATUS
    when 'N' then 2
    when 'B' then 1
    when 'D' then 3
    end as Criticality:Integer,
    
    Items: redirected to poitems
}actions{
    function largestOrder() returns array of POs;
    action boost();
}

annotate POs with {
    GROSS_AMOUNT @title: '{i18n>GROSS_AMOUNT}';
};

//  @odata.draft.enabled   
    entity poitems@(title: '{i18n>poitems}') as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }

}

