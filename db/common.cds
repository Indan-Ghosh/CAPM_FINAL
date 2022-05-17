namespace reuse.common;

using
{
    sap,
    temporal,
    Currency,
    managed
}
from '@sap/cds/common';

aspect Amount
{
    CURRENCY_CODE : String(4);
    GROSS_AMOUNT : Decimal;
    NET_AMOUNT : Decimal;
    TAX_AMOUNT : Decimal;
}

type Gender : String enum
{
    male = 'M';
    female = 'F';
    noBinary = 'N';
    noDisclosure = 'D';
    selfDescribe = 'S';
}

@Semantics.amount.CurrencyCode : 'CURRENCY_CODE'
@sap.unit : 'CURRENCY_CODE'
type AmountT : Decimal(15,2);

@assert.format : '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'
type email : String(30);

@assert.format : '((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))'
type phoneNumber : String(30);
