import 'package:floor/floor.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/8/21 15:51

@Entity(tableName: "MD_Product")
class MD_Product_Entity {

  @PrimaryKey(autoGenerate: true)
  int id;
  String ProductCode;
  String Name;
  String Description;
  String Family;
  String IsActive;
  String CreatedBy;
  String DisplayUrl;
  String ExternalDataSource;
  String ExternalId;
  String LastModifiedBy;
  String QuantityUnitOfMeasure;
  String ebMobile__BaseUOM__c;
  String ebMobile__BeverageCategory__c;
  String ebMobile__BeverageProduct__c;
  String ebMobile__BeverageType__c;
  String ebMobile__Brand__c;
  String ebMobile__CarbonationIndicator__c;
  String ebMobile__Category__c;
  String ebMobile__Category1__c;
  String ebMobile__Category2__c;
  String ebMobile__Category3__c;
  String ebMobile__Pack1__c;
  String ebMobile__Pack2__c;
  String ConversionRate__c;
  String ebMobile__DeliveringPlant__c;
  String ebMobile__Denominator__c;
  String ebMobile__DistributionChannel__c;
  String ebMobile__ErpProductCode__c;
  String ebMobile__Flavor__c;
  String ebMobile__GUID__c;
  String ebMobile__IndSector__c;
  String ebMobile__IANumber__c;
  String ebMobile__IsEmpty__c;
  String ebMobile__MatFrgtGrp__c;
  String ebMobile__MaterialGroup1__c;
  String ebMobile__MaterialGroup2__c;
  String ebMobile__MaterialGroup3__c;
  String ebMobile__MaterialGroup4__c;
  String ebMobile__MaterialGroup5__c;
  String ebMobile__MaterialPricingGroup__c;
  String ebMobile__Numerator__c;
  String ebMobile__OOSFlag__c;
  String ebMobile__Package__c;
  String ebMobile__PackProductID__c;
  String ebMobile__Pack__c;
  String ebMobile__PackType__c;
  String ebMobile__PartProductID__c;
  String ebMobile__PhysicalState__c;
  String ebMobile__Plant__c;
  String ebMobile__PlantDeleteFlag__c;
  String ebMobile__PricingReferenceMaterial__c;
  String ebMobile__ProductGroup__c;
  String ebMobile__PromotionalIndicator__c;
  String ebMobile__RecordAction__c;
  String ebMobile__PlRefMat__c;
  String ebMobile__ReturnablePackagingIndicator__c;
  String ebMobile__SalesOrg__c;
  String ebMobile__SalesUnit__c;
  String ebMobile__SalStatus__c;
  String ebMobile__Sequence__c;
  String ebMobile__SFAGroup__c;
  String ebMobile__TaxClass__c;
  String ebMobile__TaxType__c;
  String ebMobile__Trademark__c;
  String ArabicProductDescription;


  MD_Product_Entity(this.id,this.ProductCode,this.Name,this.Description,this.Family,this.IsActive,this.CreatedBy,
      this.DisplayUrl,this.ExternalDataSource,this.ExternalId,this.LastModifiedBy,this.QuantityUnitOfMeasure,this.ebMobile__BaseUOM__c,
      this.ebMobile__BeverageCategory__c,this.ebMobile__BeverageProduct__c,this.ebMobile__BeverageType__c,this.ebMobile__Brand__c,
      this.ebMobile__CarbonationIndicator__c,this.ebMobile__Category__c,this.ebMobile__Category1__c,this.ebMobile__Category2__c,
      this.ebMobile__Category3__c,this.ebMobile__Pack1__c,this.ebMobile__Pack2__c,this.ConversionRate__c,this.ebMobile__DeliveringPlant__c,
      this.ebMobile__Denominator__c,this.ebMobile__DistributionChannel__c,this.ebMobile__ErpProductCode__c,this.ebMobile__Flavor__c,
      this.ebMobile__GUID__c,this.ebMobile__IndSector__c,this.ebMobile__IANumber__c,this.ebMobile__IsEmpty__c,this.ebMobile__MatFrgtGrp__c,
      this.ebMobile__MaterialGroup1__c,this.ebMobile__MaterialGroup2__c,this.ebMobile__MaterialGroup3__c,this.ebMobile__MaterialGroup4__c,
      this.ebMobile__MaterialGroup5__c,this.ebMobile__MaterialPricingGroup__c,this.ebMobile__Numerator__c,this.ebMobile__OOSFlag__c,
      this.ebMobile__Package__c,this.ebMobile__PackProductID__c,this.ebMobile__Pack__c,this.ebMobile__PackType__c,this.ebMobile__PartProductID__c,
      this.ebMobile__PhysicalState__c,this.ebMobile__Plant__c,this.ebMobile__PlantDeleteFlag__c,this.ebMobile__PricingReferenceMaterial__c,
      this.ebMobile__ProductGroup__c,this.ebMobile__PromotionalIndicator__c,this.ebMobile__RecordAction__c,this.ebMobile__PlRefMat__c,
      this.ebMobile__ReturnablePackagingIndicator__c,this.ebMobile__SalesOrg__c,this.ebMobile__SalesUnit__c,this.ebMobile__SalStatus__c,
      this.ebMobile__Sequence__c,this.ebMobile__SFAGroup__c,this.ebMobile__TaxClass__c,this.ebMobile__TaxType__c,this.ebMobile__Trademark__c,
      this.ArabicProductDescription);

  MD_Product_Entity.Empty();



}
