@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items Chart'
@Analytics.dataCategory: #CUBE
//@Analytics.query: true

@Metadata.ignorePropagatedAnnotations: true

@UI.chart: [{
    qualifier: 'itemChart',
    description: 'Amount Spent on Each Material',
    chartType: #BAR,
    dimensions: [ 'Material' ],
    measures: [ 'Grossvalue' ],
    dimensionAttributes: [
      {
        dimension: 'Material',
        role: #CATEGORY
      }
    ],
    measureAttributes: [
      {
        measure: 'Grossvalue',
        role: #AXIS_1
      }
    ]
}]

@UI.presentationVariant: [{
    qualifier: 'itemChartPV',
    visualizations: [
      { type: #AS_CHART, qualifier: 'itemChart' }
    ]
}]

define view entity ZC_SO_ITEMS_CHART 
as select from ZI_SO_ITEMS
{
     @UI.hidden: true
    key Customerid,
    key Itemno,

//    @AnalyticsDetails.query.axis: #ROWS
//    @AnalyticsDetails.query.display: #KEY
//    @ObjectModel.text.element: ['Material']
    @UI.lineItem: [{ position: 10 }]
    @EndUserText.label: 'Material'
    //@Aggregation.default: #NONE
    @UI.selectionField: [{ position: 10 }]
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #NONE
     Material,
    @Semantics.quantity.unitOfMeasure: 'Units'
    Quantity,
    @Semantics.amount.currencyCode: 'Currency'
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    Grossvalue,
    Currency,
    Units
 }
