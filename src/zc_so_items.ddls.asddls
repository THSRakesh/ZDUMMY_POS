@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for SalesOrder Items'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_SO_ITEMS 
as projection on ZI_SO_ITEMS
{
    key Customerid,
    key Itemno,
    @EndUserText.label: 'Material'
//    @Analytics.q
    Material,
    @EndUserText.label: 'Unit Price'
    @Semantics.amount.currencyCode : 'currency'
    Unitprice,
    @EndUserText.label: 'Quantity'
    @Semantics.quantity.unitOfMeasure: 'units'
    Quantity,
    @EndUserText.label: 'Item Category'
    Itemcategory,
    @EndUserText.label: 'Shipping Mode'
    Shippingmode,
    @EndUserText.label: 'Discount %'
    Discountpercent,
    @EndUserText.label: 'Tax Discount %'
    Taxdiscountpercent,
    @EndUserText.label: 'Delivery Plant'
    Deliveryplant,
    @EndUserText.label: 'Storage Location'
    Storagelocation,
    @EndUserText.label: 'Net Price'
    @Semantics.amount.currencyCode : 'currency'
    Netprice,
    @EndUserText.label: 'Net Value'
    @Semantics.amount.currencyCode : 'currency'
    Netvalue,
    @EndUserText.label: 'Gross Value'
    @Semantics.amount.currencyCode : 'currency'
//    @DefaultAggregation: #SUM
    Grossvalue,
    @EndUserText.label: 'Price Elements'
    Priceelements,
    Currency,
    Units,
    @EndUserText.label: 'Created By'
    CreatedBy,
    @EndUserText.label: 'Created On'
    CreatedOn,
    @EndUserText.label: 'Modified By'
    ModifiedBy,
    @EndUserText.label: 'Modified On'
    ModifiedOn,
    /* Associations */
    _hdr : redirected to parent ZC_SO_HDR
}
