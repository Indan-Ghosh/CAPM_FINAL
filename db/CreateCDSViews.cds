namespace capm.db;

using { capm.db.master,capm.db.transaction  } from './datamodel';

context CreateCDSViews {

    define view ![POWorklist] as
    select from transaction.purchaseorder {
        key PO_ID as![PurchaseOrderID],
            PARTNER_GUID.BP_ID as![PartnerId],
            PARTNER_GUID.COMPANY_NAME as![CompanyName],
            GROSS_AMOUNT as![POHGrossAmount],
            CURRENCY_CODE as![POCurrencyCode],
            LIFECYCLE_STATUS as![POStatus],
        key Items.PO_ITEM_POS as![ItemPosition],
            Items.PRODUCT_GUID.PRODUCT_ID as![ProductId],
            Items.PRODUCT_GUID.DESCRIPTION as![ProductName],
            PARTNER_GUID.ADDRESS_GUID.CITY as![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country],
            Items.GROSS_AMOUNT as![GrossAmount],
            Items.NET_AMOUNT as![NetAmount],
            Items.TAX_AMOUNT as![TaxAmount],
            Items.CURRENCY_CODE as![CurrencyCode]


    };

    define view ProductValueHelp as 
    
    select from master.product{
        @EndUserText.label:[
            {
                language: 'EN',
                text: 'Product ID'
            },
            {
               language: 'DE',
                text: 'Prodekt ID' 
            }
        ] PRODUCT_ID as ![ProductId],
        @EndUserText.label:[
            {
                language: 'EN',
                text: 'Product Description'
            },
            {
               language: 'DE',
                text: 'Prodekt Description' 
            }
        ] DESCRIPTION as ![Description],

    };

    define view![ItemVIew] as
    select from transaction.poitems{
        PARENT_KEY.PARTNER_GUID.NODE_KEY as![Partner],
        PRODUCT_GUID.NODE_KEY as![ProductId],
        CURRENCY_CODE as![CurrencyCode],
        GROSS_AMOUNT as![GrossAmount],
        NET_AMOUNT as![NetAmount],
        TAX_AMOUNT as![TaxAmount],
        PARENT_KEY.OVERALL_STATUS as![POStatus]
    };

    define view ProductViewSub as
    select from master.product as prod{
        PRODUCT_ID as ![ProductId],
        texts.DESCRIPTION as![Description],
        (
            Select from transaction.poitems as a{
                sum(a.GROSS_AMOUNT) as PO_SUM
            } where a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
        ) as PO_SUM: Decimal(10, 2)
    };

    define view ProductView as select from master.product mixin{
        PO_ORDER: Association[*] to ItemVIew on PO_ORDER.ProductId = $projection.ProductId

    } into {
        NODE_KEY as ![ProductId],
        DESCRIPTION,
        CATEGORY as![Category],
        PRICE as![Price],
        TYPE_CODE as![TypeCode],
        SUPPLIER_GUID.BP_ID as![BPId],
        SUPPLIER_GUID.COMPANY_NAME as![CompanyName],
        SUPPLIER_GUID.ADDRESS_GUID.CITY as![City],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
        //Exposed Association using mixin keyword which will not show PO data
        //unless association is triggered. PO_ORDER which is association of ItemVIew is loosely coupled with
        // ProductView. ProductView is tighly coupled with Product table. 
        //View of View concept, $Project Concept
        PO_ORDER
    };

    define view CProductValuesView as select from ProductView{
        ProductId,
        Country,
        PO_ORDER.CurrencyCode as![CurrencyCode],       
        sum(PO_ORDER.GrossAmount) as ![POGrossAmount]: Decimal(10, 2)
    }
    group by ProductId, Country, PO_ORDER.CurrencyCode
    
}


