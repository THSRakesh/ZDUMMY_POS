@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Employee'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TEST_EMPLOYEE 
as select from ztest_employee
{
    key employee_id as EmployeeId,
    employee_name as EmployeeName,
    date_of_birth as DateOfBirth,
    age as Age,
    address as Address,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_lastchanged as LocalLastChanged
}
