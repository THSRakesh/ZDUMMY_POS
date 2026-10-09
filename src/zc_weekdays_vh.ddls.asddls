@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WeekDays Value Help'
@Metadata.ignorePropagatedAnnotations: true
@UI.presentationVariant: [{
    sortOrder: [{
        by: 'VALUE_POSITION',
        direction: #ASC
    }]
}]
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZC_WEEKDAYS_VH 
as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZD_WEEKDAYS' )
{
        @Consumption.filter.hidden: true
        @UI.hidden: true
    key domain_name,
        
        @Consumption.filter.hidden: true
        @UI.hidden: true
    key value_position,
    
        @Consumption.filter.hidden: true
        @Semantics.language: true
        @UI.hidden: true
    key language,
    
        @EndUserText.label: 'Day Code'
        @UI.textArrangement: #TEXT_ONLY
        @ObjectModel.text.element: ['text']
        value_low,
        @EndUserText.label: 'Week Day'
        text
}

