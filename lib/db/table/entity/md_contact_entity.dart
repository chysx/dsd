import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 16:00

@Entity(tableName: "MD_Contact")
class MD_Contact_Entity {
  @PrimaryKey(autoGenerate: true)
  int pid;
  String ID;
  String AssistantName;
  String AssistantPhone;
  String Birthdate;
  String Owner;
  String CreatedBy;
  String Jigsaw;
  String Department;
  String Description;
  String DoNotCall;
  String Email;
  String HasOptedOutOfEmail;
  String Fax;
  String HasOptedOutOfFax;
  String HomePhone;
  String LastModifiedBy;
  String LastCURequestDate;
  String LastCUUpdateDate;
  String LeadSource;
  String MailingAddress;
  String MobilePhone;
  String Name;
  String Salutation;
  String FirstName;
  String LastName;
  String OtherAddress;
  String OtherPhone;
  String Phone;
  String ReportsTo;
  String Title;
  String AccountNumber__c;
  String ebMobile__IsActive__c;
  String ebMobile__Anniversary__c;
  String ebMobile__CustomerOnboarding__c;
  String ebMobile__ExternalID__c;
  String ebMobile__Facebook__c;
  String ebMobile__GUID__c;
  String ebMobile__Hobbies__c;
  String ebMobile__Married__c;
  String ebMobile__OnboardingUser__c;
  String ebMobile__Primary__c;
  String ebMobile__RecordAction__c;
  String CCSM_SAP_Contact_ID__c;
  String ebMobile__Spouse__c;
  String ebMobile__Title__c;
  String ebMobile__Twitter__c;

  MD_Contact_Entity(this.pid, this.ID, this.AssistantName, this.AssistantPhone, this.Birthdate, this.Owner,
      this.CreatedBy, this.Jigsaw, this.Department, this.Description, this.DoNotCall, this.Email,
      this.HasOptedOutOfEmail, this.Fax, this.HasOptedOutOfFax, this.HomePhone, this.LastModifiedBy,
      this.LastCURequestDate, this.LastCUUpdateDate, this.LeadSource, this.MailingAddress, this.MobilePhone, this.Name,
      this.Salutation, this.FirstName, this.LastName, this.OtherAddress, this.OtherPhone, this.Phone, this.ReportsTo,
      this.Title, this.AccountNumber__c, this.ebMobile__IsActive__c, this.ebMobile__Anniversary__c,
      this.ebMobile__CustomerOnboarding__c, this.ebMobile__ExternalID__c, this.ebMobile__Facebook__c,
      this.ebMobile__GUID__c, this.ebMobile__Hobbies__c, this.ebMobile__Married__c, this.ebMobile__OnboardingUser__c,
      this.ebMobile__Primary__c, this.ebMobile__RecordAction__c, this.CCSM_SAP_Contact_ID__c, this.ebMobile__Spouse__c,
      this.ebMobile__Title__c, this.ebMobile__Twitter__c);

  MD_Contact_Entity.Empty();

}
