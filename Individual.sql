---Individual Query---

SELECT Concat(L.ID,'_',U_ID) as Legacy_Id__c
,CONCAT(CONVERT(date,GETDATE()), ' First attempt at PartyIndivdual upload')  as Data_Migration_Job_Id__c
,ISNULL(L.ID,'') AS AccountNumber
,ISNULL([LAST],'') AS "litify_pm__Last_Name__c	"
,CONCAT([FIRST],'', MIDNAME) AS litify_pm__First_Name__c
,ISNULL(Label1,'') AS [Name]
, CASE
WHEN [CLASS] = 'CLIENT'  THEN 'Client'
WHEN [CLASS] = 'JUDGE' THEN 'Judge'
WHEN [CLASS] = 'DOCTOR' THEN 'Doctor'
WHEN [CLASS] = 'MISC' THEN 'Other'
WHEN [CLASS] = 'OTHER' THEN 'Other'
WHEN [CLASS] = 'DEFENDNT' THEN 'Defendant'
WHEN [CLASS] = 'ATTY' THEN 'Attorney'
WHEN [CLASS] = 'RELA' THEN 'Family Member'
WHEN [CLASS] = 'EXPERT' THEN 'Analyst'
WHEN [CLASS] = 'ADJUSTER' THEN 'Adjuster'
ELSE [CLASS]

END AS [Party Type]
, CASE 
WHEN SSN = '-  -' THEN ''
WHEN SSN IS NULL THEN ''
ELSE SSN
END AS litify_pm__Social_Security_Number__c
,CASE
 WHEN Phone5 = '(   )   -' THEN ''
 WHEN PHONE5 IS NULL THEN ''
 ELSE LEFT(Phone5,14)
 END AS litify_pm__Phone_Work__c	

,CASE 
WHEN CALLERID IS NULL THEN ''
WHEN CALLERID = '(   )   -' THEN ''
WHEN CALLERID = '(   )mic-helle_legg' THEN ''
WHEN CALLERID = '(Ano)nym-ous' THEN ''
WHEN CALLERID = '(Non)e  -' THEN ''
ELSE CALLERID
END AS litify_pm__Phone_Other__c
,CASE
 WHEN PHONE5 = '(   )   -' THEN ''
 WHEN PHONE5 IS NULL THEN ''
 ELSE PHONE5
 END AS Fax
,CASE
 WHEN PHONE4 = '(   )   -' THEN ''
 WHEN PHONE4 = '(   )   --' THEN ''
 WHEN PHONE4 = '(   )    -' THEN ''
 WHEN PHONE4 IS NULL THEN ''
 ELSE PHONE4
 END AS litify_pm__Phone_Mobile__c	
 ,CASE 
WHEN DAYPHONE = '(   )   -' THEN ''
WHEN DAYPHONE IS NULL AND WORKLABEL4 IS NOT NULL THEN 'Ext: ' + WORKLABEL4
WHEN DAYPHONE IS NULL THEN ''
ELSE Concat(DAYPHONE,' Ext: ', WORKLABEL4)
END AS litify_pm__Phone_Home__c,
CASE 
WHEN MARITAL = 'W' then 'Widowed'
WHEN MARITAL = 'S' THEN 'Single'
WHEN MARITAL = 'M' then 'Married'
WHEN MARITAL = 'D' then 'Divorced'
WHEN MARITAL IS NULL THEN ''
ELSE MARITAL
END AS [Martial Status],
Case 
when MAILOUT is NULL then 'No'
when MAILOUT = 'N' then 'No'
When MAILOUT = 'Y' then 'Yes'
WHEN MAILOUT = NULL THEN 'No'
End AS Mailout__c,
CASE 
WHEN GENDER = 'M' THEN 'Male'
WHEN GENDER = 'F' THEN 'Female'
WHEN GENDER IS NULL THEN ''
END AS litify_pm__Gender__c
,
ISNULL(l.EMAIL,'') AS litify_pm__Email__c
---,ISNULL(BIRTHPLACE,'') AS Place_of_birth__c
,CASE 
WHEN SPOUSE = '0' THEN ''
WHEN SPOUSE IS NULL THEN ''
ELSE SPOUSE
END  AS Spouse__c
---,ISNULL(DRIVERSLIC,'') AS Drivers_license__c
---,ISNULL(JOBTITLE,'') AS Job_title__c
,ISNULL(LABEL2,'') AS HomeStreet
,ISNULL(LABEL3,'') AS HomeStreet2
,ISNULL(City,'') AS HomeCity
,ISNULL([State],'') AS HomeState
,ISNULL(Zip,'') AS HomeZip
,CASE
WHEN DEAR LIKE 'Ms%' THEN 'Ms.'
WHEN DEAR LIKE 'Doctor%' THEN 'Dr.'
WHEN DEAR LIKE 'Mr%' THEN 'Mr.'
WHEN DEAR LIKE 'Mrs%' THEN 'Mrs.'
ELSE ''

END AS litify_pm__Salutation__c
---,ISNULL(RELATION,'') AS Relationship__c
,'0125f000001C0rBAAS' as RecordTypeID
,ISNULL(REFERREDBY,'') AS "AccountSource	"
,ISNULL(EMAILALT,'') AS Other_email__c
,ISNULL(MOTHERMAID,'') AS Mothers_Maiden_Name__c
---,ISNULL(EMAILALT,'') AS Spouse_email__c
---,CASE
 --WHEN SPHONE = '(   )   -' THEN ''
 --WHEN SPHONE = '(   )   --' THEN ''
 --WHEN SPHONE = '(   )    -' THEN ''
 --WHEN SPHONE IS NULL THEN ''
 --ELSE SPHONE
 --END AS Spouse_Phone__c

 ,ISNULL(REFERREDBY,'') AS Referred_by
 ,ISNULL([SOURCE],'') AS Source__c
 ,ISNULL([COMPANY],'') AS ParentID
 , ISNULL(BARID,'') as [State Bar ID]
 ,ISNULL(SODIBARID,'') AS [Southern DIst Bar ID]
 ,COALESCE([ENTRY],[OPEN],'') AS CreatedDate
 ,ISNULL(UF.ID ,'') AS LastModifiedBy
















FROM [bemis].[dbo].[law1] l
left join [bemis].[dbo].[CM_Users_SF] uf
on (l.operator = uf.brr)
where class
not in ('Employer', 'MYFIRM','COURTS','HEALTHCO' ,'GOV','LIFEPLAN','FINANPLA')

and active = 'True'