#TS01 HTML Conversion - Pay Class
#Useful information, links
#TFS: http://dev.azure.com/Ceridian/SharpTop/_workitems/edit/531869
#Wiki: https://wiki.dayforce.com/display/HR/HTML+Pay+Class
#Other:
#Specflow Best Practices: https://wiki.dayforce.com/pages/viewpage.action?pageId=86022738
@PBI531869
@F529235
@DepHR_HRAdmin_PayClass_TS01Basic
@ui
@Team_HR_UI
#Team/Contributor
@HR_UI_HR3
@Contributor_Uddhav
#Area tag
@HRAdmin
@HR3_UI_HRAdmin
@HRAdmin_PayClass
@HRPayClass
#Execution tags
@HR_UI_General
Feature: TS01 Basic

Background:
	#EMPLOYEE SETUP
	Given system has existing employees with table
		| Name               |
		| USEmployeeManager2 |
	#ROLE SETUP
	Given system has data in Roles with table
		| Role REF | Name    | Copy From      |
		| 1        | AT Role | Retail Manager |
	And system has data in Role Features with table
		| Role REF | Name      | Value   | Path                |
		| 1        | Pay Class | Checked | HR Admin > HR Admin |
	And system has data in Users with Roles with table
		| User Login ID      | Role REF |
		| USEmployeeManager2 | 1        |

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
@HR_UI_Sanity
#**********************SCENARIO START**********************
Scenario: SC01 - Add pay class
	When USEmployeeManager2 logs in as AT Role role
	#And waits for 60 seconds
	And navigates to HR Admin > Pay Class page
	#And waits for 20 seconds
	And adds and edits data in Pay Class grid with table
		| DFPayClass REF | Name    | Description  | Reference Code | Pay Class Group |
		| 1              | TATPay1 | TATPayClass1 | TATPC1         | Full-time       |
	And saves changes
	Then changes should be saved
	And data should be displayed in Pay Class grid with table
		| DFPayClass REF | Name    | Description  | Reference Code | Pay Class Group |
		| 1              | TATPay1 | TATPayClass1 | TATPC1         | Full-time       |