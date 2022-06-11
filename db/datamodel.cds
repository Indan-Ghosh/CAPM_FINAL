namespace capm.db;

using
{
    cuid,
    temporal,
    managed
}
from '@sap/cds/common';

using { reuse.common } from './common';

using { Currency } from '@sap/cds/common';

type guid : String(32);



context master
{
    entity businesspartner
    {
        key NODE_KEY : db.guid
            @title : '{i18n>bp_key}';
        BP_ROLE : String(2)
            @title : '{i18n>bp_role}';
        EMAIL_ADDRESS : String(64);
        PHONE_NUMBER : String(14);
        FAX_NUMBER : String(14);
        WEB_ADDRESS : String(64);
        BP_ID : String(16);
        COMPANY_NAME : String(80);
        ADDRESS_GUID : Association to one address;
    }

    annotate businesspartner with {
        BP_ROLE @(title: '{i18n>Partner_Type}',
        description: '{i18n>Partner_Type}');
        BP_ID @(
            title: '{i18n>bp_id}',
            description: '{i18n>bp_id}');
        COMPANY_NAME @(
            title: '{i18n>Comp_name}',
            description: '{i18n>Comp_name}');
        EMAIL_ADDRESS @(
            title: '{i18n>Email}',
            description: '{i18n>Email}'
        );        
    };
    

    entity address
    {
        key NODE_KEY : db.guid;
        CITY : String(64);
        POSTAL_CODE : String(60);
        STREET : String(120);
        BUILDING : String(128);
        COUNTRY : String(44);
        ADDRESS_TYPE : String(20);
        VAL_START_DATE : Date;
        VAL_END_DATE : Date;
        LATITUDE : Decimal;
        LONGITUDE : Decimal;
        businesspartner : Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    entity product
    {
        key NODE_KEY : db.guid;
        PRODUCT_ID : String(28);
        TYPE_CODE : String(2);
        CATEGORY : String(32);
        SUPPLIER_GUID : Association to one businesspartner;
        TAX_TARIF_CODE : Integer;
        MEASURE_UNIT : String(2);
        WEIGHT_MEASURE : Decimal;
        WEIGHT_UNIT : String(2);
        CURRENCY_CODE : String(4);
        PRICE : Decimal;
        WIDTH : Decimal;
        DEPTH : Decimal;
        HEIGHT : Decimal;
        DIM_UNIT : String(2);
        DESCRIPTION : localized String(255);
    }

    entity employees : cuid
    {
        nameFirst : String(40);
        nameMiddle : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        sex : common.Gender;
        language : String(1);
        phoneNumber : common.phoneNumber;
        email : common.email;
        loginName : String(12);
        Currency : Currency;
        salaryAmount : common.AmountT;
        accountNumber : String(16);
        bankId : String(20);
        bankName : String(64);
    }
}

context transaction
{
    entity purchaseorder : common.Amount
    {
        key NODE_KEY : db.guid;
        PO_ID : String(24);
        PARTNER_GUID : Association to one master.businesspartner;
        LIFECYCLE_STATUS : String(1);
        OVERALL_STATUS : String(1);
        Items : Association to many poitems on Items.PARENT_KEY = $self;
        NOTE: String(256);
    }

    entity poitems : common.Amount
    {
        key NODE_KEY : db.guid;
        PO_ITEM_POS : Integer;
        PRODUCT_GUID : Association to one master.product;
        PARENT_KEY : Association to one purchaseorder;
    }
}

// entity test
// {
//     key node_key : guid;
//     firstname : String(40);
//     lastname : String(40);
//     age : Integer;
// }

// annotate test with {
//     firstname @title : 'First Name';
// };

