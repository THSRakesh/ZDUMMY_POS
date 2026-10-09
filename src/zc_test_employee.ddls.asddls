@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TEST_EMPLOYEE 
as projection on ZI_TEST_EMPLOYEE
{
        @EndUserText.label: 'Employee Id'
    key EmployeeId,
        @EndUserText.label: 'Employee Name'
        EmployeeName,
        @EndUserText.label: 'Date Of Birth'
        DateOfBirth,
        @EndUserText.label: 'Age'
        Age,
        @EndUserText.label: 'Address'
        Address,
        LocalLastChanged
}
