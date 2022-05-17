using { capm.db.CreateCDSViews } from '../db/CreateCDSViews';
using { capm.db.master, capm.db.transaction } from '../db/datamodel';


service CreateCDSViewService@(path: '/CreateCDSViewService') {

    entity POData as projection on  CreateCDSViews.POWorklist;
    entity ProductOrders as projection on CreateCDSViews.ProductViewSub;
    entity ProductAggregation as projection on CreateCDSViews.CProductValuesView;

}

