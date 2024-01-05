#PBI 531869 HTML Conversion - Pay Class
#Useful information, links
#TFS: http://dev.azure.com/Ceridian/SharpTop/_workitems/edit/531869
#Wiki: https://wiki.dayforce.com/display/HR/HTML+Pay+Class
#Other:
#Specflow Best Practices: https://wiki.dayforce.com/pages/viewpage.action?pageId=86022738
@PBI531869
@F529235
@DepHR_HRAdmin_PayClass_TS01General
@ui
@Team_HR_UI
#Team/Contributor
@HR_UI_HR3
@Contributor_Adiilah
#Area tag
@HRAdmin
@HR3_UI_HRAdmin
@HRAdmin_PayClass
@HRPayClass
#Execution tags
@HR_UI_General
Feature: TS01 General

Background:
	#EMPLOYEE SETUP
	Given system has existing employees with table
		| Name               |
		| USEmployeeManager2 |
	And USEmployeeManager2 has existing data using SQL Clear Insert in Security Settings > Location Access grid with table
		| Locations       | Primary | Start Date | End Date |
		| ATOnSiteDeptUSA | Checked | -3 years   |          |
	#ROLE SETUP
	Given system has data in Roles with table
		| Role REF | Name    | Copy From      |
		| 1        | AT Role | Retail Manager |
	And system has data in Role Features with table
		| Role REF | Name      | Value   | Path                |
		| 1        | Pay Class | Checked | HR Admin > HR Admin |
	#USER ROLE ASSIGNMENT
	And system has data in Users with Roles with table
		| User Login ID      | Role REF |
		| USEmployeeManager2 | 1        |

@HR_UI_P3
@HR3_VB34
#**********************SCENARIO START**********************
Scenario: SC01 Open Pay Class page and check availability of the control and control elements
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	Then should be able to add data in Pay Class grid
	And should be able to read data in Pay Class grid
	And should be able to copy data in Pay Class grid
	And should be able to delete data in Pay Class grid
	And should be able to localize data in Pay Class grid
	And Problems pane should NOT be displayed
	And first row should be selected in Pay Class grid
	And headers data should be displayed in Pay Class grid with table
		| Header 1 | Header 2    | Header 3             | Header 4       | Header 5   | Header 6        | Header 7    |
		| Name     | Description | Default Weekly Hours | Reference Code | Sort Order | Pay Class Group | Ledger Code |

@HR_UI_P3
@HR3_VB34
#**********************SCENARIO START**********************
Scenario: SC02 - Check add pay class empty row validation
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And adds data in Pay Class grid
	And saves changes
	Then Problems pane should be displayed
	And errors should be printed in Problems pane with table
		| Message                            |
		| Name - Value is required           |
		| Reference Code - Value is required |

@HR_UI_P3
@HR3_VB34
@BS_CleanPayClass
@HR_UI_Sanity
#**********************SCENARIO START**********************
Scenario: SC03 - Check duplicate pay class reference code validation
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And adds and edits data in Pay Class grid with table
		| DFPayClass REF | Name    | Description  | Reference Code |
		| 1              | TATPay1 | TATPayClass1 | TATPC1         |
		| 2              | TATPay2 | TATPayClass2 | TATPC1         |
	And saves changes
	Then Problems pane should be displayed
	And errors should be printed in Problems pane with table
		| Message                              |
		| Reference Code - Value is not unique |

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
@HR_UI_Sanity
#**********************SCENARIO START**********************
Scenario: SC04 - Add several pay class records
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And adds and edits data in Pay Class grid with table
		| DFPayClass REF | Name    | Description  | Reference Code |
		| 3              | TATPay3 | TATPayClass3 | TATPC3         |
		| 4              | TATPay4 | TATPayClass4 | TATPC4         |
		| 5              | TATPay5 | TATPayClass5 | TATPC5         |
	And saves changes
	Then changes should be saved
	And data should be displayed in Pay Class grid with table
		| DFPayClass REF | Name    | Description  | Reference Code |
		| 3              | TATPay3 | TATPayClass3 | TATPC3         |
		| 4              | TATPay4 | TATPayClass4 | TATPC4         |
		| 5              | TATPay5 | TATPayClass5 | TATPC5         |

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
#**********************SCENARIO START**********************
Scenario: SC05 - Delete pay class record
	Given system has configuration data in HR Admin > Pay Class with table
		| Name    | Description  | Reference Code |
		| TATPay6 | TATPayClass6 | TATPC6         |
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And deletes data in Pay Class grid with table
		| Name    | Description  | Reference Code |
		| TATPay6 | TATPayClass6 | TATPC6         |
	And confirms in Please Confirm dialog if exists
	And saves changes
	Then changes should be saved
	And Problems pane should NOT be displayed

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
#**********************SCENARIO START**********************
Scenario: SC06 - Copy pay class record
	Given system has configuration data in HR Admin > Pay Class with table
		| DFPayClass REF | Name    | Description  | Reference Code |
		| 7              | TATPay7 | TATPayClass7 | TATPC7         |
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And copies and edits data in Pay Class grid with table
		| DFPayClass REF | Name         | Description       | Reference Code | New REF |
		| 7              | TATPay7Copy1 | TATPayClass7Copy1 | TATPC7Copy1    | 8       |
	Then data should be displayed in Pay Class grid with table
		| DFPayClass REF | Name         | Description       | Reference Code |
		| 7              | TATPay7      | TATPayClass7      | TATPC7         |
		| 8              | TATPay7Copy1 | TATPayClass7Copy1 | TATPC7Copy1    |

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
#**********************SCENARIO START**********************
Scenario: SC07 - Check localize dialog
	Given system has configuration data in HR Admin > Pay Class with table
		| Name    | Description  | Reference Code |
		| TATPay8 | TATPayClass8 | TATPC8         |
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And localizes data in Pay Class grid with table
		| Name    | Description  | Reference Code |
		| TATPay8 | TATPayClass8 | TATPC8         |
	Then Pay Class dialog should be displayed

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
#**********************SCENARIO START**********************
Scenario: SC08 - Delete pay class which is in use
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And deletes data in Pay Class grid with table
		| Name | Description | Reference Code |
		| FT   | Full Time   | FT             |
	And saves changes
	Then Problems pane should be displayed
	And errors should be printed in Problems pane with table
		| Message                                             |
		| FT - Cannot be deleted because it is already in use |

@HR_UI_P3
@HR3_VB34
@BSAS_CleanPayClass
#**********************SCENARIO START**********************
Scenario: SC09 - Edit pay class record
	Given system has configuration data in HR Admin > Pay Class with table
		| DFPayClass REF | Name    | Description  | Reference Code |
		| 3              | TATPay3 | TATPayClass3 | TATPC3         |
	When USEmployeeManager2 logs in as AT Role role and navigates to HR Admin > Pay Class page
	And edits data in Pay Class grid with table
		| DFPayClass REF | Name    | Description           | Reference Code  |
		| 3              | TATPay3 | TATPayClass3_Modified | TATPC3_Modified |
	And saves changes
	Then changes should be saved
	And data should be displayed in Pay Class grid with table
		| Name    | Description           | Reference Code  |
		| TATPay3 | TATPayClass3_Modified | TATPC3_Modified |