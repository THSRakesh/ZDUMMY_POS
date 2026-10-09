@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for SalesOrder HDR'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SO_HDR
  as select from zdt_so_hdr
  
  composition [0..*] of ZI_SO_ITEMS as _items
  
  association [0..*] to ZC_SO_ITEMS_CHART as _itemChart
    on $projection.Customerid = _itemChart.Customerid
{
  key customerid            as Customerid,
      customername          as Customername,
      mobile                as Mobile,
      email                 as Email,
      address               as Address,
      houseno               as Houseno,
      street                as Street,
      country               as Country,
      city                  as City,
      postalcode            as Postalcode,
      incoterms             as Incoterms,
      incotermsloc1         as Incotermsloc1,
      termsofpayment        as Termsofpayment,
      paymentmethod         as Paymentmethod,
      documentcurrency      as Documentcurrency,
      pricingdate           as Pricingdate,
      pricelisttype         as Pricelisttype,
      billingdate           as Billingdate,
      requesteddeliverydate as Requesteddeliverydate,
      customergroup         as Customergroup,
      creditlimit           as Creditlimit,
      
      case
          when creditlimit is initial then 'Unavailable'
          else cast(creditlimit as abap.char(20))
      end                   as CreditLimitText,
            
      case
        when creditlimit is initial then 1
        else cast( 3 as abap.int1 )
      end as CreditLimitCriticality,
            
      salesorganization     as Salesorganization,
      distributionchannel   as Distributionchannel,
      division              as Division,
      salesoffice           as Salesoffice,
      salesgroup            as Salesgroup,
      salesdistrict         as Salesdistrict,
      note                  as Note,
      totalitems            as Totalitems,
      @Semantics.amount.currencyCode : 'currency'
      grossvalue            as Grossvalue,
      @Semantics.amount.currencyCode : 'currency'
      tax                   as Tax,
      discountpercent       as Discountpercent,
      @Semantics.amount.currencyCode : 'currency'
      netvalue              as Netvalue,
      currency              as Currency,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_on            as CreatedOn,
      @Semantics.user.lastChangedBy: true
      modified_by           as ModifiedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      modified_on           as ModifiedOn,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_lastchanged     as Local_LastChanged,
      @Semantics.imageUrl: true
      cast(
//        'https://static.vecteezy.com/system/resources/previews/019/875/701/large_2x/man-in-suit-sitting-with-laptop-businessman-sitting-working-in-front-of-laptop-free-png.png' as abap.char( 255 )
        'https://cdn-icons-png.flaticon.com/512/1170/1170678.png' as abap.char(255)
      ) as CustomerImage,
       
      _items,
      _itemChart,
      
      weekdays as WeekDays
}
