using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI.SelectionFields : [
        PO_ID,
        GROSS_AMOUNT,
        LIFECYCLE_STATUS,
        CURRENCY_CODE
    ]
);

annotate service.POs with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
             Value : PO_ID,
        },
         {
            $Type : 'UI.DataField',
            Label : '{i18n>GROSS_AMOUNT}',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Boost',
            Action : 'CatalogService.boost',
            Inline : true,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Currency Code',
            Value : CURRENCY_CODE,
        },
       
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Country',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
            Criticality: Criticality,
            CriticalityRepresentation: #WithIcon
        },
        {
            $Type : 'UI.DataField',
            Label : 'Note',
            Value : NOTE,
        },
    ],
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : '{i18n>PurchaseOrder}',
        TypeNamePlural : '{i18n>PurchaseOrders}',
        Title: {
            $Type : 'UI.DataField',
            Label: '{i18n>PO_ID}',
            Value: PO_ID
        },
        Description: {
            $Type : 'UI.DataField',
           Label: '{i18n>DESC}',
           Value: PARTNER_GUID.COMPANY_NAME
        },
        ImageUrl: 'https://brandlogos.net/wp-content/uploads/2016/11/sap-logo-preview.png',
    },
);
annotate service.POs with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Purchase Order ID',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Business Partner ID',
                Value : PARTNER_GUID.BP_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Company Name',
                Value : PARTNER_GUID.COMPANY_NAME,
            },            
            {
                $Type : 'UI.DataField',
                Label : 'PARTNER_GUID_NODE_KEY',
                Value : PARTNER_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'GROSS_AMOUNT',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CURRENCY_CODE',
                Value : CURRENCY_CODE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NET_AMOUNT',
                Value : NET_AMOUNT,
            },   
            {
                $Type : 'UI.DataField',
                Label : 'LIFECYCLE_STATUS',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'OVERALL_STATUS',
                Value : OVERALL_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NOTE',
                Value : NOTE,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'PO Line Items',
            Target : 'Items/@UI.LineItem',
        }
    ]
);

annotate CatalogService.poitems with @(
    UI: {
        LineItem :[
              {
               $Type: 'UI.DataField',
               Label: 'Item Position',
               Value: PO_ITEM_POS,
               },
               
               {
               $Type: 'UI.DataField',
               Label: 'Product Guid',
               Value: PRODUCT_GUID_NODE_KEY,
               },
               {
                   $Type : 'UI.DataField',
                   Label: 'Product ID',
                   Value : PRODUCT_GUID.PRODUCT_ID,
               },
               {
                   $Type : 'UI.DataField',
                   Label: '{i18n>GROSS_AMOUNT}',
                   Value : GROSS_AMOUNT,
               },
               {
                   $Type : 'UI.DataField',
                   Label: 'Net Amount',
                   Value : NET_AMOUNT,
               },
               {
                   $Type : 'UI.DataField',
                   Label: 'Tax Amount',
                   Value : TAX_AMOUNT,
               },
               {
                   $Type : 'UI.DataField',
                   Label: 'Currency Code',
                   Value : CURRENCY_CODE,
               },
    ],
    HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'PO Item',
        TypeNamePlural : 'PO Items',
        Title: {
            $Type : 'UI.DataField',
            Label: 'Item Guid',
            Value: NODE_KEY
        },
        Description: {
            $Type : 'UI.DataField',
           Label: 'Item Position',
           Value: PO_ITEM_POS
        }
    },
    }
);

