@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for SalesOrder Items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SO_ITEMS
  as select from zdt_so_items
  association to parent ZI_SO_HDR as _hdr on $projection.Customerid = _hdr.Customerid
{
  key customerid         as Customerid,
  key itemno             as Itemno,
      material           as Material,
      @Semantics.amount.currencyCode : 'currency'
      unitprice          as Unitprice,
      @Semantics.quantity.unitOfMeasure: 'units'
      quantity           as Quantity,
      itemcategory       as Itemcategory,
      shippingmode       as Shippingmode,
      discountpercent    as Discountpercent,
      taxdiscountpercent as Taxdiscountpercent,
      deliveryplant      as Deliveryplant,
      storagelocation    as Storagelocation,
      @Semantics.amount.currencyCode : 'currency'
      netprice           as Netprice,
      @Semantics.amount.currencyCode : 'currency'
      netvalue           as Netvalue,
      @Semantics.amount.currencyCode : 'currency'
      grossvalue         as Grossvalue,
      priceelements      as Priceelements,
      currency           as Currency,
      units              as Units,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_on         as CreatedOn,
      @Semantics.user.lastChangedBy: true
      modified_by        as ModifiedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      modified_on        as ModifiedOn,
      _hdr
}
