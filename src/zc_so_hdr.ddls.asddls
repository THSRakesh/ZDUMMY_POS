@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for SalesOrder HDR'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SO_HDR 
as projection on ZI_SO_HDR
{
    key Customerid,
    @EndUserText.label: 'Name'
    Customername,
    @EndUserText.label: 'Mobile'
    Mobile,
    @EndUserText.label: 'Email'
    Email,
    @EndUserText.label: 'Address'
    Address,
    @EndUserText.label: 'House No:'
    Houseno,
    @EndUserText.label: 'Street'
    Street,
    @EndUserText.label: 'Country'
    Country,
    @EndUserText.label: 'City'
    City,
    @EndUserText.label: 'Postal Code'
    Postalcode,
    @EndUserText.label: 'Incoterms'
    Incoterms,
    @EndUserText.label: 'Incoterms Location 1'
    Incotermsloc1,
    @EndUserText.label: 'Terms of Payment'
    Termsofpayment,
    @EndUserText.label: 'Payment Method'
    Paymentmethod,
    @EndUserText.label: 'Document Currency'
    Documentcurrency,
    @EndUserText.label: 'Pricing Date'
    Pricingdate,
    @EndUserText.label: 'Price List Type'
    Pricelisttype,
    @EndUserText.label: 'Billing Date'
    Billingdate,
    @EndUserText.label: 'Requested Delivery Date'
    Requesteddeliverydate,
    @EndUserText.label: 'Customer Group'
    Customergroup,
    Creditlimit,
    @EndUserText.label: 'Credit Limit'
    CreditLimitText,
    CreditLimitCriticality,
    @EndUserText.label: 'Sales Organization'
    Salesorganization,
    @EndUserText.label: 'Distribution Channel'
    Distributionchannel,
    @EndUserText.label: 'Division'
    Division,
    @EndUserText.label: 'Sales Office'
    Salesoffice,
    @EndUserText.label: 'Sales Group'
    Salesgroup,
    @EndUserText.label: 'Sales District'
    Salesdistrict,
    @EndUserText.label: 'Note'
    Note,
    @EndUserText.label: 'Total Items'
    Totalitems,
    @EndUserText.label: 'Gross Value'
    @Semantics.amount.currencyCode : 'currency'
    Grossvalue,
    @EndUserText.label: 'Tax'
    @Semantics.amount.currencyCode : 'currency'
    Tax,
    @EndUserText.label: 'Discount %'
    Discountpercent,
    @EndUserText.label: 'Net Value'
    @Semantics.amount.currencyCode : 'currency'
    Netvalue,
    Currency,
    @EndUserText.label: 'Created By'
    CreatedBy,
    @EndUserText.label: 'Created On'
    CreatedOn,
    @EndUserText.label: 'Modified By'
    ModifiedBy,
    @EndUserText.label: 'Modified On'
    ModifiedOn,
    Local_LastChanged,
    @Semantics.imageUrl: true
    CustomerImage,
    /* Associations */
    _items : redirected to composition child ZC_SO_ITEMS,
    _itemChart,
    
    @EndUserText.label: 'Week Days'
    WeekDays
}
