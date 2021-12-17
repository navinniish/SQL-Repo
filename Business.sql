 /****** Business Queries  ******/
SELECT Concat(l.ID,'_',U_ID) as Legacy_Id__c
,CONCAT(CONVERT(date,GETDATE()), ' First attempt at PartyBusiness upload')  as Data_Migration_Job_Id__c
,'0125f000001C0rCAAS' as RecordTypeID
---,---ISNULL([LAST],'') AS litify_pm__Last_Name__c	
---,---ISNULL([FIRST],'') AS litify_pm__First_Name__c
,CASE
WHEN CLASS = 'COURTS' THEN 'Court'
WHEN CLASS = 'MYFIRM' THEN 'Law Firm'
WHEN CLASS = 'FINANPLA' THEN ''
WHEN CLASS = 'EMPLOYER' THEN ''
WHEN CLASS = 'HEALTHCO' THEN ''
WHEN CLASS = 'LIFEPLAN' THEN ''
WHEN CLASS = 'GOV' THEN 'Government Firm'
END AS [Type]
,ISNULL(COMPANY,'') AS Name 
,Concat(WORKLABEL1, ' ',WORKLABEL2,'') AS ShippingStreet
,ISNULL(WorkCity,'') AS ShippingCity
,ISNULL(WORKSTATE,'') AS 'ShippingState/Province'
,ISNULL(LEFT(WORKZIP,5),'') AS ShippingPostalCode
,CASE
 WHEN Phone5 = '(   )   -' THEN ''
 WHEN PHONE5 IS NULL THEN ''
 ELSE LEFT(Phone5,14)
 END AS litify_pm__Phone_Work__c	

,CASE
 WHEN PHONE6 = '(   )   -' THEN ''
 WHEN PHONE6 IS NULL THEN ''
 ELSE LEFT(Phone6,14)
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
END AS Phone
,ISNULL(WWW,'') AS Website,
CASE WHEN [ENTRY] IS NULL AND [OPEN] IS NULL THEN CONVERT(nvarchar(11),GETDATE(),120)
ELSE COALESCE([ENTRY], [OPEN],'') 
END AS CreatedDate
,Case 
when MAILOUT is NULL then 'No'
when MAILOUT = 'N' then 'No'
When MAILOUT = 'Y' then 'Yes'
End AS Mailout__c
,ISNULL(l.ID,'') AS AccountNumber
,CASE 
WHEN UF.BRR IS NOT NULL THEN UF.ID
ELSE '0055f0000015CpOAAU'
END AS LastModifiedBy



from [bemis].[dbo].[law1] l
left join [bemis].[dbo].[CM_Users_SF] uf
on (l.operator = uf.brr)
where class in ('Employer', 'MYFIRM','COURTS','HEALTHCO' ,'GOV','LIFEPLAN','FINANPLA')
and active = 'True'