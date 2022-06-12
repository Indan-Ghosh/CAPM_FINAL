using { capm.db.master, capm.db.transaction } from './datamodel';


annotate transaction.purchaseorder with {

        PO_ID @title : '{i18n>po_id}';
        GROSS_AMOUNT @title: '{i18n>GROSS_AMOUNT}';
        NOTE @title : '{i18n>Note}';
        LIFECYCLE_STATUS @title : '{i18n>lifecycle}'
};
