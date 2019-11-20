// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DSD_M_DeliveryHeader_Dao _mDeliveryHeaderDaoInstance;

  DSD_M_DeliveryItem_Dao _mDeliveryItemDaoInstance;

  DSD_M_ShipmentHeader_Dao _mShipmentHeaderDaoInstance;

  DSD_M_ShipmentItem_Dao _mShipmentItemDaoInstance;

  DSD_M_SystemConfig_Dao _mSystemConfigDaoInstance;

  DSD_M_Truck_Dao _mTruckDaoInstance;

  DSD_T_DeliveryHeader_Dao _tDeliveryHeaderDaoInstance;

  DSD_T_DeliveryItem_Dao _tDeliveryItemDaoInstance;

  DSD_T_ShipmentHeader_Dao _tShipmentHeaderDaoInstance;

  DSD_T_ShipmentItem_Dao _tShipmentItemDaoInstance;

  DSD_T_TruckStock_Dao _tTruckStockDaoInstance;

  DSD_T_TruckStockTracking_Dao _tTruckStockTrackingDaoInstance;

  DSD_T_Visit_Dao _tVisitDaoInstance;

  MD_Account_Dao _accountDaoInstance;

  MD_Contact_Dao _contactDaoInstance;

  MD_Dictionary_Dao _dictionaryDaoInstance;

  MD_Person_Dao _personDaoInstance;

  MD_Product_Dao _productDaoInstance;

  AppLogDao _appLogDaoInstance;

  SyncDownloadLogicDao _syncDownloadLogicDaoInstance;

  SyncPhotoUploadDao _syncPhotoUploadDaoInstance;

  SyncUploadDao _syncUploadDaoInstance;

  AppConfigDao _appConfigDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_log` (`id` TEXT, `versionName` TEXT, `device` TEXT, `type` TEXT, `content` TEXT, `stackTrace` TEXT, `time` TEXT, `note` TEXT, `dirty` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sync_download_logic` (`tableName` TEXT, `tableOrder` TEXT, `timeStamp` TEXT, `version` TEXT, `isActive` TEXT, `transferred` TEXT, `keys` TEXT, PRIMARY KEY (`tableName`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sync_upload` (`id` TEXT, `uniqueIdValues` TEXT, `name` TEXT, `type` TEXT, `status` TEXT, `time` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sync_photo_upload` (`id` TEXT, `filePath` TEXT, `name` TEXT, `type` TEXT, `status` TEXT, `time` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_config` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userCode` TEXT, `userName` TEXT, `password` TEXT, `env` TEXT, `host` TEXT, `port` TEXT, `isSsl` TEXT, `syncInitFlag` TEXT, `version` TEXT, `lastUpdateTime` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_M_DeliveryHeader` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `DeliveryNo` TEXT, `ShipmentNo` TEXT, `DeliveryType` TEXT, `DeliveryStatus` TEXT, `AccountNumber` TEXT, `OrderNo` TEXT, `InvoiceNo` TEXT, `PONumber` TEXT, `OrderDate` TEXT, `PlanDeliveryDate` TEXT, `SalesRep` TEXT, `CompanyCode` TEXT, `SalesOrg` TEXT, `SalesOff` TEXT, `PaymentType` TEXT, `Currency` TEXT, `PlanDeliveryQty` TEXT, `DeliveryAddress` TEXT, `Contact` TEXT, `Telephone` TEXT, `BasePrice` TEXT, `Tax` TEXT, `Tax2` TEXT, `NetPrice` TEXT, `Deposit` TEXT, `DataSource` TEXT, `DeliveryNote` TEXT, `Discount` TEXT, `MarketDeveloper` TEXT, `DeliverySequence` TEXT, `DeliveryTimeSlotFrom` TEXT, `DeliveryTimeSlotTo` TEXT, `OnlineDiscount` TEXT, `OtherDiscount` TEXT, `APDiscount` TEXT, `PickupEmpties__c` TEXT, `EmptyRefund__c` TEXT, `ArrivalTime__c` TEXT, `FinishTime__c` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_M_DeliveryItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `DeliveryNo` TEXT, `ProductCode` TEXT, `ProductUnit` TEXT, `PlanQty` TEXT, `TotalWeight` TEXT, `WeightUnit` TEXT, `BasePrice` TEXT, `Tax` TEXT, `Tax2` TEXT, `NetPrice` TEXT, `Deposit` TEXT, `Discount` TEXT, `IsFree` TEXT, `ItemSequence` TEXT, `ItemNumber` TEXT, `ItemCategory` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_M_ShipmentHeader` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `ShipmentNo` TEXT, `ShipmentDate` TEXT, `ShipmentType` TEXT, `Route` TEXT, `Description` TEXT, `ReleaseStatus` TEXT, `ReleaseUser` TEXT, `ReleaseTime` TEXT, `CompletionStatus` TEXT, `CompletionTime` TEXT, `Driver1` TEXT, `Driver2` TEXT, `TruckId` INTEGER, `TruckCode` TEXT, `TruckType` TEXT, `LoadingSequence` TEXT, `WarehouseCode` TEXT, `OutWarehouse` TEXT, `TotalProductQty` INTEGER, `TotalItemAmount` TEXT, `TotalWeight` TEXT, `WeightUnit` TEXT, `DataSource` TEXT, `Valid` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_M_ShipmentItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `ShipmentNo` TEXT, `ProductCode` TEXT, `ProductUnit` TEXT, `PlanQty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_M_SystemConfig` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `Category` TEXT, `KeyName` TEXT, `Description` TEXT, `Value` TEXT, `Valid` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_M_Truck` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `TruckCode` TEXT, `Type` TEXT, `Capacity` REAL, `Volume` REAL, `VolumeUnit` TEXT, `CompanyCode` TEXT, `SalesOrg` TEXT, `SalesOff` TEXT, `Status` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_DeliveryHeader` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `DeliveryNo` TEXT, `VisitId` TEXT, `ShipmentNo` TEXT, `DeliveryType` TEXT, `DeliveryStatus` TEXT, `AccountNumber` TEXT, `OrderNo` TEXT, `InvoiceNo` TEXT, `PONumber` TEXT, `OrderDate` TEXT, `ActualDeliveryDate` TEXT, `Currency` TEXT, `CustomerSignStatus` TEXT, `CustomerSignDate` TEXT, `CustomerSignImg` TEXT, `DriverSignStatus` TEXT, `DriverSignDate` TEXT, `DriverSignImg` TEXT, `StartTime` TEXT, `EndTime` TEXT, `BasePrice` TEXT, `Tax` TEXT, `Tax2` TEXT, `Discount` TEXT, `NetPrice` TEXT, `Deposit` TEXT, `ActualPayment` TEXT, `ActualDeposit` TEXT, `CancelTime` TEXT, `CancelReason` TEXT, `Rebook` TEXT, `DeliveryNote` TEXT, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `MarketDeveloper` TEXT, `CustomerNot` TEXT, `PickupEmpties__c` TEXT, `EmptyRefund__c` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_DeliveryItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `DeliveryNo` TEXT, `ProductCode` TEXT, `ProductUnit` TEXT, `PlanQty` TEXT, `ActualQty` TEXT, `DifferenceQty` TEXT, `Reason` TEXT, `BasePrice` TEXT, `Tax` TEXT, `Tax2` TEXT, `Discount` TEXT, `NetPrice` TEXT, `Deposit` TEXT, `IsReturn` TEXT, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `IsFree` TEXT, `ItemSequence` TEXT, `ItemNumber` TEXT, `ItemCategory` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_ShipmentHeader` (`pid` INTEGER PRIMARY KEY AUTOINCREMENT, `Id` TEXT, `ShipmentNo` TEXT, `ShipmentDate` TEXT, `ShipmentType` TEXT, `ActionType` TEXT, `StartTime` TEXT, `EndTime` TEXT, `Odometer` INTEGER, `Checker` TEXT, `CheckerConfirm` INTEGER, `CheckerConfirmTime` TEXT, `CheckerSignImg` TEXT, `DCheckerSignImg` TEXT, `Cashier` TEXT, `CashierConfirm` INTEGER, `CashierConfirmTime` TEXT, `CashierSignImg` TEXT, `DCashierSignImg` TEXT, `Gatekeeper` TEXT, `GKConfirm` INTEGER, `GKConfirmTime` TEXT, `GKSignImg` TEXT, `DGKSignImg` TEXT, `WarehouseCode` TEXT, `Status` TEXT, `Driver` TEXT, `TruckId` INTEGER, `TotalAmount` TEXT, `TotalWeight` TEXT, `WeightUnit` TEXT, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `ScanResult` TEXT, `Manually` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_ShipmentItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `HeaderId` TEXT, `ProductCode` TEXT, `ProductUnit` TEXT, `PlanQty` INTEGER, `ActualQty` INTEGER, `DifferenceQty` INTEGER, `DifferenceReason` TEXT, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_TruckStock` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `TruckId` INTEGER, `ShipmentNo` TEXT, `ProductCode` TEXT, `ProductUnit` TEXT, `StockQty` INTEGER, `SaleableQty` INTEGER, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_TruckStockTracking` (`pid` INTEGER PRIMARY KEY AUTOINCREMENT, `Id` TEXT, `VisitId` TEXT, `TruckId` INTEGER, `ShipmentNo` TEXT, `TrackingTime` TEXT, `ProductCode` TEXT, `ProductUnit` TEXT, `ChangeAction` TEXT, `ChangeQuantity` INTEGER, `FromQty` INTEGER, `ToQty` INTEGER, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DSD_T_Visit` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `VisitId` TEXT, `ShipmentNo` TEXT, `StartTime` TEXT, `EndTime` TEXT, `UserCode` TEXT, `AccountNumber` TEXT, `Longitude` TEXT, `Latitude` TEXT, `CancelReason` TEXT, `NoScanReason` TEXT, `CreateUser` TEXT, `CreateTime` TEXT, `LastUpdateUser` TEXT, `LastUpdateTime` TEXT, `dirty` TEXT, `isCompleted` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MD_Account` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `Name` TEXT, `AccountNumber` TEXT, `Owner` TEXT, `RecordType` TEXT, `Site` TEXT, `AccountSource` TEXT, `AnnualRevenue` TEXT, `BillingAddress` TEXT, `CreatedBy` TEXT, `Jigsaw` TEXT, `Description` TEXT, `NumberOfEmployees` TEXT, `Fax` TEXT, `Industry` TEXT, `LastModifiedBy` TEXT, `Ownership` TEXT, `Parent` TEXT, `Phone` TEXT, `Rating` TEXT, `ShippingAddress` TEXT, `Sic` TEXT, `SicDesc` TEXT, `TickerSymbol` TEXT, `Type` TEXT, `Website` TEXT, `ebMobile__AccountGroup__c` TEXT, `ebMobile__AccountName1__c` TEXT, `ebMobile__AccountName2__c` TEXT, `ebMobile__AccountPartner__c` TEXT, `ebMobile__AccountPhotoId__c` TEXT, `ebMobile__ActivationDate__c` TEXT, `ebMobile__IsActive__c` TEXT, `ebMobile__Address__c` TEXT, `ebMobile__ApprovalStepsDate__c` TEXT, `ebMobile__BillTo__c` TEXT, `ebMobile__BlockByCredit__c` TEXT, `ebMobile__DeliveryType__c` TEXT, `ebMobile__BusinessTypeExtension__c` TEXT, `ebMobile__CallFrequency__c` TEXT, `CallFrequencyCode__c` TEXT, `ebMobile__Category__c` TEXT, `ebMobile__IsChangeByInterface__c` TEXT, `ebMobile__CityCode__c` TEXT, `ebMobile__Segment__c` TEXT, `ebMobile__CloseDay__c` TEXT, `ebMobile__ClosingTime__c` TEXT, `ebMobile__Company__c` TEXT, `ebMobile__CompanyCode__c` TEXT, `ebMobile__CompanyDeleteFlag__c` TEXT, `ebMobile__ContactEmail__c` TEXT, `ebMobile__ContactMobile__c` TEXT, `ebMobile__ContactPersonFunction__c` TEXT, `ebMobile__ContactPersonName__c` TEXT, `ebMobile__ContactPhone__c` TEXT, `ebMobile__Country__c` TEXT, `ebMobile__CountryCode__c` TEXT, `ebMobile__CountryKey__c` TEXT, `ebMobile__CreditDays__c` TEXT, `ebMobile__AvailableBalance__c` TEXT, `ebMobile__CreditLimit__c` TEXT, `ebMobile__Currency__c` TEXT, `ebMobile__CustomerConditionGroup__c` TEXT, `ebMobile__DeliveringPlant__c` TEXT, `ebMobile__DeliveryDate__c` TEXT, `ebMobile__DeliveryDays__c` TEXT, `ebMobile__DiscountIndicator__c` TEXT, `ebMobile__DistributionChannel__c` TEXT, `ebMobile__Distributor__c` TEXT, `ebMobile__District__c` TEXT, `ebMobile__Division__c` TEXT, `ebMobile__ERPAccountNumber__c` TEXT, `ExecuteBatchFlag__c` TEXT, `ebMobile__GeoCode__c` TEXT, `ebMobile__GUID__c` TEXT, `HasUpdatedAR__c` TEXT, `ebMobile__HouseNumber__c` TEXT, `ebMobile__InvestmentValue__c` TEXT, `ebMobile__InvoiceCalendar__c` TEXT, `IsPush__c` TEXT, `ebMobile__KeyAccount__c` TEXT, `KeyAccount__c` TEXT, `Last3MonthsVolume__c` TEXT, `ebMobile__Last3MonthsVolume__c` TEXT, `ebMobile__LastCallDate__c` TEXT, `ebMobile__LastOrderDate__c` TEXT, `ebMobile__LastOrderTotalPrice__c` TEXT, `ebMobile__LastOrderTotalQuantity__c` TEXT, `ebMobile__MEPCustomerNumber__c` TEXT, `ebMobile__OpeningTime__c` TEXT, `ebMobile__OpenItemsAgingStart__c` TEXT, `ebMobile__OperationalMarketType__c` TEXT, `ebMobile__OperationalTradeChannel__c` TEXT, `ebMobile__OrderBlock__c` TEXT, `ebMobile__Owner_Role__c` TEXT, `ebMobile__P3MAVGSales__c` TEXT, `ebMobile__PartnerFunction__c` TEXT, `ebMobile__Payer__c` TEXT, `ebMobile__PaymentTerms__c` TEXT, `ebMobile__PONumber__c` TEXT, `ebMobile__Postal__c` TEXT, `ebMobile__PriceAttribute__c` TEXT, `ebMobile__PriceClassID__c` TEXT, `ebMobile__PriceGroup__c` TEXT, `ebMobile__PriceListType__c` TEXT, `ebMobile__PricingProcedure__c` TEXT, `ebMobile__RecordAction__c` TEXT, `ebMobile__RecordTypeName__c` TEXT, `RedIndecator__c` TEXT, `ebMobile__Region__c` TEXT, `ebMobile__RegistrationNumber__c` TEXT, `ebMobile__SalesDistrict__c` TEXT, `ebMobile__SaleGroup__c` TEXT, `ebMobile__SalesOffice__c` TEXT, `ebMobile__SalesOrg__c` TEXT, `ebMobile__SalesOrgCode__c` TEXT, `ebMobile__User__c` TEXT, `ebMobile__SalesRoute__c` TEXT, `ebMobile__ShippingCondition__c` TEXT, `ShippingConditionCode__c` TEXT, `ebMobile__ShipTo__c` TEXT, `ebMobile__State__c` TEXT, `ebMobile__Street__c` TEXT, `ebMobile__Street4__c` TEXT, `ebMobile__Street5__c` TEXT, `ebMobile__StreetNumber__c` TEXT, `ebMobile__SubTradeChannel__c` TEXT, `ebMobile__SuppressionReason__c` TEXT, `ebMobile__SuspressionCode__c` TEXT, `ebMobile__SuspressionDate__c` TEXT, `ebMobile__TargetGroup__c` TEXT, `ebMobile__TaxCode__c` TEXT, `ebMobile__TaxNumber__c` TEXT, `ebMobile__TotalOpenAmount__c` TEXT, `ebMobile__TradeChannel__c` TEXT, `ebMobile__TradeGroup__c` TEXT, `ebMobile__TradeName__c` TEXT, `TransportationZone__c` TEXT, `ebMobile__UniqueKey__c` TEXT, `ebMobile__VATNumber__c` TEXT, `ebMobile__Vendor__c` TEXT, `CCSM_VendorNo__c` TEXT, `ebMobile__VisitStartDate__c` TEXT, `ebMobile__ZAPartner__c` TEXT, `ebMobile__ZBPartner__c` TEXT, `ebMobile__ZGPartner__c` TEXT, `ebMobile__ZHPartner__c` TEXT, `ebMobile__ZIPartner__c` TEXT, `ebMobile__ZNPartner__c` TEXT, `ebMobile__ZQPartner__c` TEXT, `ebMobile__ZRPartner__c` TEXT, `ebMobile__ZTPartner__c` TEXT, `ebMobile__ZXCrossDock__c` TEXT, `Geo_Longitude` TEXT, `Geo_Latitude` TEXT, `ProductList` TEXT, `ebMobile__Barcode__c` TEXT, `RouteNumber` TEXT, `ebMobile__ScanStoreMandatory__c` TEXT, `ebMobile__RouteJumping__c` TEXT, `ShippingCity` TEXT, `ShippingPostalCode` TEXT, `Route` TEXT, `ArabicName__c` TEXT, `ArabicStreet__c` TEXT, `ArabicCity__c` TEXT, `ArabicCountry__c` TEXT, `VATRegistrationNo` TEXT, `NoteToDriver__c` TEXT, `Usercode` TEXT, `LastTime` TEXT, `dirty` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MD_Contact` (`pid` INTEGER PRIMARY KEY AUTOINCREMENT, `ID` TEXT, `AssistantName` TEXT, `AssistantPhone` TEXT, `Birthdate` TEXT, `Owner` TEXT, `CreatedBy` TEXT, `Jigsaw` TEXT, `Department` TEXT, `Description` TEXT, `DoNotCall` TEXT, `Email` TEXT, `HasOptedOutOfEmail` TEXT, `Fax` TEXT, `HasOptedOutOfFax` TEXT, `HomePhone` TEXT, `LastModifiedBy` TEXT, `LastCURequestDate` TEXT, `LastCUUpdateDate` TEXT, `LeadSource` TEXT, `MailingAddress` TEXT, `MobilePhone` TEXT, `Name` TEXT, `Salutation` TEXT, `FirstName` TEXT, `LastName` TEXT, `OtherAddress` TEXT, `OtherPhone` TEXT, `Phone` TEXT, `ReportsTo` TEXT, `Title` TEXT, `AccountNumber__c` TEXT, `ebMobile__IsActive__c` TEXT, `ebMobile__Anniversary__c` TEXT, `ebMobile__CustomerOnboarding__c` TEXT, `ebMobile__ExternalID__c` TEXT, `ebMobile__Facebook__c` TEXT, `ebMobile__GUID__c` TEXT, `ebMobile__Hobbies__c` TEXT, `ebMobile__Married__c` TEXT, `ebMobile__OnboardingUser__c` TEXT, `ebMobile__Primary__c` TEXT, `ebMobile__RecordAction__c` TEXT, `CCSM_SAP_Contact_ID__c` TEXT, `ebMobile__Spouse__c` TEXT, `ebMobile__Title__c` TEXT, `ebMobile__Twitter__c` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MD_Dictionary` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `Category` TEXT, `Value` TEXT, `Description` TEXT, `Valid` TEXT, `Sequence` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MD_Person` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `UserCode` TEXT, `Password` TEXT, `FirstName` TEXT, `LastName` TEXT, `Type` TEXT, `RouteNumber` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MD_Product` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `ProductCode` TEXT, `Name` TEXT, `Description` TEXT, `Family` TEXT, `IsActive` TEXT, `CreatedBy` TEXT, `DisplayUrl` TEXT, `ExternalDataSource` TEXT, `ExternalId` TEXT, `LastModifiedBy` TEXT, `QuantityUnitOfMeasure` TEXT, `ebMobile__BaseUOM__c` TEXT, `ebMobile__BeverageCategory__c` TEXT, `ebMobile__BeverageProduct__c` TEXT, `ebMobile__BeverageType__c` TEXT, `ebMobile__Brand__c` TEXT, `ebMobile__CarbonationIndicator__c` TEXT, `ebMobile__Category__c` TEXT, `ebMobile__Category1__c` TEXT, `ebMobile__Category2__c` TEXT, `ebMobile__Category3__c` TEXT, `ebMobile__Pack1__c` TEXT, `ebMobile__Pack2__c` TEXT, `ConversionRate__c` TEXT, `ebMobile__DeliveringPlant__c` TEXT, `ebMobile__Denominator__c` TEXT, `ebMobile__DistributionChannel__c` TEXT, `ebMobile__ErpProductCode__c` TEXT, `ebMobile__Flavor__c` TEXT, `ebMobile__GUID__c` TEXT, `ebMobile__IndSector__c` TEXT, `ebMobile__IANumber__c` TEXT, `ebMobile__IsEmpty__c` TEXT, `ebMobile__MatFrgtGrp__c` TEXT, `ebMobile__MaterialGroup1__c` TEXT, `ebMobile__MaterialGroup2__c` TEXT, `ebMobile__MaterialGroup3__c` TEXT, `ebMobile__MaterialGroup4__c` TEXT, `ebMobile__MaterialGroup5__c` TEXT, `ebMobile__MaterialPricingGroup__c` TEXT, `ebMobile__Numerator__c` TEXT, `ebMobile__OOSFlag__c` TEXT, `ebMobile__Package__c` TEXT, `ebMobile__PackProductID__c` TEXT, `ebMobile__Pack__c` TEXT, `ebMobile__PackType__c` TEXT, `ebMobile__PartProductID__c` TEXT, `ebMobile__PhysicalState__c` TEXT, `ebMobile__Plant__c` TEXT, `ebMobile__PlantDeleteFlag__c` TEXT, `ebMobile__PricingReferenceMaterial__c` TEXT, `ebMobile__ProductGroup__c` TEXT, `ebMobile__PromotionalIndicator__c` TEXT, `ebMobile__RecordAction__c` TEXT, `ebMobile__PlRefMat__c` TEXT, `ebMobile__ReturnablePackagingIndicator__c` TEXT, `ebMobile__SalesOrg__c` TEXT, `ebMobile__SalesUnit__c` TEXT, `ebMobile__SalStatus__c` TEXT, `ebMobile__Sequence__c` TEXT, `ebMobile__SFAGroup__c` TEXT, `ebMobile__TaxClass__c` TEXT, `ebMobile__TaxType__c` TEXT, `ebMobile__Trademark__c` TEXT, `ArabicProductDescription` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  DSD_M_DeliveryHeader_Dao get mDeliveryHeaderDao {
    return _mDeliveryHeaderDaoInstance ??=
        _$DSD_M_DeliveryHeader_Dao(database, changeListener);
  }

  @override
  DSD_M_DeliveryItem_Dao get mDeliveryItemDao {
    return _mDeliveryItemDaoInstance ??=
        _$DSD_M_DeliveryItem_Dao(database, changeListener);
  }

  @override
  DSD_M_ShipmentHeader_Dao get mShipmentHeaderDao {
    return _mShipmentHeaderDaoInstance ??=
        _$DSD_M_ShipmentHeader_Dao(database, changeListener);
  }

  @override
  DSD_M_ShipmentItem_Dao get mShipmentItemDao {
    return _mShipmentItemDaoInstance ??=
        _$DSD_M_ShipmentItem_Dao(database, changeListener);
  }

  @override
  DSD_M_SystemConfig_Dao get mSystemConfigDao {
    return _mSystemConfigDaoInstance ??=
        _$DSD_M_SystemConfig_Dao(database, changeListener);
  }

  @override
  DSD_M_Truck_Dao get mTruckDao {
    return _mTruckDaoInstance ??= _$DSD_M_Truck_Dao(database, changeListener);
  }

  @override
  DSD_T_DeliveryHeader_Dao get tDeliveryHeaderDao {
    return _tDeliveryHeaderDaoInstance ??=
        _$DSD_T_DeliveryHeader_Dao(database, changeListener);
  }

  @override
  DSD_T_DeliveryItem_Dao get tDeliveryItemDao {
    return _tDeliveryItemDaoInstance ??=
        _$DSD_T_DeliveryItem_Dao(database, changeListener);
  }

  @override
  DSD_T_ShipmentHeader_Dao get tShipmentHeaderDao {
    return _tShipmentHeaderDaoInstance ??=
        _$DSD_T_ShipmentHeader_Dao(database, changeListener);
  }

  @override
  DSD_T_ShipmentItem_Dao get tShipmentItemDao {
    return _tShipmentItemDaoInstance ??=
        _$DSD_T_ShipmentItem_Dao(database, changeListener);
  }

  @override
  DSD_T_TruckStock_Dao get tTruckStockDao {
    return _tTruckStockDaoInstance ??=
        _$DSD_T_TruckStock_Dao(database, changeListener);
  }

  @override
  DSD_T_TruckStockTracking_Dao get tTruckStockTrackingDao {
    return _tTruckStockTrackingDaoInstance ??=
        _$DSD_T_TruckStockTracking_Dao(database, changeListener);
  }

  @override
  DSD_T_Visit_Dao get tVisitDao {
    return _tVisitDaoInstance ??= _$DSD_T_Visit_Dao(database, changeListener);
  }

  @override
  MD_Account_Dao get accountDao {
    return _accountDaoInstance ??= _$MD_Account_Dao(database, changeListener);
  }

  @override
  MD_Contact_Dao get contactDao {
    return _contactDaoInstance ??= _$MD_Contact_Dao(database, changeListener);
  }

  @override
  MD_Dictionary_Dao get dictionaryDao {
    return _dictionaryDaoInstance ??=
        _$MD_Dictionary_Dao(database, changeListener);
  }

  @override
  MD_Person_Dao get personDao {
    return _personDaoInstance ??= _$MD_Person_Dao(database, changeListener);
  }

  @override
  MD_Product_Dao get productDao {
    return _productDaoInstance ??= _$MD_Product_Dao(database, changeListener);
  }

  @override
  AppLogDao get appLogDao {
    return _appLogDaoInstance ??= _$AppLogDao(database, changeListener);
  }

  @override
  SyncDownloadLogicDao get syncDownloadLogicDao {
    return _syncDownloadLogicDaoInstance ??=
        _$SyncDownloadLogicDao(database, changeListener);
  }

  @override
  SyncPhotoUploadDao get syncPhotoUploadDao {
    return _syncPhotoUploadDaoInstance ??=
        _$SyncPhotoUploadDao(database, changeListener);
  }

  @override
  SyncUploadDao get syncUploadDao {
    return _syncUploadDaoInstance ??= _$SyncUploadDao(database, changeListener);
  }

  @override
  AppConfigDao get appConfigDao {
    return _appConfigDaoInstance ??= _$AppConfigDao(database, changeListener);
  }
}

class _$DSD_M_DeliveryHeader_Dao extends DSD_M_DeliveryHeader_Dao {
  _$DSD_M_DeliveryHeader_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_M_DeliveryHeader_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_M_DeliveryHeader',
            (DSD_M_DeliveryHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ShipmentNo': item.ShipmentNo,
                  'DeliveryType': item.DeliveryType,
                  'DeliveryStatus': item.DeliveryStatus,
                  'AccountNumber': item.AccountNumber,
                  'OrderNo': item.OrderNo,
                  'InvoiceNo': item.InvoiceNo,
                  'PONumber': item.PONumber,
                  'OrderDate': item.OrderDate,
                  'PlanDeliveryDate': item.PlanDeliveryDate,
                  'SalesRep': item.SalesRep,
                  'CompanyCode': item.CompanyCode,
                  'SalesOrg': item.SalesOrg,
                  'SalesOff': item.SalesOff,
                  'PaymentType': item.PaymentType,
                  'Currency': item.Currency,
                  'PlanDeliveryQty': item.PlanDeliveryQty,
                  'DeliveryAddress': item.DeliveryAddress,
                  'Contact': item.Contact,
                  'Telephone': item.Telephone,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'DataSource': item.DataSource,
                  'DeliveryNote': item.DeliveryNote,
                  'Discount': item.Discount,
                  'MarketDeveloper': item.MarketDeveloper,
                  'DeliverySequence': item.DeliverySequence,
                  'DeliveryTimeSlotFrom': item.DeliveryTimeSlotFrom,
                  'DeliveryTimeSlotTo': item.DeliveryTimeSlotTo,
                  'OnlineDiscount': item.OnlineDiscount,
                  'OtherDiscount': item.OtherDiscount,
                  'APDiscount': item.APDiscount,
                  'PickupEmpties__c': item.PickupEmpties__c,
                  'EmptyRefund__c': item.EmptyRefund__c,
                  'ArrivalTime__c': item.ArrivalTime__c,
                  'FinishTime__c': item.FinishTime__c
                }),
        _dSD_M_DeliveryHeader_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_M_DeliveryHeader',
            ['id'],
            (DSD_M_DeliveryHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ShipmentNo': item.ShipmentNo,
                  'DeliveryType': item.DeliveryType,
                  'DeliveryStatus': item.DeliveryStatus,
                  'AccountNumber': item.AccountNumber,
                  'OrderNo': item.OrderNo,
                  'InvoiceNo': item.InvoiceNo,
                  'PONumber': item.PONumber,
                  'OrderDate': item.OrderDate,
                  'PlanDeliveryDate': item.PlanDeliveryDate,
                  'SalesRep': item.SalesRep,
                  'CompanyCode': item.CompanyCode,
                  'SalesOrg': item.SalesOrg,
                  'SalesOff': item.SalesOff,
                  'PaymentType': item.PaymentType,
                  'Currency': item.Currency,
                  'PlanDeliveryQty': item.PlanDeliveryQty,
                  'DeliveryAddress': item.DeliveryAddress,
                  'Contact': item.Contact,
                  'Telephone': item.Telephone,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'DataSource': item.DataSource,
                  'DeliveryNote': item.DeliveryNote,
                  'Discount': item.Discount,
                  'MarketDeveloper': item.MarketDeveloper,
                  'DeliverySequence': item.DeliverySequence,
                  'DeliveryTimeSlotFrom': item.DeliveryTimeSlotFrom,
                  'DeliveryTimeSlotTo': item.DeliveryTimeSlotTo,
                  'OnlineDiscount': item.OnlineDiscount,
                  'OtherDiscount': item.OtherDiscount,
                  'APDiscount': item.APDiscount,
                  'PickupEmpties__c': item.PickupEmpties__c,
                  'EmptyRefund__c': item.EmptyRefund__c,
                  'ArrivalTime__c': item.ArrivalTime__c,
                  'FinishTime__c': item.FinishTime__c
                }),
        _dSD_M_DeliveryHeader_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_M_DeliveryHeader',
            ['id'],
            (DSD_M_DeliveryHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ShipmentNo': item.ShipmentNo,
                  'DeliveryType': item.DeliveryType,
                  'DeliveryStatus': item.DeliveryStatus,
                  'AccountNumber': item.AccountNumber,
                  'OrderNo': item.OrderNo,
                  'InvoiceNo': item.InvoiceNo,
                  'PONumber': item.PONumber,
                  'OrderDate': item.OrderDate,
                  'PlanDeliveryDate': item.PlanDeliveryDate,
                  'SalesRep': item.SalesRep,
                  'CompanyCode': item.CompanyCode,
                  'SalesOrg': item.SalesOrg,
                  'SalesOff': item.SalesOff,
                  'PaymentType': item.PaymentType,
                  'Currency': item.Currency,
                  'PlanDeliveryQty': item.PlanDeliveryQty,
                  'DeliveryAddress': item.DeliveryAddress,
                  'Contact': item.Contact,
                  'Telephone': item.Telephone,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'DataSource': item.DataSource,
                  'DeliveryNote': item.DeliveryNote,
                  'Discount': item.Discount,
                  'MarketDeveloper': item.MarketDeveloper,
                  'DeliverySequence': item.DeliverySequence,
                  'DeliveryTimeSlotFrom': item.DeliveryTimeSlotFrom,
                  'DeliveryTimeSlotTo': item.DeliveryTimeSlotTo,
                  'OnlineDiscount': item.OnlineDiscount,
                  'OtherDiscount': item.OtherDiscount,
                  'APDiscount': item.APDiscount,
                  'PickupEmpties__c': item.PickupEmpties__c,
                  'EmptyRefund__c': item.EmptyRefund__c,
                  'ArrivalTime__c': item.ArrivalTime__c,
                  'FinishTime__c': item.FinishTime__c
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_M_DeliveryHeaderMapper = (Map<String, dynamic> row) =>
      DSD_M_DeliveryHeader_Entity(
          row['id'] as int,
          row['DeliveryNo'] as String,
          row['ShipmentNo'] as String,
          row['DeliveryType'] as String,
          row['DeliveryStatus'] as String,
          row['AccountNumber'] as String,
          row['OrderNo'] as String,
          row['InvoiceNo'] as String,
          row['PONumber'] as String,
          row['OrderDate'] as String,
          row['PlanDeliveryDate'] as String,
          row['SalesRep'] as String,
          row['CompanyCode'] as String,
          row['SalesOrg'] as String,
          row['SalesOff'] as String,
          row['PaymentType'] as String,
          row['Currency'] as String,
          row['PlanDeliveryQty'] as String,
          row['DeliveryAddress'] as String,
          row['Contact'] as String,
          row['Telephone'] as String,
          row['BasePrice'] as String,
          row['Tax'] as String,
          row['Tax2'] as String,
          row['NetPrice'] as String,
          row['Deposit'] as String,
          row['DataSource'] as String,
          row['DeliveryNote'] as String,
          row['Discount'] as String,
          row['MarketDeveloper'] as String,
          row['DeliverySequence'] as String,
          row['DeliveryTimeSlotFrom'] as String,
          row['DeliveryTimeSlotTo'] as String,
          row['OnlineDiscount'] as String,
          row['OtherDiscount'] as String,
          row['APDiscount'] as String,
          row['PickupEmpties__c'] as String,
          row['EmptyRefund__c'] as String,
          row['ArrivalTime__c'] as String,
          row['FinishTime__c'] as String);

  final InsertionAdapter<DSD_M_DeliveryHeader_Entity>
      _dSD_M_DeliveryHeader_EntityInsertionAdapter;

  final UpdateAdapter<DSD_M_DeliveryHeader_Entity>
      _dSD_M_DeliveryHeader_EntityUpdateAdapter;

  final DeletionAdapter<DSD_M_DeliveryHeader_Entity>
      _dSD_M_DeliveryHeader_EntityDeletionAdapter;

  @override
  Future<List<DSD_M_DeliveryHeader_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_M_DeliveryHeader',
        mapper: _dSD_M_DeliveryHeaderMapper);
  }

  @override
  Future<DSD_M_DeliveryHeader_Entity> findEntityByDeliveryNo(
      String deliveryNo) async {
    return _queryAdapter.query(
        'SELECT * FROM DSD_M_DeliveryHeader WHERE deliveryNo = ?',
        arguments: <dynamic>[deliveryNo],
        mapper: _dSD_M_DeliveryHeaderMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_M_DeliveryHeader WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_DeliveryHeader');
  }

  @override
  Future<List<DSD_M_DeliveryHeader_Entity>> findEntityByCon(
      String shipmentNo, String accountNumber) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_M_DeliveryHeader WHERE shipmentNo = ? AND accountNumber = ? ORDER BY DeliverySequence ASC',
        arguments: <dynamic>[shipmentNo, accountNumber],
        mapper: _dSD_M_DeliveryHeaderMapper);
  }

  @override
  Future<void> insertEntity(DSD_M_DeliveryHeader_Entity entity) async {
    await _dSD_M_DeliveryHeader_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_M_DeliveryHeader_Entity entity) {
    return _dSD_M_DeliveryHeader_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_M_DeliveryHeader_Entity> entityList) {
    return _dSD_M_DeliveryHeader_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_M_DeliveryItem_Dao extends DSD_M_DeliveryItem_Dao {
  _$DSD_M_DeliveryItem_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_M_DeliveryItem_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_M_DeliveryItem',
            (DSD_M_DeliveryItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'Discount': item.Discount,
                  'IsFree': item.IsFree,
                  'ItemSequence': item.ItemSequence,
                  'ItemNumber': item.ItemNumber,
                  'ItemCategory': item.ItemCategory
                }),
        _dSD_M_DeliveryItem_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_M_DeliveryItem',
            ['id'],
            (DSD_M_DeliveryItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'Discount': item.Discount,
                  'IsFree': item.IsFree,
                  'ItemSequence': item.ItemSequence,
                  'ItemNumber': item.ItemNumber,
                  'ItemCategory': item.ItemCategory
                }),
        _dSD_M_DeliveryItem_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_M_DeliveryItem',
            ['id'],
            (DSD_M_DeliveryItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'Discount': item.Discount,
                  'IsFree': item.IsFree,
                  'ItemSequence': item.ItemSequence,
                  'ItemNumber': item.ItemNumber,
                  'ItemCategory': item.ItemCategory
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_M_DeliveryItemMapper = (Map<String, dynamic> row) =>
      DSD_M_DeliveryItem_Entity(
          row['id'] as int,
          row['DeliveryNo'] as String,
          row['ProductCode'] as String,
          row['ProductUnit'] as String,
          row['PlanQty'] as String,
          row['TotalWeight'] as String,
          row['WeightUnit'] as String,
          row['BasePrice'] as String,
          row['Tax'] as String,
          row['Tax2'] as String,
          row['NetPrice'] as String,
          row['Deposit'] as String,
          row['Discount'] as String,
          row['IsFree'] as String,
          row['ItemSequence'] as String,
          row['ItemNumber'] as String,
          row['ItemCategory'] as String);

  final InsertionAdapter<DSD_M_DeliveryItem_Entity>
      _dSD_M_DeliveryItem_EntityInsertionAdapter;

  final UpdateAdapter<DSD_M_DeliveryItem_Entity>
      _dSD_M_DeliveryItem_EntityUpdateAdapter;

  final DeletionAdapter<DSD_M_DeliveryItem_Entity>
      _dSD_M_DeliveryItem_EntityDeletionAdapter;

  @override
  Future<List<DSD_M_DeliveryItem_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_M_DeliveryItem',
        mapper: _dSD_M_DeliveryItemMapper);
  }

  @override
  Future<List<DSD_M_DeliveryItem_Entity>> findEntityByDeliveryNo(
      String DeliveryNo) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_M_DeliveryItem WHERE DeliveryNo = ?',
        arguments: <dynamic>[DeliveryNo],
        mapper: _dSD_M_DeliveryItemMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_M_DeliveryItem WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_DeliveryItem');
  }

  @override
  Future<void> insertEntity(DSD_M_DeliveryItem_Entity entity) async {
    await _dSD_M_DeliveryItem_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_M_DeliveryItem_Entity entity) {
    return _dSD_M_DeliveryItem_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_M_DeliveryItem_Entity> entityList) {
    return _dSD_M_DeliveryItem_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_M_ShipmentHeader_Dao extends DSD_M_ShipmentHeader_Dao {
  _$DSD_M_ShipmentHeader_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_M_ShipmentHeader_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_M_ShipmentHeader',
            (DSD_M_ShipmentHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ShipmentNo': item.ShipmentNo,
                  'ShipmentDate': item.ShipmentDate,
                  'ShipmentType': item.ShipmentType,
                  'Route': item.Route,
                  'Description': item.Description,
                  'ReleaseStatus': item.ReleaseStatus,
                  'ReleaseUser': item.ReleaseUser,
                  'ReleaseTime': item.ReleaseTime,
                  'CompletionStatus': item.CompletionStatus,
                  'CompletionTime': item.CompletionTime,
                  'Driver1': item.Driver1,
                  'Driver2': item.Driver2,
                  'TruckId': item.TruckId,
                  'TruckCode': item.TruckCode,
                  'TruckType': item.TruckType,
                  'LoadingSequence': item.LoadingSequence,
                  'WarehouseCode': item.WarehouseCode,
                  'OutWarehouse': item.OutWarehouse,
                  'TotalProductQty': item.TotalProductQty,
                  'TotalItemAmount': item.TotalItemAmount,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'DataSource': item.DataSource,
                  'Valid': item.Valid
                }),
        _dSD_M_ShipmentHeader_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_M_ShipmentHeader',
            ['id'],
            (DSD_M_ShipmentHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ShipmentNo': item.ShipmentNo,
                  'ShipmentDate': item.ShipmentDate,
                  'ShipmentType': item.ShipmentType,
                  'Route': item.Route,
                  'Description': item.Description,
                  'ReleaseStatus': item.ReleaseStatus,
                  'ReleaseUser': item.ReleaseUser,
                  'ReleaseTime': item.ReleaseTime,
                  'CompletionStatus': item.CompletionStatus,
                  'CompletionTime': item.CompletionTime,
                  'Driver1': item.Driver1,
                  'Driver2': item.Driver2,
                  'TruckId': item.TruckId,
                  'TruckCode': item.TruckCode,
                  'TruckType': item.TruckType,
                  'LoadingSequence': item.LoadingSequence,
                  'WarehouseCode': item.WarehouseCode,
                  'OutWarehouse': item.OutWarehouse,
                  'TotalProductQty': item.TotalProductQty,
                  'TotalItemAmount': item.TotalItemAmount,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'DataSource': item.DataSource,
                  'Valid': item.Valid
                }),
        _dSD_M_ShipmentHeader_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_M_ShipmentHeader',
            ['id'],
            (DSD_M_ShipmentHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ShipmentNo': item.ShipmentNo,
                  'ShipmentDate': item.ShipmentDate,
                  'ShipmentType': item.ShipmentType,
                  'Route': item.Route,
                  'Description': item.Description,
                  'ReleaseStatus': item.ReleaseStatus,
                  'ReleaseUser': item.ReleaseUser,
                  'ReleaseTime': item.ReleaseTime,
                  'CompletionStatus': item.CompletionStatus,
                  'CompletionTime': item.CompletionTime,
                  'Driver1': item.Driver1,
                  'Driver2': item.Driver2,
                  'TruckId': item.TruckId,
                  'TruckCode': item.TruckCode,
                  'TruckType': item.TruckType,
                  'LoadingSequence': item.LoadingSequence,
                  'WarehouseCode': item.WarehouseCode,
                  'OutWarehouse': item.OutWarehouse,
                  'TotalProductQty': item.TotalProductQty,
                  'TotalItemAmount': item.TotalItemAmount,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'DataSource': item.DataSource,
                  'Valid': item.Valid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_M_ShipmentHeaderMapper = (Map<String, dynamic> row) =>
      DSD_M_ShipmentHeader_Entity(
          row['id'] as int,
          row['ShipmentNo'] as String,
          row['ShipmentDate'] as String,
          row['ShipmentType'] as String,
          row['Route'] as String,
          row['Description'] as String,
          row['ReleaseStatus'] as String,
          row['ReleaseUser'] as String,
          row['ReleaseTime'] as String,
          row['CompletionStatus'] as String,
          row['CompletionTime'] as String,
          row['Driver1'] as String,
          row['Driver2'] as String,
          row['TruckId'] as int,
          row['TruckCode'] as String,
          row['TruckType'] as String,
          row['LoadingSequence'] as String,
          row['WarehouseCode'] as String,
          row['OutWarehouse'] as String,
          row['TotalProductQty'] as int,
          row['TotalItemAmount'] as String,
          row['TotalWeight'] as String,
          row['WeightUnit'] as String,
          row['DataSource'] as String,
          row['Valid'] as String);

  final InsertionAdapter<DSD_M_ShipmentHeader_Entity>
      _dSD_M_ShipmentHeader_EntityInsertionAdapter;

  final UpdateAdapter<DSD_M_ShipmentHeader_Entity>
      _dSD_M_ShipmentHeader_EntityUpdateAdapter;

  final DeletionAdapter<DSD_M_ShipmentHeader_Entity>
      _dSD_M_ShipmentHeader_EntityDeletionAdapter;

  @override
  Future<List<DSD_M_ShipmentHeader_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_M_ShipmentHeader',
        mapper: _dSD_M_ShipmentHeaderMapper);
  }

  @override
  Future<DSD_M_ShipmentHeader_Entity> findEntityByShipmentNo(
      String ShipmentNo, String Valid) async {
    return _queryAdapter.query(
        'SELECT * FROM DSD_M_ShipmentHeader WHERE ShipmentNo = ? AND Valid = ?',
        arguments: <dynamic>[ShipmentNo, Valid],
        mapper: _dSD_M_ShipmentHeaderMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_M_ShipmentHeader WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_ShipmentHeader');
  }

  @override
  Future<List<DSD_M_ShipmentHeader_Entity>> findByByToday(
      String ShipmentDate, String Valid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_M_ShipmentHeader WHERE ShipmentDate = ? AND Valid = ?',
        arguments: <dynamic>[ShipmentDate, Valid],
        mapper: _dSD_M_ShipmentHeaderMapper);
  }

  @override
  Future<void> insertEntity(DSD_M_ShipmentHeader_Entity entity) async {
    await _dSD_M_ShipmentHeader_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_M_ShipmentHeader_Entity entity) {
    return _dSD_M_ShipmentHeader_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_M_ShipmentHeader_Entity> entityList) {
    return _dSD_M_ShipmentHeader_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_M_ShipmentItem_Dao extends DSD_M_ShipmentItem_Dao {
  _$DSD_M_ShipmentItem_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_M_ShipmentItem_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_M_ShipmentItem',
            (DSD_M_ShipmentItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ShipmentNo': item.ShipmentNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty
                }),
        _dSD_M_ShipmentItem_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_M_ShipmentItem',
            ['id'],
            (DSD_M_ShipmentItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ShipmentNo': item.ShipmentNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty
                }),
        _dSD_M_ShipmentItem_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_M_ShipmentItem',
            ['id'],
            (DSD_M_ShipmentItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ShipmentNo': item.ShipmentNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_M_ShipmentItemMapper = (Map<String, dynamic> row) =>
      DSD_M_ShipmentItem_Entity(
          row['id'] as int,
          row['ShipmentNo'] as String,
          row['ProductCode'] as String,
          row['ProductUnit'] as String,
          row['PlanQty'] as String);

  final InsertionAdapter<DSD_M_ShipmentItem_Entity>
      _dSD_M_ShipmentItem_EntityInsertionAdapter;

  final UpdateAdapter<DSD_M_ShipmentItem_Entity>
      _dSD_M_ShipmentItem_EntityUpdateAdapter;

  final DeletionAdapter<DSD_M_ShipmentItem_Entity>
      _dSD_M_ShipmentItem_EntityDeletionAdapter;

  @override
  Future<List<DSD_M_ShipmentItem_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_M_ShipmentItem',
        mapper: _dSD_M_ShipmentItemMapper);
  }

  @override
  Future<List<DSD_M_ShipmentItem_Entity>> findEntityByShipmentNo(
      String ShipmentNo) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_M_ShipmentItem WHERE ShipmentNo = ?',
        arguments: <dynamic>[ShipmentNo],
        mapper: _dSD_M_ShipmentItemMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_M_ShipmentItem WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_ShipmentItem');
  }

  @override
  Future<void> insertEntity(DSD_M_ShipmentItem_Entity entity) async {
    await _dSD_M_ShipmentItem_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_M_ShipmentItem_Entity entity) {
    return _dSD_M_ShipmentItem_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_M_ShipmentItem_Entity> entityList) {
    return _dSD_M_ShipmentItem_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_M_SystemConfig_Dao extends DSD_M_SystemConfig_Dao {
  _$DSD_M_SystemConfig_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_M_SystemConfig_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_M_SystemConfig',
            (DSD_M_SystemConfig_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Category': item.Category,
                  'KeyName': item.KeyName,
                  'Description': item.Description,
                  'Value': item.Value,
                  'Valid': item.Valid
                }),
        _dSD_M_SystemConfig_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_M_SystemConfig',
            ['id'],
            (DSD_M_SystemConfig_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Category': item.Category,
                  'KeyName': item.KeyName,
                  'Description': item.Description,
                  'Value': item.Value,
                  'Valid': item.Valid
                }),
        _dSD_M_SystemConfig_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_M_SystemConfig',
            ['id'],
            (DSD_M_SystemConfig_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Category': item.Category,
                  'KeyName': item.KeyName,
                  'Description': item.Description,
                  'Value': item.Value,
                  'Valid': item.Valid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_M_SystemConfigMapper = (Map<String, dynamic> row) =>
      DSD_M_SystemConfig_Entity(
          row['id'] as int,
          row['Category'] as String,
          row['KeyName'] as String,
          row['Description'] as String,
          row['Value'] as String,
          row['Valid'] as String);

  final InsertionAdapter<DSD_M_SystemConfig_Entity>
      _dSD_M_SystemConfig_EntityInsertionAdapter;

  final UpdateAdapter<DSD_M_SystemConfig_Entity>
      _dSD_M_SystemConfig_EntityUpdateAdapter;

  final DeletionAdapter<DSD_M_SystemConfig_Entity>
      _dSD_M_SystemConfig_EntityDeletionAdapter;

  @override
  Future<List<DSD_M_SystemConfig_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_M_SystemConfig',
        mapper: _dSD_M_SystemConfigMapper);
  }

  @override
  Future<DSD_M_SystemConfig_Entity> findEntityByCon(
      String Category, String KeyName, String Valid) async {
    return _queryAdapter.query(
        'SELECT * FROM DSD_M_SystemConfig WHERE Category = ? AND KeyName = ? AND Valid = ?',
        arguments: <dynamic>[Category, KeyName, Valid],
        mapper: _dSD_M_SystemConfigMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_M_SystemConfig WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_SystemConfig');
  }

  @override
  Future<void> insertEntity(DSD_M_SystemConfig_Entity entity) async {
    await _dSD_M_SystemConfig_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_M_SystemConfig_Entity entity) {
    return _dSD_M_SystemConfig_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_M_SystemConfig_Entity> entityList) {
    return _dSD_M_SystemConfig_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_M_Truck_Dao extends DSD_M_Truck_Dao {
  _$DSD_M_Truck_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_M_Truck_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_M_Truck',
            (DSD_M_Truck_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'TruckCode': item.TruckCode,
                  'Type': item.Type,
                  'Capacity': item.Capacity,
                  'Volume': item.Volume,
                  'VolumeUnit': item.VolumeUnit,
                  'CompanyCode': item.CompanyCode,
                  'SalesOrg': item.SalesOrg,
                  'SalesOff': item.SalesOff,
                  'Status': item.Status
                }),
        _dSD_M_Truck_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_M_Truck',
            ['id'],
            (DSD_M_Truck_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'TruckCode': item.TruckCode,
                  'Type': item.Type,
                  'Capacity': item.Capacity,
                  'Volume': item.Volume,
                  'VolumeUnit': item.VolumeUnit,
                  'CompanyCode': item.CompanyCode,
                  'SalesOrg': item.SalesOrg,
                  'SalesOff': item.SalesOff,
                  'Status': item.Status
                }),
        _dSD_M_Truck_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_M_Truck',
            ['id'],
            (DSD_M_Truck_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'TruckCode': item.TruckCode,
                  'Type': item.Type,
                  'Capacity': item.Capacity,
                  'Volume': item.Volume,
                  'VolumeUnit': item.VolumeUnit,
                  'CompanyCode': item.CompanyCode,
                  'SalesOrg': item.SalesOrg,
                  'SalesOff': item.SalesOff,
                  'Status': item.Status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_M_TruckMapper = (Map<String, dynamic> row) =>
      DSD_M_Truck_Entity(
          row['id'] as int,
          row['TruckCode'] as String,
          row['Type'] as String,
          row['Capacity'] as double,
          row['Volume'] as double,
          row['VolumeUnit'] as String,
          row['CompanyCode'] as String,
          row['SalesOrg'] as String,
          row['SalesOff'] as String,
          row['Status'] as String);

  final InsertionAdapter<DSD_M_Truck_Entity>
      _dSD_M_Truck_EntityInsertionAdapter;

  final UpdateAdapter<DSD_M_Truck_Entity> _dSD_M_Truck_EntityUpdateAdapter;

  final DeletionAdapter<DSD_M_Truck_Entity> _dSD_M_Truck_EntityDeletionAdapter;

  @override
  Future<List<DSD_M_Truck_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_M_Truck',
        mapper: _dSD_M_TruckMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_Truck WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_Truck');
  }

  @override
  Future<void> insertEntity(DSD_M_Truck_Entity entity) async {
    await _dSD_M_Truck_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_M_Truck_Entity entity) {
    return _dSD_M_Truck_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_M_Truck_Entity> entityList) {
    return _dSD_M_Truck_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_DeliveryHeader_Dao extends DSD_T_DeliveryHeader_Dao {
  _$DSD_T_DeliveryHeader_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_DeliveryHeader_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_DeliveryHeader',
            (DSD_T_DeliveryHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'VisitId': item.VisitId,
                  'ShipmentNo': item.ShipmentNo,
                  'DeliveryType': item.DeliveryType,
                  'DeliveryStatus': item.DeliveryStatus,
                  'AccountNumber': item.AccountNumber,
                  'OrderNo': item.OrderNo,
                  'InvoiceNo': item.InvoiceNo,
                  'PONumber': item.PONumber,
                  'OrderDate': item.OrderDate,
                  'ActualDeliveryDate': item.ActualDeliveryDate,
                  'Currency': item.Currency,
                  'CustomerSignStatus': item.CustomerSignStatus,
                  'CustomerSignDate': item.CustomerSignDate,
                  'CustomerSignImg': item.CustomerSignImg,
                  'DriverSignStatus': item.DriverSignStatus,
                  'DriverSignDate': item.DriverSignDate,
                  'DriverSignImg': item.DriverSignImg,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'Discount': item.Discount,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'ActualPayment': item.ActualPayment,
                  'ActualDeposit': item.ActualDeposit,
                  'CancelTime': item.CancelTime,
                  'CancelReason': item.CancelReason,
                  'Rebook': item.Rebook,
                  'DeliveryNote': item.DeliveryNote,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'MarketDeveloper': item.MarketDeveloper,
                  'CustomerNot': item.CustomerNot,
                  'PickupEmpties__c': item.PickupEmpties__c,
                  'EmptyRefund__c': item.EmptyRefund__c,
                  'dirty': item.dirty
                }),
        _dSD_T_DeliveryHeader_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_DeliveryHeader',
            ['id'],
            (DSD_T_DeliveryHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'VisitId': item.VisitId,
                  'ShipmentNo': item.ShipmentNo,
                  'DeliveryType': item.DeliveryType,
                  'DeliveryStatus': item.DeliveryStatus,
                  'AccountNumber': item.AccountNumber,
                  'OrderNo': item.OrderNo,
                  'InvoiceNo': item.InvoiceNo,
                  'PONumber': item.PONumber,
                  'OrderDate': item.OrderDate,
                  'ActualDeliveryDate': item.ActualDeliveryDate,
                  'Currency': item.Currency,
                  'CustomerSignStatus': item.CustomerSignStatus,
                  'CustomerSignDate': item.CustomerSignDate,
                  'CustomerSignImg': item.CustomerSignImg,
                  'DriverSignStatus': item.DriverSignStatus,
                  'DriverSignDate': item.DriverSignDate,
                  'DriverSignImg': item.DriverSignImg,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'Discount': item.Discount,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'ActualPayment': item.ActualPayment,
                  'ActualDeposit': item.ActualDeposit,
                  'CancelTime': item.CancelTime,
                  'CancelReason': item.CancelReason,
                  'Rebook': item.Rebook,
                  'DeliveryNote': item.DeliveryNote,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'MarketDeveloper': item.MarketDeveloper,
                  'CustomerNot': item.CustomerNot,
                  'PickupEmpties__c': item.PickupEmpties__c,
                  'EmptyRefund__c': item.EmptyRefund__c,
                  'dirty': item.dirty
                }),
        _dSD_T_DeliveryHeader_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_DeliveryHeader',
            ['id'],
            (DSD_T_DeliveryHeader_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'VisitId': item.VisitId,
                  'ShipmentNo': item.ShipmentNo,
                  'DeliveryType': item.DeliveryType,
                  'DeliveryStatus': item.DeliveryStatus,
                  'AccountNumber': item.AccountNumber,
                  'OrderNo': item.OrderNo,
                  'InvoiceNo': item.InvoiceNo,
                  'PONumber': item.PONumber,
                  'OrderDate': item.OrderDate,
                  'ActualDeliveryDate': item.ActualDeliveryDate,
                  'Currency': item.Currency,
                  'CustomerSignStatus': item.CustomerSignStatus,
                  'CustomerSignDate': item.CustomerSignDate,
                  'CustomerSignImg': item.CustomerSignImg,
                  'DriverSignStatus': item.DriverSignStatus,
                  'DriverSignDate': item.DriverSignDate,
                  'DriverSignImg': item.DriverSignImg,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'Discount': item.Discount,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'ActualPayment': item.ActualPayment,
                  'ActualDeposit': item.ActualDeposit,
                  'CancelTime': item.CancelTime,
                  'CancelReason': item.CancelReason,
                  'Rebook': item.Rebook,
                  'DeliveryNote': item.DeliveryNote,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'MarketDeveloper': item.MarketDeveloper,
                  'CustomerNot': item.CustomerNot,
                  'PickupEmpties__c': item.PickupEmpties__c,
                  'EmptyRefund__c': item.EmptyRefund__c,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_DeliveryHeaderMapper = (Map<String, dynamic> row) =>
      DSD_T_DeliveryHeader_Entity(
          row['id'] as int,
          row['DeliveryNo'] as String,
          row['VisitId'] as String,
          row['ShipmentNo'] as String,
          row['DeliveryType'] as String,
          row['DeliveryStatus'] as String,
          row['AccountNumber'] as String,
          row['OrderNo'] as String,
          row['InvoiceNo'] as String,
          row['PONumber'] as String,
          row['OrderDate'] as String,
          row['ActualDeliveryDate'] as String,
          row['Currency'] as String,
          row['CustomerSignStatus'] as String,
          row['CustomerSignDate'] as String,
          row['CustomerSignImg'] as String,
          row['DriverSignStatus'] as String,
          row['DriverSignDate'] as String,
          row['DriverSignImg'] as String,
          row['StartTime'] as String,
          row['EndTime'] as String,
          row['BasePrice'] as String,
          row['Tax'] as String,
          row['Tax2'] as String,
          row['Discount'] as String,
          row['NetPrice'] as String,
          row['Deposit'] as String,
          row['ActualPayment'] as String,
          row['ActualDeposit'] as String,
          row['CancelTime'] as String,
          row['CancelReason'] as String,
          row['Rebook'] as String,
          row['DeliveryNote'] as String,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['MarketDeveloper'] as String,
          row['CustomerNot'] as String,
          row['PickupEmpties__c'] as String,
          row['EmptyRefund__c'] as String,
          row['dirty'] as String);

  final InsertionAdapter<DSD_T_DeliveryHeader_Entity>
      _dSD_T_DeliveryHeader_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_DeliveryHeader_Entity>
      _dSD_T_DeliveryHeader_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_DeliveryHeader_Entity>
      _dSD_T_DeliveryHeader_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_DeliveryHeader_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_DeliveryHeader',
        mapper: _dSD_T_DeliveryHeaderMapper);
  }

  @override
  Future<DSD_T_DeliveryHeader_Entity> findEntityByDeliveryNo(
      String DeliveryNo) async {
    return _queryAdapter.query(
        'SELECT * FROM DSD_T_DeliveryHeader WHERE DeliveryNo = ?',
        arguments: <dynamic>[DeliveryNo],
        mapper: _dSD_T_DeliveryHeaderMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_DeliveryHeader WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_DeliveryHeader');
  }

  @override
  Future<List<DSD_T_DeliveryHeader_Entity>> findEntityByShipmentNo(
      String ShipmentNo) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_DeliveryHeader WHERE ShipmentNo = ?',
        arguments: <dynamic>[ShipmentNo],
        mapper: _dSD_T_DeliveryHeaderMapper);
  }

  @override
  Future<List<DSD_T_DeliveryHeader_Entity>> findEntityByCon(
      String shipmentNo, String accountNumber) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_DeliveryHeader WHERE shipmentNo = ? AND accountNumber = ?',
        arguments: <dynamic>[shipmentNo, accountNumber],
        mapper: _dSD_T_DeliveryHeaderMapper);
  }

  @override
  Future<void> insertEntity(DSD_T_DeliveryHeader_Entity entity) async {
    await _dSD_T_DeliveryHeader_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_DeliveryHeader_Entity entity) {
    return _dSD_T_DeliveryHeader_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_DeliveryHeader_Entity> entityList) {
    return _dSD_T_DeliveryHeader_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_DeliveryItem_Dao extends DSD_T_DeliveryItem_Dao {
  _$DSD_T_DeliveryItem_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_DeliveryItem_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_DeliveryItem',
            (DSD_T_DeliveryItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'ActualQty': item.ActualQty,
                  'DifferenceQty': item.DifferenceQty,
                  'Reason': item.Reason,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'Discount': item.Discount,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'IsReturn': item.IsReturn,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'IsFree': item.IsFree,
                  'ItemSequence': item.ItemSequence,
                  'ItemNumber': item.ItemNumber,
                  'ItemCategory': item.ItemCategory,
                  'dirty': item.dirty
                }),
        _dSD_T_DeliveryItem_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_DeliveryItem',
            ['id'],
            (DSD_T_DeliveryItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'ActualQty': item.ActualQty,
                  'DifferenceQty': item.DifferenceQty,
                  'Reason': item.Reason,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'Discount': item.Discount,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'IsReturn': item.IsReturn,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'IsFree': item.IsFree,
                  'ItemSequence': item.ItemSequence,
                  'ItemNumber': item.ItemNumber,
                  'ItemCategory': item.ItemCategory,
                  'dirty': item.dirty
                }),
        _dSD_T_DeliveryItem_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_DeliveryItem',
            ['id'],
            (DSD_T_DeliveryItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'DeliveryNo': item.DeliveryNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'ActualQty': item.ActualQty,
                  'DifferenceQty': item.DifferenceQty,
                  'Reason': item.Reason,
                  'BasePrice': item.BasePrice,
                  'Tax': item.Tax,
                  'Tax2': item.Tax2,
                  'Discount': item.Discount,
                  'NetPrice': item.NetPrice,
                  'Deposit': item.Deposit,
                  'IsReturn': item.IsReturn,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'IsFree': item.IsFree,
                  'ItemSequence': item.ItemSequence,
                  'ItemNumber': item.ItemNumber,
                  'ItemCategory': item.ItemCategory,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_DeliveryItemMapper = (Map<String, dynamic> row) =>
      DSD_T_DeliveryItem_Entity(
          row['id'] as int,
          row['DeliveryNo'] as String,
          row['ProductCode'] as String,
          row['ProductUnit'] as String,
          row['PlanQty'] as String,
          row['ActualQty'] as String,
          row['DifferenceQty'] as String,
          row['Reason'] as String,
          row['BasePrice'] as String,
          row['Tax'] as String,
          row['Tax2'] as String,
          row['Discount'] as String,
          row['NetPrice'] as String,
          row['Deposit'] as String,
          row['IsReturn'] as String,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['IsFree'] as String,
          row['ItemSequence'] as String,
          row['ItemNumber'] as String,
          row['ItemCategory'] as String,
          row['dirty'] as String);

  final InsertionAdapter<DSD_T_DeliveryItem_Entity>
      _dSD_T_DeliveryItem_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_DeliveryItem_Entity>
      _dSD_T_DeliveryItem_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_DeliveryItem_Entity>
      _dSD_T_DeliveryItem_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_DeliveryItem_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_DeliveryItem',
        mapper: _dSD_T_DeliveryItemMapper);
  }

  @override
  Future<List<DSD_T_DeliveryItem_Entity>> findEntityByDeliveryNo(
      String DeliveryNo) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_DeliveryItem WHERE DeliveryNo = ?',
        arguments: <dynamic>[DeliveryNo],
        mapper: _dSD_T_DeliveryItemMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_DeliveryItem WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_DeliveryItem');
  }

  @override
  Future<void> deleteByNo(String deliveryNo) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_DeliveryItem WHERE deliveryNo = ?',
        arguments: <dynamic>[deliveryNo]);
  }

  @override
  Future<void> insertEntity(DSD_T_DeliveryItem_Entity entity) async {
    await _dSD_T_DeliveryItem_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertEntityList(
      List<DSD_T_DeliveryItem_Entity> entityList) {
    return _dSD_T_DeliveryItem_EntityInsertionAdapter.insertListAndReturnIds(
        entityList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_DeliveryItem_Entity entity) {
    return _dSD_T_DeliveryItem_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_DeliveryItem_Entity> entityList) {
    return _dSD_T_DeliveryItem_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_ShipmentHeader_Dao extends DSD_T_ShipmentHeader_Dao {
  _$DSD_T_ShipmentHeader_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_ShipmentHeader_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_ShipmentHeader',
            (DSD_T_ShipmentHeader_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'Id': item.Id,
                  'ShipmentNo': item.ShipmentNo,
                  'ShipmentDate': item.ShipmentDate,
                  'ShipmentType': item.ShipmentType,
                  'ActionType': item.ActionType,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'Odometer': item.Odometer,
                  'Checker': item.Checker,
                  'CheckerConfirm': item.CheckerConfirm,
                  'CheckerConfirmTime': item.CheckerConfirmTime,
                  'CheckerSignImg': item.CheckerSignImg,
                  'DCheckerSignImg': item.DCheckerSignImg,
                  'Cashier': item.Cashier,
                  'CashierConfirm': item.CashierConfirm,
                  'CashierConfirmTime': item.CashierConfirmTime,
                  'CashierSignImg': item.CashierSignImg,
                  'DCashierSignImg': item.DCashierSignImg,
                  'Gatekeeper': item.Gatekeeper,
                  'GKConfirm': item.GKConfirm,
                  'GKConfirmTime': item.GKConfirmTime,
                  'GKSignImg': item.GKSignImg,
                  'DGKSignImg': item.DGKSignImg,
                  'WarehouseCode': item.WarehouseCode,
                  'Status': item.Status,
                  'Driver': item.Driver,
                  'TruckId': item.TruckId,
                  'TotalAmount': item.TotalAmount,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'ScanResult': item.ScanResult,
                  'Manually': item.Manually,
                  'dirty': item.dirty
                }),
        _dSD_T_ShipmentHeader_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_ShipmentHeader',
            ['pid'],
            (DSD_T_ShipmentHeader_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'Id': item.Id,
                  'ShipmentNo': item.ShipmentNo,
                  'ShipmentDate': item.ShipmentDate,
                  'ShipmentType': item.ShipmentType,
                  'ActionType': item.ActionType,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'Odometer': item.Odometer,
                  'Checker': item.Checker,
                  'CheckerConfirm': item.CheckerConfirm,
                  'CheckerConfirmTime': item.CheckerConfirmTime,
                  'CheckerSignImg': item.CheckerSignImg,
                  'DCheckerSignImg': item.DCheckerSignImg,
                  'Cashier': item.Cashier,
                  'CashierConfirm': item.CashierConfirm,
                  'CashierConfirmTime': item.CashierConfirmTime,
                  'CashierSignImg': item.CashierSignImg,
                  'DCashierSignImg': item.DCashierSignImg,
                  'Gatekeeper': item.Gatekeeper,
                  'GKConfirm': item.GKConfirm,
                  'GKConfirmTime': item.GKConfirmTime,
                  'GKSignImg': item.GKSignImg,
                  'DGKSignImg': item.DGKSignImg,
                  'WarehouseCode': item.WarehouseCode,
                  'Status': item.Status,
                  'Driver': item.Driver,
                  'TruckId': item.TruckId,
                  'TotalAmount': item.TotalAmount,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'ScanResult': item.ScanResult,
                  'Manually': item.Manually,
                  'dirty': item.dirty
                }),
        _dSD_T_ShipmentHeader_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_ShipmentHeader',
            ['pid'],
            (DSD_T_ShipmentHeader_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'Id': item.Id,
                  'ShipmentNo': item.ShipmentNo,
                  'ShipmentDate': item.ShipmentDate,
                  'ShipmentType': item.ShipmentType,
                  'ActionType': item.ActionType,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'Odometer': item.Odometer,
                  'Checker': item.Checker,
                  'CheckerConfirm': item.CheckerConfirm,
                  'CheckerConfirmTime': item.CheckerConfirmTime,
                  'CheckerSignImg': item.CheckerSignImg,
                  'DCheckerSignImg': item.DCheckerSignImg,
                  'Cashier': item.Cashier,
                  'CashierConfirm': item.CashierConfirm,
                  'CashierConfirmTime': item.CashierConfirmTime,
                  'CashierSignImg': item.CashierSignImg,
                  'DCashierSignImg': item.DCashierSignImg,
                  'Gatekeeper': item.Gatekeeper,
                  'GKConfirm': item.GKConfirm,
                  'GKConfirmTime': item.GKConfirmTime,
                  'GKSignImg': item.GKSignImg,
                  'DGKSignImg': item.DGKSignImg,
                  'WarehouseCode': item.WarehouseCode,
                  'Status': item.Status,
                  'Driver': item.Driver,
                  'TruckId': item.TruckId,
                  'TotalAmount': item.TotalAmount,
                  'TotalWeight': item.TotalWeight,
                  'WeightUnit': item.WeightUnit,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'ScanResult': item.ScanResult,
                  'Manually': item.Manually,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_ShipmentHeaderMapper = (Map<String, dynamic> row) =>
      DSD_T_ShipmentHeader_Entity(
          row['pid'] as int,
          row['Id'] as String,
          row['ShipmentNo'] as String,
          row['ShipmentDate'] as String,
          row['ShipmentType'] as String,
          row['ActionType'] as String,
          row['StartTime'] as String,
          row['EndTime'] as String,
          row['Odometer'] as int,
          row['Checker'] as String,
          row['CheckerConfirm'] as int,
          row['CheckerConfirmTime'] as String,
          row['CheckerSignImg'] as String,
          row['DCheckerSignImg'] as String,
          row['Cashier'] as String,
          row['CashierConfirm'] as int,
          row['CashierConfirmTime'] as String,
          row['CashierSignImg'] as String,
          row['DCashierSignImg'] as String,
          row['Gatekeeper'] as String,
          row['GKConfirm'] as int,
          row['GKConfirmTime'] as String,
          row['GKSignImg'] as String,
          row['DGKSignImg'] as String,
          row['WarehouseCode'] as String,
          row['Status'] as String,
          row['Driver'] as String,
          row['TruckId'] as int,
          row['TotalAmount'] as String,
          row['TotalWeight'] as String,
          row['WeightUnit'] as String,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['ScanResult'] as String,
          row['Manually'] as String,
          row['dirty'] as String);

  final InsertionAdapter<DSD_T_ShipmentHeader_Entity>
      _dSD_T_ShipmentHeader_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_ShipmentHeader_Entity>
      _dSD_T_ShipmentHeader_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_ShipmentHeader_Entity>
      _dSD_T_ShipmentHeader_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_ShipmentHeader_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_ShipmentHeader',
        mapper: _dSD_T_ShipmentHeaderMapper);
  }

  @override
  Future<DSD_T_ShipmentHeader_Entity> findEntityByShipmentNo(
      String ShipmentNo, String ActionType) async {
    return _queryAdapter.query(
        'SELECT * FROM DSD_T_ShipmentHeader WHERE ShipmentNo = ? AND ActionType = ?',
        arguments: <dynamic>[ShipmentNo, ActionType],
        mapper: _dSD_T_ShipmentHeaderMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_ShipmentHeader WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_ShipmentHeader');
  }

  @override
  Future<void> insertEntity(DSD_T_ShipmentHeader_Entity entity) async {
    await _dSD_T_ShipmentHeader_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_ShipmentHeader_Entity entity) {
    return _dSD_T_ShipmentHeader_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_ShipmentHeader_Entity> entityList) {
    return _dSD_T_ShipmentHeader_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_ShipmentItem_Dao extends DSD_T_ShipmentItem_Dao {
  _$DSD_T_ShipmentItem_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_ShipmentItem_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_ShipmentItem',
            (DSD_T_ShipmentItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'HeaderId': item.HeaderId,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'ActualQty': item.ActualQty,
                  'DifferenceQty': item.DifferenceQty,
                  'DifferenceReason': item.DifferenceReason,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                }),
        _dSD_T_ShipmentItem_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_ShipmentItem',
            ['id'],
            (DSD_T_ShipmentItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'HeaderId': item.HeaderId,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'ActualQty': item.ActualQty,
                  'DifferenceQty': item.DifferenceQty,
                  'DifferenceReason': item.DifferenceReason,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                }),
        _dSD_T_ShipmentItem_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_ShipmentItem',
            ['id'],
            (DSD_T_ShipmentItem_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'HeaderId': item.HeaderId,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'PlanQty': item.PlanQty,
                  'ActualQty': item.ActualQty,
                  'DifferenceQty': item.DifferenceQty,
                  'DifferenceReason': item.DifferenceReason,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_ShipmentItemMapper = (Map<String, dynamic> row) =>
      DSD_T_ShipmentItem_Entity(
          row['id'] as int,
          row['HeaderId'] as String,
          row['ProductCode'] as String,
          row['ProductUnit'] as String,
          row['PlanQty'] as int,
          row['ActualQty'] as int,
          row['DifferenceQty'] as int,
          row['DifferenceReason'] as String,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['dirty'] as String);

  final InsertionAdapter<DSD_T_ShipmentItem_Entity>
      _dSD_T_ShipmentItem_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_ShipmentItem_Entity>
      _dSD_T_ShipmentItem_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_ShipmentItem_Entity>
      _dSD_T_ShipmentItem_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_ShipmentItem_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_ShipmentItem',
        mapper: _dSD_T_ShipmentItemMapper);
  }

  @override
  Future<List<DSD_T_ShipmentItem_Entity>> findEntityByShipmentNo(
      String ShipmentNo) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_ShipmentItem WHERE ShipmentNo = ?',
        arguments: <dynamic>[ShipmentNo],
        mapper: _dSD_T_ShipmentItemMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_ShipmentItem WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_ShipmentItem');
  }

  @override
  Future<void> deleteByHeaderId(String HeaderId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_ShipmentItem WHERE HeaderId = ?',
        arguments: <dynamic>[HeaderId]);
  }

  @override
  Future<void> deleteByShipmentNo(String ShipmentNo, String ActionType) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_ShipmentItem WHERE ShipmentNo = ? AND ActionType = ?',
        arguments: <dynamic>[ShipmentNo, ActionType]);
  }

  @override
  Future<List<DSD_T_ShipmentItem_Entity>> findEntityByHeaderId(
      String HeaderId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_ShipmentItem WHERE HeaderId = ?',
        arguments: <dynamic>[HeaderId],
        mapper: _dSD_T_ShipmentItemMapper);
  }

  @override
  Future<List<DSD_T_ShipmentItem_Entity>> findEntityByHeaderIdAndCode(
      String HeaderId, String ProductCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_ShipmentItem WHERE HeaderId = ? AND ProductCode = ?',
        arguments: <dynamic>[HeaderId, ProductCode],
        mapper: _dSD_T_ShipmentItemMapper);
  }

  @override
  Future<void> insertEntity(DSD_T_ShipmentItem_Entity entity) async {
    await _dSD_T_ShipmentItem_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertEntityList(
      List<DSD_T_ShipmentItem_Entity> entityList) {
    return _dSD_T_ShipmentItem_EntityInsertionAdapter.insertListAndReturnIds(
        entityList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_ShipmentItem_Entity entity) {
    return _dSD_T_ShipmentItem_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_ShipmentItem_Entity> entityList) {
    return _dSD_T_ShipmentItem_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_TruckStock_Dao extends DSD_T_TruckStock_Dao {
  _$DSD_T_TruckStock_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_TruckStock_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_TruckStock',
            (DSD_T_TruckStock_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'TruckId': item.TruckId,
                  'ShipmentNo': item.ShipmentNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'StockQty': item.StockQty,
                  'SaleableQty': item.SaleableQty,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                }),
        _dSD_T_TruckStock_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_TruckStock',
            ['id'],
            (DSD_T_TruckStock_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'TruckId': item.TruckId,
                  'ShipmentNo': item.ShipmentNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'StockQty': item.StockQty,
                  'SaleableQty': item.SaleableQty,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                }),
        _dSD_T_TruckStock_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_TruckStock',
            ['id'],
            (DSD_T_TruckStock_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'TruckId': item.TruckId,
                  'ShipmentNo': item.ShipmentNo,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'StockQty': item.StockQty,
                  'SaleableQty': item.SaleableQty,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_TruckStockMapper = (Map<String, dynamic> row) =>
      DSD_T_TruckStock_Entity(
          row['id'] as int,
          row['TruckId'] as int,
          row['ShipmentNo'] as String,
          row['ProductCode'] as String,
          row['ProductUnit'] as String,
          row['StockQty'] as int,
          row['SaleableQty'] as int,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['dirty'] as String);

  final InsertionAdapter<DSD_T_TruckStock_Entity>
      _dSD_T_TruckStock_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_TruckStock_Entity>
      _dSD_T_TruckStock_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_TruckStock_Entity>
      _dSD_T_TruckStock_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_TruckStock_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_TruckStock',
        mapper: _dSD_T_TruckStockMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_TruckStock WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_TruckStock');
  }

  @override
  Future<DSD_T_TruckStock_Entity> findEntityByCon(int truckId,
      String shipmentNo, String productCode, String productUnit) async {
    return _queryAdapter.query(
        'SELECT * FROM DSD_T_TruckStock WHERE truckId = ? AND shipmentNo = ? AND productCode = ? AND productUnit = ?',
        arguments: <dynamic>[truckId, shipmentNo, productCode, productUnit],
        mapper: _dSD_T_TruckStockMapper);
  }

  @override
  Future<List<DSD_T_TruckStock_Entity>> findEntityByShipment(
      String shipmentNo) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_TruckStock WHERE shipmentNo = ?',
        arguments: <dynamic>[shipmentNo],
        mapper: _dSD_T_TruckStockMapper);
  }

  @override
  Future<void> insertEntity(DSD_T_TruckStock_Entity entity) async {
    await _dSD_T_TruckStock_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_TruckStock_Entity entity) {
    return _dSD_T_TruckStock_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_TruckStock_Entity> entityList) {
    return _dSD_T_TruckStock_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_TruckStockTracking_Dao extends DSD_T_TruckStockTracking_Dao {
  _$DSD_T_TruckStockTracking_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_TruckStockTracking_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_TruckStockTracking',
            (DSD_T_TruckStockTracking_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'Id': item.Id,
                  'VisitId': item.VisitId,
                  'TruckId': item.TruckId,
                  'ShipmentNo': item.ShipmentNo,
                  'TrackingTime': item.TrackingTime,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'ChangeAction': item.ChangeAction,
                  'ChangeQuantity': item.ChangeQuantity,
                  'FromQty': item.FromQty,
                  'ToQty': item.ToQty,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                }),
        _dSD_T_TruckStockTracking_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_TruckStockTracking',
            ['pid'],
            (DSD_T_TruckStockTracking_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'Id': item.Id,
                  'VisitId': item.VisitId,
                  'TruckId': item.TruckId,
                  'ShipmentNo': item.ShipmentNo,
                  'TrackingTime': item.TrackingTime,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'ChangeAction': item.ChangeAction,
                  'ChangeQuantity': item.ChangeQuantity,
                  'FromQty': item.FromQty,
                  'ToQty': item.ToQty,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                }),
        _dSD_T_TruckStockTracking_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_TruckStockTracking',
            ['pid'],
            (DSD_T_TruckStockTracking_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'Id': item.Id,
                  'VisitId': item.VisitId,
                  'TruckId': item.TruckId,
                  'ShipmentNo': item.ShipmentNo,
                  'TrackingTime': item.TrackingTime,
                  'ProductCode': item.ProductCode,
                  'ProductUnit': item.ProductUnit,
                  'ChangeAction': item.ChangeAction,
                  'ChangeQuantity': item.ChangeQuantity,
                  'FromQty': item.FromQty,
                  'ToQty': item.ToQty,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_TruckStockTrackingMapper = (Map<String, dynamic> row) =>
      DSD_T_TruckStockTracking_Entity(
          row['pid'] as int,
          row['Id'] as String,
          row['VisitId'] as String,
          row['TruckId'] as int,
          row['ShipmentNo'] as String,
          row['TrackingTime'] as String,
          row['ProductCode'] as String,
          row['ProductUnit'] as String,
          row['ChangeAction'] as String,
          row['ChangeQuantity'] as int,
          row['FromQty'] as int,
          row['ToQty'] as int,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['dirty'] as String);

  final InsertionAdapter<DSD_T_TruckStockTracking_Entity>
      _dSD_T_TruckStockTracking_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_TruckStockTracking_Entity>
      _dSD_T_TruckStockTracking_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_TruckStockTracking_Entity>
      _dSD_T_TruckStockTracking_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_TruckStockTracking_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_TruckStockTracking',
        mapper: _dSD_T_TruckStockTrackingMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DSD_T_TruckStockTracking WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_TruckStockTracking');
  }

  @override
  Future<void> insertEntity(DSD_T_TruckStockTracking_Entity entity) async {
    await _dSD_T_TruckStockTracking_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_TruckStockTracking_Entity entity) {
    return _dSD_T_TruckStockTracking_EntityUpdateAdapter
        .updateAndReturnChangedRows(entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_TruckStockTracking_Entity> entityList) {
    return _dSD_T_TruckStockTracking_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$DSD_T_Visit_Dao extends DSD_T_Visit_Dao {
  _$DSD_T_Visit_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dSD_T_Visit_EntityInsertionAdapter = InsertionAdapter(
            database,
            'DSD_T_Visit',
            (DSD_T_Visit_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'VisitId': item.VisitId,
                  'ShipmentNo': item.ShipmentNo,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'UserCode': item.UserCode,
                  'AccountNumber': item.AccountNumber,
                  'Longitude': item.Longitude,
                  'Latitude': item.Latitude,
                  'CancelReason': item.CancelReason,
                  'NoScanReason': item.NoScanReason,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty,
                  'isCompleted': item.isCompleted
                }),
        _dSD_T_Visit_EntityUpdateAdapter = UpdateAdapter(
            database,
            'DSD_T_Visit',
            ['id'],
            (DSD_T_Visit_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'VisitId': item.VisitId,
                  'ShipmentNo': item.ShipmentNo,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'UserCode': item.UserCode,
                  'AccountNumber': item.AccountNumber,
                  'Longitude': item.Longitude,
                  'Latitude': item.Latitude,
                  'CancelReason': item.CancelReason,
                  'NoScanReason': item.NoScanReason,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty,
                  'isCompleted': item.isCompleted
                }),
        _dSD_T_Visit_EntityDeletionAdapter = DeletionAdapter(
            database,
            'DSD_T_Visit',
            ['id'],
            (DSD_T_Visit_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'VisitId': item.VisitId,
                  'ShipmentNo': item.ShipmentNo,
                  'StartTime': item.StartTime,
                  'EndTime': item.EndTime,
                  'UserCode': item.UserCode,
                  'AccountNumber': item.AccountNumber,
                  'Longitude': item.Longitude,
                  'Latitude': item.Latitude,
                  'CancelReason': item.CancelReason,
                  'NoScanReason': item.NoScanReason,
                  'CreateUser': item.CreateUser,
                  'CreateTime': item.CreateTime,
                  'LastUpdateUser': item.LastUpdateUser,
                  'LastUpdateTime': item.LastUpdateTime,
                  'dirty': item.dirty,
                  'isCompleted': item.isCompleted
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _dSD_T_VisitMapper = (Map<String, dynamic> row) =>
      DSD_T_Visit_Entity(
          row['id'] as int,
          row['VisitId'] as String,
          row['ShipmentNo'] as String,
          row['StartTime'] as String,
          row['EndTime'] as String,
          row['UserCode'] as String,
          row['AccountNumber'] as String,
          row['Longitude'] as String,
          row['Latitude'] as String,
          row['CancelReason'] as String,
          row['NoScanReason'] as String,
          row['CreateUser'] as String,
          row['CreateTime'] as String,
          row['LastUpdateUser'] as String,
          row['LastUpdateTime'] as String,
          row['dirty'] as String,
          row['isCompleted'] as String);

  final InsertionAdapter<DSD_T_Visit_Entity>
      _dSD_T_Visit_EntityInsertionAdapter;

  final UpdateAdapter<DSD_T_Visit_Entity> _dSD_T_Visit_EntityUpdateAdapter;

  final DeletionAdapter<DSD_T_Visit_Entity> _dSD_T_Visit_EntityDeletionAdapter;

  @override
  Future<List<DSD_T_Visit_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM DSD_T_Visit',
        mapper: _dSD_T_VisitMapper);
  }

  @override
  Future<DSD_T_Visit_Entity> findEntityByVisitId(String VisitId) async {
    return _queryAdapter.query('SELECT * FROM DSD_T_Visit WHERE VisitId = ?',
        arguments: <dynamic>[VisitId], mapper: _dSD_T_VisitMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_Visit WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_T_Visit');
  }

  @override
  Future<List<DSD_T_Visit_Entity>> findEntityByCon(
      String ShipmentNo, String AccountNumber) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DSD_T_Visit WHERE ShipmentNo = ? AND AccountNumber = ? ORDER BY StartTime DESC',
        arguments: <dynamic>[ShipmentNo, AccountNumber],
        mapper: _dSD_T_VisitMapper);
  }

  @override
  Future<void> insertEntity(DSD_T_Visit_Entity entity) async {
    await _dSD_T_Visit_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(DSD_T_Visit_Entity entity) {
    return _dSD_T_Visit_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<DSD_T_Visit_Entity> entityList) {
    return _dSD_T_Visit_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$MD_Account_Dao extends MD_Account_Dao {
  _$MD_Account_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mD_Account_EntityInsertionAdapter = InsertionAdapter(
            database,
            'MD_Account',
            (MD_Account_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Name': item.Name,
                  'AccountNumber': item.AccountNumber,
                  'Owner': item.Owner,
                  'RecordType': item.RecordType,
                  'Site': item.Site,
                  'AccountSource': item.AccountSource,
                  'AnnualRevenue': item.AnnualRevenue,
                  'BillingAddress': item.BillingAddress,
                  'CreatedBy': item.CreatedBy,
                  'Jigsaw': item.Jigsaw,
                  'Description': item.Description,
                  'NumberOfEmployees': item.NumberOfEmployees,
                  'Fax': item.Fax,
                  'Industry': item.Industry,
                  'LastModifiedBy': item.LastModifiedBy,
                  'Ownership': item.Ownership,
                  'Parent': item.Parent,
                  'Phone': item.Phone,
                  'Rating': item.Rating,
                  'ShippingAddress': item.ShippingAddress,
                  'Sic': item.Sic,
                  'SicDesc': item.SicDesc,
                  'TickerSymbol': item.TickerSymbol,
                  'Type': item.Type,
                  'Website': item.Website,
                  'ebMobile__AccountGroup__c': item.ebMobile__AccountGroup__c,
                  'ebMobile__AccountName1__c': item.ebMobile__AccountName1__c,
                  'ebMobile__AccountName2__c': item.ebMobile__AccountName2__c,
                  'ebMobile__AccountPartner__c':
                      item.ebMobile__AccountPartner__c,
                  'ebMobile__AccountPhotoId__c':
                      item.ebMobile__AccountPhotoId__c,
                  'ebMobile__ActivationDate__c':
                      item.ebMobile__ActivationDate__c,
                  'ebMobile__IsActive__c': item.ebMobile__IsActive__c,
                  'ebMobile__Address__c': item.ebMobile__Address__c,
                  'ebMobile__ApprovalStepsDate__c':
                      item.ebMobile__ApprovalStepsDate__c,
                  'ebMobile__BillTo__c': item.ebMobile__BillTo__c,
                  'ebMobile__BlockByCredit__c': item.ebMobile__BlockByCredit__c,
                  'ebMobile__DeliveryType__c': item.ebMobile__DeliveryType__c,
                  'ebMobile__BusinessTypeExtension__c':
                      item.ebMobile__BusinessTypeExtension__c,
                  'ebMobile__CallFrequency__c': item.ebMobile__CallFrequency__c,
                  'CallFrequencyCode__c': item.CallFrequencyCode__c,
                  'ebMobile__Category__c': item.ebMobile__Category__c,
                  'ebMobile__IsChangeByInterface__c':
                      item.ebMobile__IsChangeByInterface__c,
                  'ebMobile__CityCode__c': item.ebMobile__CityCode__c,
                  'ebMobile__Segment__c': item.ebMobile__Segment__c,
                  'ebMobile__CloseDay__c': item.ebMobile__CloseDay__c,
                  'ebMobile__ClosingTime__c': item.ebMobile__ClosingTime__c,
                  'ebMobile__Company__c': item.ebMobile__Company__c,
                  'ebMobile__CompanyCode__c': item.ebMobile__CompanyCode__c,
                  'ebMobile__CompanyDeleteFlag__c':
                      item.ebMobile__CompanyDeleteFlag__c,
                  'ebMobile__ContactEmail__c': item.ebMobile__ContactEmail__c,
                  'ebMobile__ContactMobile__c': item.ebMobile__ContactMobile__c,
                  'ebMobile__ContactPersonFunction__c':
                      item.ebMobile__ContactPersonFunction__c,
                  'ebMobile__ContactPersonName__c':
                      item.ebMobile__ContactPersonName__c,
                  'ebMobile__ContactPhone__c': item.ebMobile__ContactPhone__c,
                  'ebMobile__Country__c': item.ebMobile__Country__c,
                  'ebMobile__CountryCode__c': item.ebMobile__CountryCode__c,
                  'ebMobile__CountryKey__c': item.ebMobile__CountryKey__c,
                  'ebMobile__CreditDays__c': item.ebMobile__CreditDays__c,
                  'ebMobile__AvailableBalance__c':
                      item.ebMobile__AvailableBalance__c,
                  'ebMobile__CreditLimit__c': item.ebMobile__CreditLimit__c,
                  'ebMobile__Currency__c': item.ebMobile__Currency__c,
                  'ebMobile__CustomerConditionGroup__c':
                      item.ebMobile__CustomerConditionGroup__c,
                  'ebMobile__DeliveringPlant__c':
                      item.ebMobile__DeliveringPlant__c,
                  'ebMobile__DeliveryDate__c': item.ebMobile__DeliveryDate__c,
                  'ebMobile__DeliveryDays__c': item.ebMobile__DeliveryDays__c,
                  'ebMobile__DiscountIndicator__c':
                      item.ebMobile__DiscountIndicator__c,
                  'ebMobile__DistributionChannel__c':
                      item.ebMobile__DistributionChannel__c,
                  'ebMobile__Distributor__c': item.ebMobile__Distributor__c,
                  'ebMobile__District__c': item.ebMobile__District__c,
                  'ebMobile__Division__c': item.ebMobile__Division__c,
                  'ebMobile__ERPAccountNumber__c':
                      item.ebMobile__ERPAccountNumber__c,
                  'ExecuteBatchFlag__c': item.ExecuteBatchFlag__c,
                  'ebMobile__GeoCode__c': item.ebMobile__GeoCode__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'HasUpdatedAR__c': item.HasUpdatedAR__c,
                  'ebMobile__HouseNumber__c': item.ebMobile__HouseNumber__c,
                  'ebMobile__InvestmentValue__c':
                      item.ebMobile__InvestmentValue__c,
                  'ebMobile__InvoiceCalendar__c':
                      item.ebMobile__InvoiceCalendar__c,
                  'IsPush__c': item.IsPush__c,
                  'ebMobile__KeyAccount__c': item.ebMobile__KeyAccount__c,
                  'KeyAccount__c': item.KeyAccount__c,
                  'Last3MonthsVolume__c': item.Last3MonthsVolume__c,
                  'ebMobile__Last3MonthsVolume__c':
                      item.ebMobile__Last3MonthsVolume__c,
                  'ebMobile__LastCallDate__c': item.ebMobile__LastCallDate__c,
                  'ebMobile__LastOrderDate__c': item.ebMobile__LastOrderDate__c,
                  'ebMobile__LastOrderTotalPrice__c':
                      item.ebMobile__LastOrderTotalPrice__c,
                  'ebMobile__LastOrderTotalQuantity__c':
                      item.ebMobile__LastOrderTotalQuantity__c,
                  'ebMobile__MEPCustomerNumber__c':
                      item.ebMobile__MEPCustomerNumber__c,
                  'ebMobile__OpeningTime__c': item.ebMobile__OpeningTime__c,
                  'ebMobile__OpenItemsAgingStart__c':
                      item.ebMobile__OpenItemsAgingStart__c,
                  'ebMobile__OperationalMarketType__c':
                      item.ebMobile__OperationalMarketType__c,
                  'ebMobile__OperationalTradeChannel__c':
                      item.ebMobile__OperationalTradeChannel__c,
                  'ebMobile__OrderBlock__c': item.ebMobile__OrderBlock__c,
                  'ebMobile__Owner_Role__c': item.ebMobile__Owner_Role__c,
                  'ebMobile__P3MAVGSales__c': item.ebMobile__P3MAVGSales__c,
                  'ebMobile__PartnerFunction__c':
                      item.ebMobile__PartnerFunction__c,
                  'ebMobile__Payer__c': item.ebMobile__Payer__c,
                  'ebMobile__PaymentTerms__c': item.ebMobile__PaymentTerms__c,
                  'ebMobile__PONumber__c': item.ebMobile__PONumber__c,
                  'ebMobile__Postal__c': item.ebMobile__Postal__c,
                  'ebMobile__PriceAttribute__c':
                      item.ebMobile__PriceAttribute__c,
                  'ebMobile__PriceClassID__c': item.ebMobile__PriceClassID__c,
                  'ebMobile__PriceGroup__c': item.ebMobile__PriceGroup__c,
                  'ebMobile__PriceListType__c': item.ebMobile__PriceListType__c,
                  'ebMobile__PricingProcedure__c':
                      item.ebMobile__PricingProcedure__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'ebMobile__RecordTypeName__c':
                      item.ebMobile__RecordTypeName__c,
                  'RedIndecator__c': item.RedIndecator__c,
                  'ebMobile__Region__c': item.ebMobile__Region__c,
                  'ebMobile__RegistrationNumber__c':
                      item.ebMobile__RegistrationNumber__c,
                  'ebMobile__SalesDistrict__c': item.ebMobile__SalesDistrict__c,
                  'ebMobile__SaleGroup__c': item.ebMobile__SaleGroup__c,
                  'ebMobile__SalesOffice__c': item.ebMobile__SalesOffice__c,
                  'ebMobile__SalesOrg__c': item.ebMobile__SalesOrg__c,
                  'ebMobile__SalesOrgCode__c': item.ebMobile__SalesOrgCode__c,
                  'ebMobile__User__c': item.ebMobile__User__c,
                  'ebMobile__SalesRoute__c': item.ebMobile__SalesRoute__c,
                  'ebMobile__ShippingCondition__c':
                      item.ebMobile__ShippingCondition__c,
                  'ShippingConditionCode__c': item.ShippingConditionCode__c,
                  'ebMobile__ShipTo__c': item.ebMobile__ShipTo__c,
                  'ebMobile__State__c': item.ebMobile__State__c,
                  'ebMobile__Street__c': item.ebMobile__Street__c,
                  'ebMobile__Street4__c': item.ebMobile__Street4__c,
                  'ebMobile__Street5__c': item.ebMobile__Street5__c,
                  'ebMobile__StreetNumber__c': item.ebMobile__StreetNumber__c,
                  'ebMobile__SubTradeChannel__c':
                      item.ebMobile__SubTradeChannel__c,
                  'ebMobile__SuppressionReason__c':
                      item.ebMobile__SuppressionReason__c,
                  'ebMobile__SuspressionCode__c':
                      item.ebMobile__SuspressionCode__c,
                  'ebMobile__SuspressionDate__c':
                      item.ebMobile__SuspressionDate__c,
                  'ebMobile__TargetGroup__c': item.ebMobile__TargetGroup__c,
                  'ebMobile__TaxCode__c': item.ebMobile__TaxCode__c,
                  'ebMobile__TaxNumber__c': item.ebMobile__TaxNumber__c,
                  'ebMobile__TotalOpenAmount__c':
                      item.ebMobile__TotalOpenAmount__c,
                  'ebMobile__TradeChannel__c': item.ebMobile__TradeChannel__c,
                  'ebMobile__TradeGroup__c': item.ebMobile__TradeGroup__c,
                  'ebMobile__TradeName__c': item.ebMobile__TradeName__c,
                  'TransportationZone__c': item.TransportationZone__c,
                  'ebMobile__UniqueKey__c': item.ebMobile__UniqueKey__c,
                  'ebMobile__VATNumber__c': item.ebMobile__VATNumber__c,
                  'ebMobile__Vendor__c': item.ebMobile__Vendor__c,
                  'CCSM_VendorNo__c': item.CCSM_VendorNo__c,
                  'ebMobile__VisitStartDate__c':
                      item.ebMobile__VisitStartDate__c,
                  'ebMobile__ZAPartner__c': item.ebMobile__ZAPartner__c,
                  'ebMobile__ZBPartner__c': item.ebMobile__ZBPartner__c,
                  'ebMobile__ZGPartner__c': item.ebMobile__ZGPartner__c,
                  'ebMobile__ZHPartner__c': item.ebMobile__ZHPartner__c,
                  'ebMobile__ZIPartner__c': item.ebMobile__ZIPartner__c,
                  'ebMobile__ZNPartner__c': item.ebMobile__ZNPartner__c,
                  'ebMobile__ZQPartner__c': item.ebMobile__ZQPartner__c,
                  'ebMobile__ZRPartner__c': item.ebMobile__ZRPartner__c,
                  'ebMobile__ZTPartner__c': item.ebMobile__ZTPartner__c,
                  'ebMobile__ZXCrossDock__c': item.ebMobile__ZXCrossDock__c,
                  'Geo_Longitude': item.Geo_Longitude,
                  'Geo_Latitude': item.Geo_Latitude,
                  'ProductList': item.ProductList,
                  'ebMobile__Barcode__c': item.ebMobile__Barcode__c,
                  'RouteNumber': item.RouteNumber,
                  'ebMobile__ScanStoreMandatory__c':
                      item.ebMobile__ScanStoreMandatory__c,
                  'ebMobile__RouteJumping__c': item.ebMobile__RouteJumping__c,
                  'ShippingCity': item.ShippingCity,
                  'ShippingPostalCode': item.ShippingPostalCode,
                  'Route': item.Route,
                  'ArabicName__c': item.ArabicName__c,
                  'ArabicStreet__c': item.ArabicStreet__c,
                  'ArabicCity__c': item.ArabicCity__c,
                  'ArabicCountry__c': item.ArabicCountry__c,
                  'VATRegistrationNo': item.VATRegistrationNo,
                  'NoteToDriver__c': item.NoteToDriver__c,
                  'Usercode': item.Usercode,
                  'LastTime': item.LastTime,
                  'dirty': item.dirty
                }),
        _mD_Account_EntityUpdateAdapter = UpdateAdapter(
            database,
            'MD_Account',
            ['id'],
            (MD_Account_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Name': item.Name,
                  'AccountNumber': item.AccountNumber,
                  'Owner': item.Owner,
                  'RecordType': item.RecordType,
                  'Site': item.Site,
                  'AccountSource': item.AccountSource,
                  'AnnualRevenue': item.AnnualRevenue,
                  'BillingAddress': item.BillingAddress,
                  'CreatedBy': item.CreatedBy,
                  'Jigsaw': item.Jigsaw,
                  'Description': item.Description,
                  'NumberOfEmployees': item.NumberOfEmployees,
                  'Fax': item.Fax,
                  'Industry': item.Industry,
                  'LastModifiedBy': item.LastModifiedBy,
                  'Ownership': item.Ownership,
                  'Parent': item.Parent,
                  'Phone': item.Phone,
                  'Rating': item.Rating,
                  'ShippingAddress': item.ShippingAddress,
                  'Sic': item.Sic,
                  'SicDesc': item.SicDesc,
                  'TickerSymbol': item.TickerSymbol,
                  'Type': item.Type,
                  'Website': item.Website,
                  'ebMobile__AccountGroup__c': item.ebMobile__AccountGroup__c,
                  'ebMobile__AccountName1__c': item.ebMobile__AccountName1__c,
                  'ebMobile__AccountName2__c': item.ebMobile__AccountName2__c,
                  'ebMobile__AccountPartner__c':
                      item.ebMobile__AccountPartner__c,
                  'ebMobile__AccountPhotoId__c':
                      item.ebMobile__AccountPhotoId__c,
                  'ebMobile__ActivationDate__c':
                      item.ebMobile__ActivationDate__c,
                  'ebMobile__IsActive__c': item.ebMobile__IsActive__c,
                  'ebMobile__Address__c': item.ebMobile__Address__c,
                  'ebMobile__ApprovalStepsDate__c':
                      item.ebMobile__ApprovalStepsDate__c,
                  'ebMobile__BillTo__c': item.ebMobile__BillTo__c,
                  'ebMobile__BlockByCredit__c': item.ebMobile__BlockByCredit__c,
                  'ebMobile__DeliveryType__c': item.ebMobile__DeliveryType__c,
                  'ebMobile__BusinessTypeExtension__c':
                      item.ebMobile__BusinessTypeExtension__c,
                  'ebMobile__CallFrequency__c': item.ebMobile__CallFrequency__c,
                  'CallFrequencyCode__c': item.CallFrequencyCode__c,
                  'ebMobile__Category__c': item.ebMobile__Category__c,
                  'ebMobile__IsChangeByInterface__c':
                      item.ebMobile__IsChangeByInterface__c,
                  'ebMobile__CityCode__c': item.ebMobile__CityCode__c,
                  'ebMobile__Segment__c': item.ebMobile__Segment__c,
                  'ebMobile__CloseDay__c': item.ebMobile__CloseDay__c,
                  'ebMobile__ClosingTime__c': item.ebMobile__ClosingTime__c,
                  'ebMobile__Company__c': item.ebMobile__Company__c,
                  'ebMobile__CompanyCode__c': item.ebMobile__CompanyCode__c,
                  'ebMobile__CompanyDeleteFlag__c':
                      item.ebMobile__CompanyDeleteFlag__c,
                  'ebMobile__ContactEmail__c': item.ebMobile__ContactEmail__c,
                  'ebMobile__ContactMobile__c': item.ebMobile__ContactMobile__c,
                  'ebMobile__ContactPersonFunction__c':
                      item.ebMobile__ContactPersonFunction__c,
                  'ebMobile__ContactPersonName__c':
                      item.ebMobile__ContactPersonName__c,
                  'ebMobile__ContactPhone__c': item.ebMobile__ContactPhone__c,
                  'ebMobile__Country__c': item.ebMobile__Country__c,
                  'ebMobile__CountryCode__c': item.ebMobile__CountryCode__c,
                  'ebMobile__CountryKey__c': item.ebMobile__CountryKey__c,
                  'ebMobile__CreditDays__c': item.ebMobile__CreditDays__c,
                  'ebMobile__AvailableBalance__c':
                      item.ebMobile__AvailableBalance__c,
                  'ebMobile__CreditLimit__c': item.ebMobile__CreditLimit__c,
                  'ebMobile__Currency__c': item.ebMobile__Currency__c,
                  'ebMobile__CustomerConditionGroup__c':
                      item.ebMobile__CustomerConditionGroup__c,
                  'ebMobile__DeliveringPlant__c':
                      item.ebMobile__DeliveringPlant__c,
                  'ebMobile__DeliveryDate__c': item.ebMobile__DeliveryDate__c,
                  'ebMobile__DeliveryDays__c': item.ebMobile__DeliveryDays__c,
                  'ebMobile__DiscountIndicator__c':
                      item.ebMobile__DiscountIndicator__c,
                  'ebMobile__DistributionChannel__c':
                      item.ebMobile__DistributionChannel__c,
                  'ebMobile__Distributor__c': item.ebMobile__Distributor__c,
                  'ebMobile__District__c': item.ebMobile__District__c,
                  'ebMobile__Division__c': item.ebMobile__Division__c,
                  'ebMobile__ERPAccountNumber__c':
                      item.ebMobile__ERPAccountNumber__c,
                  'ExecuteBatchFlag__c': item.ExecuteBatchFlag__c,
                  'ebMobile__GeoCode__c': item.ebMobile__GeoCode__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'HasUpdatedAR__c': item.HasUpdatedAR__c,
                  'ebMobile__HouseNumber__c': item.ebMobile__HouseNumber__c,
                  'ebMobile__InvestmentValue__c':
                      item.ebMobile__InvestmentValue__c,
                  'ebMobile__InvoiceCalendar__c':
                      item.ebMobile__InvoiceCalendar__c,
                  'IsPush__c': item.IsPush__c,
                  'ebMobile__KeyAccount__c': item.ebMobile__KeyAccount__c,
                  'KeyAccount__c': item.KeyAccount__c,
                  'Last3MonthsVolume__c': item.Last3MonthsVolume__c,
                  'ebMobile__Last3MonthsVolume__c':
                      item.ebMobile__Last3MonthsVolume__c,
                  'ebMobile__LastCallDate__c': item.ebMobile__LastCallDate__c,
                  'ebMobile__LastOrderDate__c': item.ebMobile__LastOrderDate__c,
                  'ebMobile__LastOrderTotalPrice__c':
                      item.ebMobile__LastOrderTotalPrice__c,
                  'ebMobile__LastOrderTotalQuantity__c':
                      item.ebMobile__LastOrderTotalQuantity__c,
                  'ebMobile__MEPCustomerNumber__c':
                      item.ebMobile__MEPCustomerNumber__c,
                  'ebMobile__OpeningTime__c': item.ebMobile__OpeningTime__c,
                  'ebMobile__OpenItemsAgingStart__c':
                      item.ebMobile__OpenItemsAgingStart__c,
                  'ebMobile__OperationalMarketType__c':
                      item.ebMobile__OperationalMarketType__c,
                  'ebMobile__OperationalTradeChannel__c':
                      item.ebMobile__OperationalTradeChannel__c,
                  'ebMobile__OrderBlock__c': item.ebMobile__OrderBlock__c,
                  'ebMobile__Owner_Role__c': item.ebMobile__Owner_Role__c,
                  'ebMobile__P3MAVGSales__c': item.ebMobile__P3MAVGSales__c,
                  'ebMobile__PartnerFunction__c':
                      item.ebMobile__PartnerFunction__c,
                  'ebMobile__Payer__c': item.ebMobile__Payer__c,
                  'ebMobile__PaymentTerms__c': item.ebMobile__PaymentTerms__c,
                  'ebMobile__PONumber__c': item.ebMobile__PONumber__c,
                  'ebMobile__Postal__c': item.ebMobile__Postal__c,
                  'ebMobile__PriceAttribute__c':
                      item.ebMobile__PriceAttribute__c,
                  'ebMobile__PriceClassID__c': item.ebMobile__PriceClassID__c,
                  'ebMobile__PriceGroup__c': item.ebMobile__PriceGroup__c,
                  'ebMobile__PriceListType__c': item.ebMobile__PriceListType__c,
                  'ebMobile__PricingProcedure__c':
                      item.ebMobile__PricingProcedure__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'ebMobile__RecordTypeName__c':
                      item.ebMobile__RecordTypeName__c,
                  'RedIndecator__c': item.RedIndecator__c,
                  'ebMobile__Region__c': item.ebMobile__Region__c,
                  'ebMobile__RegistrationNumber__c':
                      item.ebMobile__RegistrationNumber__c,
                  'ebMobile__SalesDistrict__c': item.ebMobile__SalesDistrict__c,
                  'ebMobile__SaleGroup__c': item.ebMobile__SaleGroup__c,
                  'ebMobile__SalesOffice__c': item.ebMobile__SalesOffice__c,
                  'ebMobile__SalesOrg__c': item.ebMobile__SalesOrg__c,
                  'ebMobile__SalesOrgCode__c': item.ebMobile__SalesOrgCode__c,
                  'ebMobile__User__c': item.ebMobile__User__c,
                  'ebMobile__SalesRoute__c': item.ebMobile__SalesRoute__c,
                  'ebMobile__ShippingCondition__c':
                      item.ebMobile__ShippingCondition__c,
                  'ShippingConditionCode__c': item.ShippingConditionCode__c,
                  'ebMobile__ShipTo__c': item.ebMobile__ShipTo__c,
                  'ebMobile__State__c': item.ebMobile__State__c,
                  'ebMobile__Street__c': item.ebMobile__Street__c,
                  'ebMobile__Street4__c': item.ebMobile__Street4__c,
                  'ebMobile__Street5__c': item.ebMobile__Street5__c,
                  'ebMobile__StreetNumber__c': item.ebMobile__StreetNumber__c,
                  'ebMobile__SubTradeChannel__c':
                      item.ebMobile__SubTradeChannel__c,
                  'ebMobile__SuppressionReason__c':
                      item.ebMobile__SuppressionReason__c,
                  'ebMobile__SuspressionCode__c':
                      item.ebMobile__SuspressionCode__c,
                  'ebMobile__SuspressionDate__c':
                      item.ebMobile__SuspressionDate__c,
                  'ebMobile__TargetGroup__c': item.ebMobile__TargetGroup__c,
                  'ebMobile__TaxCode__c': item.ebMobile__TaxCode__c,
                  'ebMobile__TaxNumber__c': item.ebMobile__TaxNumber__c,
                  'ebMobile__TotalOpenAmount__c':
                      item.ebMobile__TotalOpenAmount__c,
                  'ebMobile__TradeChannel__c': item.ebMobile__TradeChannel__c,
                  'ebMobile__TradeGroup__c': item.ebMobile__TradeGroup__c,
                  'ebMobile__TradeName__c': item.ebMobile__TradeName__c,
                  'TransportationZone__c': item.TransportationZone__c,
                  'ebMobile__UniqueKey__c': item.ebMobile__UniqueKey__c,
                  'ebMobile__VATNumber__c': item.ebMobile__VATNumber__c,
                  'ebMobile__Vendor__c': item.ebMobile__Vendor__c,
                  'CCSM_VendorNo__c': item.CCSM_VendorNo__c,
                  'ebMobile__VisitStartDate__c':
                      item.ebMobile__VisitStartDate__c,
                  'ebMobile__ZAPartner__c': item.ebMobile__ZAPartner__c,
                  'ebMobile__ZBPartner__c': item.ebMobile__ZBPartner__c,
                  'ebMobile__ZGPartner__c': item.ebMobile__ZGPartner__c,
                  'ebMobile__ZHPartner__c': item.ebMobile__ZHPartner__c,
                  'ebMobile__ZIPartner__c': item.ebMobile__ZIPartner__c,
                  'ebMobile__ZNPartner__c': item.ebMobile__ZNPartner__c,
                  'ebMobile__ZQPartner__c': item.ebMobile__ZQPartner__c,
                  'ebMobile__ZRPartner__c': item.ebMobile__ZRPartner__c,
                  'ebMobile__ZTPartner__c': item.ebMobile__ZTPartner__c,
                  'ebMobile__ZXCrossDock__c': item.ebMobile__ZXCrossDock__c,
                  'Geo_Longitude': item.Geo_Longitude,
                  'Geo_Latitude': item.Geo_Latitude,
                  'ProductList': item.ProductList,
                  'ebMobile__Barcode__c': item.ebMobile__Barcode__c,
                  'RouteNumber': item.RouteNumber,
                  'ebMobile__ScanStoreMandatory__c':
                      item.ebMobile__ScanStoreMandatory__c,
                  'ebMobile__RouteJumping__c': item.ebMobile__RouteJumping__c,
                  'ShippingCity': item.ShippingCity,
                  'ShippingPostalCode': item.ShippingPostalCode,
                  'Route': item.Route,
                  'ArabicName__c': item.ArabicName__c,
                  'ArabicStreet__c': item.ArabicStreet__c,
                  'ArabicCity__c': item.ArabicCity__c,
                  'ArabicCountry__c': item.ArabicCountry__c,
                  'VATRegistrationNo': item.VATRegistrationNo,
                  'NoteToDriver__c': item.NoteToDriver__c,
                  'Usercode': item.Usercode,
                  'LastTime': item.LastTime,
                  'dirty': item.dirty
                }),
        _mD_Account_EntityDeletionAdapter = DeletionAdapter(
            database,
            'MD_Account',
            ['id'],
            (MD_Account_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Name': item.Name,
                  'AccountNumber': item.AccountNumber,
                  'Owner': item.Owner,
                  'RecordType': item.RecordType,
                  'Site': item.Site,
                  'AccountSource': item.AccountSource,
                  'AnnualRevenue': item.AnnualRevenue,
                  'BillingAddress': item.BillingAddress,
                  'CreatedBy': item.CreatedBy,
                  'Jigsaw': item.Jigsaw,
                  'Description': item.Description,
                  'NumberOfEmployees': item.NumberOfEmployees,
                  'Fax': item.Fax,
                  'Industry': item.Industry,
                  'LastModifiedBy': item.LastModifiedBy,
                  'Ownership': item.Ownership,
                  'Parent': item.Parent,
                  'Phone': item.Phone,
                  'Rating': item.Rating,
                  'ShippingAddress': item.ShippingAddress,
                  'Sic': item.Sic,
                  'SicDesc': item.SicDesc,
                  'TickerSymbol': item.TickerSymbol,
                  'Type': item.Type,
                  'Website': item.Website,
                  'ebMobile__AccountGroup__c': item.ebMobile__AccountGroup__c,
                  'ebMobile__AccountName1__c': item.ebMobile__AccountName1__c,
                  'ebMobile__AccountName2__c': item.ebMobile__AccountName2__c,
                  'ebMobile__AccountPartner__c':
                      item.ebMobile__AccountPartner__c,
                  'ebMobile__AccountPhotoId__c':
                      item.ebMobile__AccountPhotoId__c,
                  'ebMobile__ActivationDate__c':
                      item.ebMobile__ActivationDate__c,
                  'ebMobile__IsActive__c': item.ebMobile__IsActive__c,
                  'ebMobile__Address__c': item.ebMobile__Address__c,
                  'ebMobile__ApprovalStepsDate__c':
                      item.ebMobile__ApprovalStepsDate__c,
                  'ebMobile__BillTo__c': item.ebMobile__BillTo__c,
                  'ebMobile__BlockByCredit__c': item.ebMobile__BlockByCredit__c,
                  'ebMobile__DeliveryType__c': item.ebMobile__DeliveryType__c,
                  'ebMobile__BusinessTypeExtension__c':
                      item.ebMobile__BusinessTypeExtension__c,
                  'ebMobile__CallFrequency__c': item.ebMobile__CallFrequency__c,
                  'CallFrequencyCode__c': item.CallFrequencyCode__c,
                  'ebMobile__Category__c': item.ebMobile__Category__c,
                  'ebMobile__IsChangeByInterface__c':
                      item.ebMobile__IsChangeByInterface__c,
                  'ebMobile__CityCode__c': item.ebMobile__CityCode__c,
                  'ebMobile__Segment__c': item.ebMobile__Segment__c,
                  'ebMobile__CloseDay__c': item.ebMobile__CloseDay__c,
                  'ebMobile__ClosingTime__c': item.ebMobile__ClosingTime__c,
                  'ebMobile__Company__c': item.ebMobile__Company__c,
                  'ebMobile__CompanyCode__c': item.ebMobile__CompanyCode__c,
                  'ebMobile__CompanyDeleteFlag__c':
                      item.ebMobile__CompanyDeleteFlag__c,
                  'ebMobile__ContactEmail__c': item.ebMobile__ContactEmail__c,
                  'ebMobile__ContactMobile__c': item.ebMobile__ContactMobile__c,
                  'ebMobile__ContactPersonFunction__c':
                      item.ebMobile__ContactPersonFunction__c,
                  'ebMobile__ContactPersonName__c':
                      item.ebMobile__ContactPersonName__c,
                  'ebMobile__ContactPhone__c': item.ebMobile__ContactPhone__c,
                  'ebMobile__Country__c': item.ebMobile__Country__c,
                  'ebMobile__CountryCode__c': item.ebMobile__CountryCode__c,
                  'ebMobile__CountryKey__c': item.ebMobile__CountryKey__c,
                  'ebMobile__CreditDays__c': item.ebMobile__CreditDays__c,
                  'ebMobile__AvailableBalance__c':
                      item.ebMobile__AvailableBalance__c,
                  'ebMobile__CreditLimit__c': item.ebMobile__CreditLimit__c,
                  'ebMobile__Currency__c': item.ebMobile__Currency__c,
                  'ebMobile__CustomerConditionGroup__c':
                      item.ebMobile__CustomerConditionGroup__c,
                  'ebMobile__DeliveringPlant__c':
                      item.ebMobile__DeliveringPlant__c,
                  'ebMobile__DeliveryDate__c': item.ebMobile__DeliveryDate__c,
                  'ebMobile__DeliveryDays__c': item.ebMobile__DeliveryDays__c,
                  'ebMobile__DiscountIndicator__c':
                      item.ebMobile__DiscountIndicator__c,
                  'ebMobile__DistributionChannel__c':
                      item.ebMobile__DistributionChannel__c,
                  'ebMobile__Distributor__c': item.ebMobile__Distributor__c,
                  'ebMobile__District__c': item.ebMobile__District__c,
                  'ebMobile__Division__c': item.ebMobile__Division__c,
                  'ebMobile__ERPAccountNumber__c':
                      item.ebMobile__ERPAccountNumber__c,
                  'ExecuteBatchFlag__c': item.ExecuteBatchFlag__c,
                  'ebMobile__GeoCode__c': item.ebMobile__GeoCode__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'HasUpdatedAR__c': item.HasUpdatedAR__c,
                  'ebMobile__HouseNumber__c': item.ebMobile__HouseNumber__c,
                  'ebMobile__InvestmentValue__c':
                      item.ebMobile__InvestmentValue__c,
                  'ebMobile__InvoiceCalendar__c':
                      item.ebMobile__InvoiceCalendar__c,
                  'IsPush__c': item.IsPush__c,
                  'ebMobile__KeyAccount__c': item.ebMobile__KeyAccount__c,
                  'KeyAccount__c': item.KeyAccount__c,
                  'Last3MonthsVolume__c': item.Last3MonthsVolume__c,
                  'ebMobile__Last3MonthsVolume__c':
                      item.ebMobile__Last3MonthsVolume__c,
                  'ebMobile__LastCallDate__c': item.ebMobile__LastCallDate__c,
                  'ebMobile__LastOrderDate__c': item.ebMobile__LastOrderDate__c,
                  'ebMobile__LastOrderTotalPrice__c':
                      item.ebMobile__LastOrderTotalPrice__c,
                  'ebMobile__LastOrderTotalQuantity__c':
                      item.ebMobile__LastOrderTotalQuantity__c,
                  'ebMobile__MEPCustomerNumber__c':
                      item.ebMobile__MEPCustomerNumber__c,
                  'ebMobile__OpeningTime__c': item.ebMobile__OpeningTime__c,
                  'ebMobile__OpenItemsAgingStart__c':
                      item.ebMobile__OpenItemsAgingStart__c,
                  'ebMobile__OperationalMarketType__c':
                      item.ebMobile__OperationalMarketType__c,
                  'ebMobile__OperationalTradeChannel__c':
                      item.ebMobile__OperationalTradeChannel__c,
                  'ebMobile__OrderBlock__c': item.ebMobile__OrderBlock__c,
                  'ebMobile__Owner_Role__c': item.ebMobile__Owner_Role__c,
                  'ebMobile__P3MAVGSales__c': item.ebMobile__P3MAVGSales__c,
                  'ebMobile__PartnerFunction__c':
                      item.ebMobile__PartnerFunction__c,
                  'ebMobile__Payer__c': item.ebMobile__Payer__c,
                  'ebMobile__PaymentTerms__c': item.ebMobile__PaymentTerms__c,
                  'ebMobile__PONumber__c': item.ebMobile__PONumber__c,
                  'ebMobile__Postal__c': item.ebMobile__Postal__c,
                  'ebMobile__PriceAttribute__c':
                      item.ebMobile__PriceAttribute__c,
                  'ebMobile__PriceClassID__c': item.ebMobile__PriceClassID__c,
                  'ebMobile__PriceGroup__c': item.ebMobile__PriceGroup__c,
                  'ebMobile__PriceListType__c': item.ebMobile__PriceListType__c,
                  'ebMobile__PricingProcedure__c':
                      item.ebMobile__PricingProcedure__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'ebMobile__RecordTypeName__c':
                      item.ebMobile__RecordTypeName__c,
                  'RedIndecator__c': item.RedIndecator__c,
                  'ebMobile__Region__c': item.ebMobile__Region__c,
                  'ebMobile__RegistrationNumber__c':
                      item.ebMobile__RegistrationNumber__c,
                  'ebMobile__SalesDistrict__c': item.ebMobile__SalesDistrict__c,
                  'ebMobile__SaleGroup__c': item.ebMobile__SaleGroup__c,
                  'ebMobile__SalesOffice__c': item.ebMobile__SalesOffice__c,
                  'ebMobile__SalesOrg__c': item.ebMobile__SalesOrg__c,
                  'ebMobile__SalesOrgCode__c': item.ebMobile__SalesOrgCode__c,
                  'ebMobile__User__c': item.ebMobile__User__c,
                  'ebMobile__SalesRoute__c': item.ebMobile__SalesRoute__c,
                  'ebMobile__ShippingCondition__c':
                      item.ebMobile__ShippingCondition__c,
                  'ShippingConditionCode__c': item.ShippingConditionCode__c,
                  'ebMobile__ShipTo__c': item.ebMobile__ShipTo__c,
                  'ebMobile__State__c': item.ebMobile__State__c,
                  'ebMobile__Street__c': item.ebMobile__Street__c,
                  'ebMobile__Street4__c': item.ebMobile__Street4__c,
                  'ebMobile__Street5__c': item.ebMobile__Street5__c,
                  'ebMobile__StreetNumber__c': item.ebMobile__StreetNumber__c,
                  'ebMobile__SubTradeChannel__c':
                      item.ebMobile__SubTradeChannel__c,
                  'ebMobile__SuppressionReason__c':
                      item.ebMobile__SuppressionReason__c,
                  'ebMobile__SuspressionCode__c':
                      item.ebMobile__SuspressionCode__c,
                  'ebMobile__SuspressionDate__c':
                      item.ebMobile__SuspressionDate__c,
                  'ebMobile__TargetGroup__c': item.ebMobile__TargetGroup__c,
                  'ebMobile__TaxCode__c': item.ebMobile__TaxCode__c,
                  'ebMobile__TaxNumber__c': item.ebMobile__TaxNumber__c,
                  'ebMobile__TotalOpenAmount__c':
                      item.ebMobile__TotalOpenAmount__c,
                  'ebMobile__TradeChannel__c': item.ebMobile__TradeChannel__c,
                  'ebMobile__TradeGroup__c': item.ebMobile__TradeGroup__c,
                  'ebMobile__TradeName__c': item.ebMobile__TradeName__c,
                  'TransportationZone__c': item.TransportationZone__c,
                  'ebMobile__UniqueKey__c': item.ebMobile__UniqueKey__c,
                  'ebMobile__VATNumber__c': item.ebMobile__VATNumber__c,
                  'ebMobile__Vendor__c': item.ebMobile__Vendor__c,
                  'CCSM_VendorNo__c': item.CCSM_VendorNo__c,
                  'ebMobile__VisitStartDate__c':
                      item.ebMobile__VisitStartDate__c,
                  'ebMobile__ZAPartner__c': item.ebMobile__ZAPartner__c,
                  'ebMobile__ZBPartner__c': item.ebMobile__ZBPartner__c,
                  'ebMobile__ZGPartner__c': item.ebMobile__ZGPartner__c,
                  'ebMobile__ZHPartner__c': item.ebMobile__ZHPartner__c,
                  'ebMobile__ZIPartner__c': item.ebMobile__ZIPartner__c,
                  'ebMobile__ZNPartner__c': item.ebMobile__ZNPartner__c,
                  'ebMobile__ZQPartner__c': item.ebMobile__ZQPartner__c,
                  'ebMobile__ZRPartner__c': item.ebMobile__ZRPartner__c,
                  'ebMobile__ZTPartner__c': item.ebMobile__ZTPartner__c,
                  'ebMobile__ZXCrossDock__c': item.ebMobile__ZXCrossDock__c,
                  'Geo_Longitude': item.Geo_Longitude,
                  'Geo_Latitude': item.Geo_Latitude,
                  'ProductList': item.ProductList,
                  'ebMobile__Barcode__c': item.ebMobile__Barcode__c,
                  'RouteNumber': item.RouteNumber,
                  'ebMobile__ScanStoreMandatory__c':
                      item.ebMobile__ScanStoreMandatory__c,
                  'ebMobile__RouteJumping__c': item.ebMobile__RouteJumping__c,
                  'ShippingCity': item.ShippingCity,
                  'ShippingPostalCode': item.ShippingPostalCode,
                  'Route': item.Route,
                  'ArabicName__c': item.ArabicName__c,
                  'ArabicStreet__c': item.ArabicStreet__c,
                  'ArabicCity__c': item.ArabicCity__c,
                  'ArabicCountry__c': item.ArabicCountry__c,
                  'VATRegistrationNo': item.VATRegistrationNo,
                  'NoteToDriver__c': item.NoteToDriver__c,
                  'Usercode': item.Usercode,
                  'LastTime': item.LastTime,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _mD_AccountMapper = (Map<String, dynamic> row) =>
      MD_Account_Entity(
          row['id'] as int,
          row['Name'] as String,
          row['AccountNumber'] as String,
          row['Owner'] as String,
          row['RecordType'] as String,
          row['Site'] as String,
          row['AccountSource'] as String,
          row['AnnualRevenue'] as String,
          row['BillingAddress'] as String,
          row['CreatedBy'] as String,
          row['Jigsaw'] as String,
          row['Description'] as String,
          row['NumberOfEmployees'] as String,
          row['Fax'] as String,
          row['Industry'] as String,
          row['LastModifiedBy'] as String,
          row['Ownership'] as String,
          row['Parent'] as String,
          row['Phone'] as String,
          row['Rating'] as String,
          row['ShippingAddress'] as String,
          row['Sic'] as String,
          row['SicDesc'] as String,
          row['TickerSymbol'] as String,
          row['Type'] as String,
          row['Website'] as String,
          row['ebMobile__AccountGroup__c'] as String,
          row['ebMobile__AccountName1__c'] as String,
          row['ebMobile__AccountName2__c'] as String,
          row['ebMobile__AccountPartner__c'] as String,
          row['ebMobile__AccountPhotoId__c'] as String,
          row['ebMobile__ActivationDate__c'] as String,
          row['ebMobile__IsActive__c'] as String,
          row['ebMobile__Address__c'] as String,
          row['ebMobile__ApprovalStepsDate__c'] as String,
          row['ebMobile__BillTo__c'] as String,
          row['ebMobile__BlockByCredit__c'] as String,
          row['ebMobile__DeliveryType__c'] as String,
          row['ebMobile__BusinessTypeExtension__c'] as String,
          row['ebMobile__CallFrequency__c'] as String,
          row['CallFrequencyCode__c'] as String,
          row['ebMobile__Category__c'] as String,
          row['ebMobile__IsChangeByInterface__c'] as String,
          row['ebMobile__CityCode__c'] as String,
          row['ebMobile__Segment__c'] as String,
          row['ebMobile__CloseDay__c'] as String,
          row['ebMobile__ClosingTime__c'] as String,
          row['ebMobile__Company__c'] as String,
          row['ebMobile__CompanyCode__c'] as String,
          row['ebMobile__CompanyDeleteFlag__c'] as String,
          row['ebMobile__ContactEmail__c'] as String,
          row['ebMobile__ContactMobile__c'] as String,
          row['ebMobile__ContactPersonFunction__c'] as String,
          row['ebMobile__ContactPersonName__c'] as String,
          row['ebMobile__ContactPhone__c'] as String,
          row['ebMobile__Country__c'] as String,
          row['ebMobile__CountryCode__c'] as String,
          row['ebMobile__CountryKey__c'] as String,
          row['ebMobile__CreditDays__c'] as String,
          row['ebMobile__AvailableBalance__c'] as String,
          row['ebMobile__CreditLimit__c'] as String,
          row['ebMobile__Currency__c'] as String,
          row['ebMobile__CustomerConditionGroup__c'] as String,
          row['ebMobile__DeliveringPlant__c'] as String,
          row['ebMobile__DeliveryDate__c'] as String,
          row['ebMobile__DeliveryDays__c'] as String,
          row['ebMobile__DiscountIndicator__c'] as String,
          row['ebMobile__DistributionChannel__c'] as String,
          row['ebMobile__Distributor__c'] as String,
          row['ebMobile__District__c'] as String,
          row['ebMobile__Division__c'] as String,
          row['ebMobile__ERPAccountNumber__c'] as String,
          row['ExecuteBatchFlag__c'] as String,
          row['ebMobile__GeoCode__c'] as String,
          row['ebMobile__GUID__c'] as String,
          row['HasUpdatedAR__c'] as String,
          row['ebMobile__HouseNumber__c'] as String,
          row['ebMobile__InvestmentValue__c'] as String,
          row['ebMobile__InvoiceCalendar__c'] as String,
          row['IsPush__c'] as String,
          row['ebMobile__KeyAccount__c'] as String,
          row['KeyAccount__c'] as String,
          row['Last3MonthsVolume__c'] as String,
          row['ebMobile__Last3MonthsVolume__c'] as String,
          row['ebMobile__LastCallDate__c'] as String,
          row['ebMobile__LastOrderDate__c'] as String,
          row['ebMobile__LastOrderTotalPrice__c'] as String,
          row['ebMobile__LastOrderTotalQuantity__c'] as String,
          row['ebMobile__MEPCustomerNumber__c'] as String,
          row['ebMobile__OpeningTime__c'] as String,
          row['ebMobile__OpenItemsAgingStart__c'] as String,
          row['ebMobile__OperationalMarketType__c'] as String,
          row['ebMobile__OperationalTradeChannel__c'] as String,
          row['ebMobile__OrderBlock__c'] as String,
          row['ebMobile__Owner_Role__c'] as String,
          row['ebMobile__P3MAVGSales__c'] as String,
          row['ebMobile__PartnerFunction__c'] as String,
          row['ebMobile__Payer__c'] as String,
          row['ebMobile__PaymentTerms__c'] as String,
          row['ebMobile__PONumber__c'] as String,
          row['ebMobile__Postal__c'] as String,
          row['ebMobile__PriceAttribute__c'] as String,
          row['ebMobile__PriceClassID__c'] as String,
          row['ebMobile__PriceGroup__c'] as String,
          row['ebMobile__PriceListType__c'] as String,
          row['ebMobile__PricingProcedure__c'] as String,
          row['ebMobile__RecordAction__c'] as String,
          row['ebMobile__RecordTypeName__c'] as String,
          row['RedIndecator__c'] as String,
          row['ebMobile__Region__c'] as String,
          row['ebMobile__RegistrationNumber__c'] as String,
          row['ebMobile__SalesDistrict__c'] as String,
          row['ebMobile__SaleGroup__c'] as String,
          row['ebMobile__SalesOffice__c'] as String,
          row['ebMobile__SalesOrg__c'] as String,
          row['ebMobile__SalesOrgCode__c'] as String,
          row['ebMobile__User__c'] as String,
          row['ebMobile__SalesRoute__c'] as String,
          row['ebMobile__ShippingCondition__c'] as String,
          row['ShippingConditionCode__c'] as String,
          row['ebMobile__ShipTo__c'] as String,
          row['ebMobile__State__c'] as String,
          row['ebMobile__Street__c'] as String,
          row['ebMobile__Street4__c'] as String,
          row['ebMobile__Street5__c'] as String,
          row['ebMobile__StreetNumber__c'] as String,
          row['ebMobile__SubTradeChannel__c'] as String,
          row['ebMobile__SuppressionReason__c'] as String,
          row['ebMobile__SuspressionCode__c'] as String,
          row['ebMobile__SuspressionDate__c'] as String,
          row['ebMobile__TargetGroup__c'] as String,
          row['ebMobile__TaxCode__c'] as String,
          row['ebMobile__TaxNumber__c'] as String,
          row['ebMobile__TotalOpenAmount__c'] as String,
          row['ebMobile__TradeChannel__c'] as String,
          row['ebMobile__TradeGroup__c'] as String,
          row['ebMobile__TradeName__c'] as String,
          row['TransportationZone__c'] as String,
          row['ebMobile__UniqueKey__c'] as String,
          row['ebMobile__VATNumber__c'] as String,
          row['ebMobile__Vendor__c'] as String,
          row['CCSM_VendorNo__c'] as String,
          row['ebMobile__VisitStartDate__c'] as String,
          row['ebMobile__ZAPartner__c'] as String,
          row['ebMobile__ZBPartner__c'] as String,
          row['ebMobile__ZGPartner__c'] as String,
          row['ebMobile__ZHPartner__c'] as String,
          row['ebMobile__ZIPartner__c'] as String,
          row['ebMobile__ZNPartner__c'] as String,
          row['ebMobile__ZQPartner__c'] as String,
          row['ebMobile__ZRPartner__c'] as String,
          row['ebMobile__ZTPartner__c'] as String,
          row['ebMobile__ZXCrossDock__c'] as String,
          row['Geo_Longitude'] as String,
          row['Geo_Latitude'] as String,
          row['ProductList'] as String,
          row['ebMobile__Barcode__c'] as String,
          row['RouteNumber'] as String,
          row['ebMobile__ScanStoreMandatory__c'] as String,
          row['ebMobile__RouteJumping__c'] as String,
          row['ShippingCity'] as String,
          row['ShippingPostalCode'] as String,
          row['Route'] as String,
          row['ArabicName__c'] as String,
          row['ArabicStreet__c'] as String,
          row['ArabicCity__c'] as String,
          row['ArabicCountry__c'] as String,
          row['VATRegistrationNo'] as String,
          row['NoteToDriver__c'] as String,
          row['Usercode'] as String,
          row['LastTime'] as String,
          row['dirty'] as String);

  final InsertionAdapter<MD_Account_Entity> _mD_Account_EntityInsertionAdapter;

  final UpdateAdapter<MD_Account_Entity> _mD_Account_EntityUpdateAdapter;

  final DeletionAdapter<MD_Account_Entity> _mD_Account_EntityDeletionAdapter;

  @override
  Future<List<MD_Account_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM MD_Account',
        mapper: _mD_AccountMapper);
  }

  @override
  Future<MD_Account_Entity> findEntityByAccountNumber(
      String AccountNumber) async {
    return _queryAdapter.query(
        'SELECT * FROM MD_Account WHERE AccountNumber = ?',
        arguments: <dynamic>[AccountNumber],
        mapper: _mD_AccountMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Account WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Account');
  }

  @override
  Future<void> insertEntity(MD_Account_Entity entity) async {
    await _mD_Account_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(MD_Account_Entity entity) {
    return _mD_Account_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<MD_Account_Entity> entityList) {
    return _mD_Account_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$MD_Contact_Dao extends MD_Contact_Dao {
  _$MD_Contact_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mD_Contact_EntityInsertionAdapter = InsertionAdapter(
            database,
            'MD_Contact',
            (MD_Contact_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'ID': item.ID,
                  'AssistantName': item.AssistantName,
                  'AssistantPhone': item.AssistantPhone,
                  'Birthdate': item.Birthdate,
                  'Owner': item.Owner,
                  'CreatedBy': item.CreatedBy,
                  'Jigsaw': item.Jigsaw,
                  'Department': item.Department,
                  'Description': item.Description,
                  'DoNotCall': item.DoNotCall,
                  'Email': item.Email,
                  'HasOptedOutOfEmail': item.HasOptedOutOfEmail,
                  'Fax': item.Fax,
                  'HasOptedOutOfFax': item.HasOptedOutOfFax,
                  'HomePhone': item.HomePhone,
                  'LastModifiedBy': item.LastModifiedBy,
                  'LastCURequestDate': item.LastCURequestDate,
                  'LastCUUpdateDate': item.LastCUUpdateDate,
                  'LeadSource': item.LeadSource,
                  'MailingAddress': item.MailingAddress,
                  'MobilePhone': item.MobilePhone,
                  'Name': item.Name,
                  'Salutation': item.Salutation,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'OtherAddress': item.OtherAddress,
                  'OtherPhone': item.OtherPhone,
                  'Phone': item.Phone,
                  'ReportsTo': item.ReportsTo,
                  'Title': item.Title,
                  'AccountNumber__c': item.AccountNumber__c,
                  'ebMobile__IsActive__c': item.ebMobile__IsActive__c,
                  'ebMobile__Anniversary__c': item.ebMobile__Anniversary__c,
                  'ebMobile__CustomerOnboarding__c':
                      item.ebMobile__CustomerOnboarding__c,
                  'ebMobile__ExternalID__c': item.ebMobile__ExternalID__c,
                  'ebMobile__Facebook__c': item.ebMobile__Facebook__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'ebMobile__Hobbies__c': item.ebMobile__Hobbies__c,
                  'ebMobile__Married__c': item.ebMobile__Married__c,
                  'ebMobile__OnboardingUser__c':
                      item.ebMobile__OnboardingUser__c,
                  'ebMobile__Primary__c': item.ebMobile__Primary__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'CCSM_SAP_Contact_ID__c': item.CCSM_SAP_Contact_ID__c,
                  'ebMobile__Spouse__c': item.ebMobile__Spouse__c,
                  'ebMobile__Title__c': item.ebMobile__Title__c,
                  'ebMobile__Twitter__c': item.ebMobile__Twitter__c
                }),
        _mD_Contact_EntityUpdateAdapter = UpdateAdapter(
            database,
            'MD_Contact',
            ['pid'],
            (MD_Contact_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'ID': item.ID,
                  'AssistantName': item.AssistantName,
                  'AssistantPhone': item.AssistantPhone,
                  'Birthdate': item.Birthdate,
                  'Owner': item.Owner,
                  'CreatedBy': item.CreatedBy,
                  'Jigsaw': item.Jigsaw,
                  'Department': item.Department,
                  'Description': item.Description,
                  'DoNotCall': item.DoNotCall,
                  'Email': item.Email,
                  'HasOptedOutOfEmail': item.HasOptedOutOfEmail,
                  'Fax': item.Fax,
                  'HasOptedOutOfFax': item.HasOptedOutOfFax,
                  'HomePhone': item.HomePhone,
                  'LastModifiedBy': item.LastModifiedBy,
                  'LastCURequestDate': item.LastCURequestDate,
                  'LastCUUpdateDate': item.LastCUUpdateDate,
                  'LeadSource': item.LeadSource,
                  'MailingAddress': item.MailingAddress,
                  'MobilePhone': item.MobilePhone,
                  'Name': item.Name,
                  'Salutation': item.Salutation,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'OtherAddress': item.OtherAddress,
                  'OtherPhone': item.OtherPhone,
                  'Phone': item.Phone,
                  'ReportsTo': item.ReportsTo,
                  'Title': item.Title,
                  'AccountNumber__c': item.AccountNumber__c,
                  'ebMobile__IsActive__c': item.ebMobile__IsActive__c,
                  'ebMobile__Anniversary__c': item.ebMobile__Anniversary__c,
                  'ebMobile__CustomerOnboarding__c':
                      item.ebMobile__CustomerOnboarding__c,
                  'ebMobile__ExternalID__c': item.ebMobile__ExternalID__c,
                  'ebMobile__Facebook__c': item.ebMobile__Facebook__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'ebMobile__Hobbies__c': item.ebMobile__Hobbies__c,
                  'ebMobile__Married__c': item.ebMobile__Married__c,
                  'ebMobile__OnboardingUser__c':
                      item.ebMobile__OnboardingUser__c,
                  'ebMobile__Primary__c': item.ebMobile__Primary__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'CCSM_SAP_Contact_ID__c': item.CCSM_SAP_Contact_ID__c,
                  'ebMobile__Spouse__c': item.ebMobile__Spouse__c,
                  'ebMobile__Title__c': item.ebMobile__Title__c,
                  'ebMobile__Twitter__c': item.ebMobile__Twitter__c
                }),
        _mD_Contact_EntityDeletionAdapter = DeletionAdapter(
            database,
            'MD_Contact',
            ['pid'],
            (MD_Contact_Entity item) => <String, dynamic>{
                  'pid': item.pid,
                  'ID': item.ID,
                  'AssistantName': item.AssistantName,
                  'AssistantPhone': item.AssistantPhone,
                  'Birthdate': item.Birthdate,
                  'Owner': item.Owner,
                  'CreatedBy': item.CreatedBy,
                  'Jigsaw': item.Jigsaw,
                  'Department': item.Department,
                  'Description': item.Description,
                  'DoNotCall': item.DoNotCall,
                  'Email': item.Email,
                  'HasOptedOutOfEmail': item.HasOptedOutOfEmail,
                  'Fax': item.Fax,
                  'HasOptedOutOfFax': item.HasOptedOutOfFax,
                  'HomePhone': item.HomePhone,
                  'LastModifiedBy': item.LastModifiedBy,
                  'LastCURequestDate': item.LastCURequestDate,
                  'LastCUUpdateDate': item.LastCUUpdateDate,
                  'LeadSource': item.LeadSource,
                  'MailingAddress': item.MailingAddress,
                  'MobilePhone': item.MobilePhone,
                  'Name': item.Name,
                  'Salutation': item.Salutation,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'OtherAddress': item.OtherAddress,
                  'OtherPhone': item.OtherPhone,
                  'Phone': item.Phone,
                  'ReportsTo': item.ReportsTo,
                  'Title': item.Title,
                  'AccountNumber__c': item.AccountNumber__c,
                  'ebMobile__IsActive__c': item.ebMobile__IsActive__c,
                  'ebMobile__Anniversary__c': item.ebMobile__Anniversary__c,
                  'ebMobile__CustomerOnboarding__c':
                      item.ebMobile__CustomerOnboarding__c,
                  'ebMobile__ExternalID__c': item.ebMobile__ExternalID__c,
                  'ebMobile__Facebook__c': item.ebMobile__Facebook__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'ebMobile__Hobbies__c': item.ebMobile__Hobbies__c,
                  'ebMobile__Married__c': item.ebMobile__Married__c,
                  'ebMobile__OnboardingUser__c':
                      item.ebMobile__OnboardingUser__c,
                  'ebMobile__Primary__c': item.ebMobile__Primary__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'CCSM_SAP_Contact_ID__c': item.CCSM_SAP_Contact_ID__c,
                  'ebMobile__Spouse__c': item.ebMobile__Spouse__c,
                  'ebMobile__Title__c': item.ebMobile__Title__c,
                  'ebMobile__Twitter__c': item.ebMobile__Twitter__c
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _mD_ContactMapper = (Map<String, dynamic> row) =>
      MD_Contact_Entity(
          row['pid'] as int,
          row['ID'] as String,
          row['AssistantName'] as String,
          row['AssistantPhone'] as String,
          row['Birthdate'] as String,
          row['Owner'] as String,
          row['CreatedBy'] as String,
          row['Jigsaw'] as String,
          row['Department'] as String,
          row['Description'] as String,
          row['DoNotCall'] as String,
          row['Email'] as String,
          row['HasOptedOutOfEmail'] as String,
          row['Fax'] as String,
          row['HasOptedOutOfFax'] as String,
          row['HomePhone'] as String,
          row['LastModifiedBy'] as String,
          row['LastCURequestDate'] as String,
          row['LastCUUpdateDate'] as String,
          row['LeadSource'] as String,
          row['MailingAddress'] as String,
          row['MobilePhone'] as String,
          row['Name'] as String,
          row['Salutation'] as String,
          row['FirstName'] as String,
          row['LastName'] as String,
          row['OtherAddress'] as String,
          row['OtherPhone'] as String,
          row['Phone'] as String,
          row['ReportsTo'] as String,
          row['Title'] as String,
          row['AccountNumber__c'] as String,
          row['ebMobile__IsActive__c'] as String,
          row['ebMobile__Anniversary__c'] as String,
          row['ebMobile__CustomerOnboarding__c'] as String,
          row['ebMobile__ExternalID__c'] as String,
          row['ebMobile__Facebook__c'] as String,
          row['ebMobile__GUID__c'] as String,
          row['ebMobile__Hobbies__c'] as String,
          row['ebMobile__Married__c'] as String,
          row['ebMobile__OnboardingUser__c'] as String,
          row['ebMobile__Primary__c'] as String,
          row['ebMobile__RecordAction__c'] as String,
          row['CCSM_SAP_Contact_ID__c'] as String,
          row['ebMobile__Spouse__c'] as String,
          row['ebMobile__Title__c'] as String,
          row['ebMobile__Twitter__c'] as String);

  final InsertionAdapter<MD_Contact_Entity> _mD_Contact_EntityInsertionAdapter;

  final UpdateAdapter<MD_Contact_Entity> _mD_Contact_EntityUpdateAdapter;

  final DeletionAdapter<MD_Contact_Entity> _mD_Contact_EntityDeletionAdapter;

  @override
  Future<List<MD_Contact_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM MD_Contact',
        mapper: _mD_ContactMapper);
  }

  @override
  Future<void> deleteById(String pid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Contact WHERE pid = ?',
        arguments: <dynamic>[pid]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Contact');
  }

  @override
  Future<void> insertEntity(MD_Contact_Entity entity) async {
    await _mD_Contact_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(MD_Contact_Entity entity) {
    return _mD_Contact_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<MD_Contact_Entity> entityList) {
    return _mD_Contact_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$MD_Dictionary_Dao extends MD_Dictionary_Dao {
  _$MD_Dictionary_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mD_Dictionary_EntityInsertionAdapter = InsertionAdapter(
            database,
            'MD_Dictionary',
            (MD_Dictionary_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Category': item.Category,
                  'Value': item.Value,
                  'Description': item.Description,
                  'Valid': item.Valid,
                  'Sequence': item.Sequence
                }),
        _mD_Dictionary_EntityUpdateAdapter = UpdateAdapter(
            database,
            'MD_Dictionary',
            ['id'],
            (MD_Dictionary_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Category': item.Category,
                  'Value': item.Value,
                  'Description': item.Description,
                  'Valid': item.Valid,
                  'Sequence': item.Sequence
                }),
        _mD_Dictionary_EntityDeletionAdapter = DeletionAdapter(
            database,
            'MD_Dictionary',
            ['id'],
            (MD_Dictionary_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'Category': item.Category,
                  'Value': item.Value,
                  'Description': item.Description,
                  'Valid': item.Valid,
                  'Sequence': item.Sequence
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _mD_DictionaryMapper = (Map<String, dynamic> row) =>
      MD_Dictionary_Entity(
          row['id'] as int,
          row['Category'] as String,
          row['Value'] as String,
          row['Description'] as String,
          row['Valid'] as String,
          row['Sequence'] as int);

  final InsertionAdapter<MD_Dictionary_Entity>
      _mD_Dictionary_EntityInsertionAdapter;

  final UpdateAdapter<MD_Dictionary_Entity> _mD_Dictionary_EntityUpdateAdapter;

  final DeletionAdapter<MD_Dictionary_Entity>
      _mD_Dictionary_EntityDeletionAdapter;

  @override
  Future<List<MD_Dictionary_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM MD_Dictionary',
        mapper: _mD_DictionaryMapper);
  }

  @override
  Future<MD_Dictionary_Entity> findEntityByCon(
      String Category, String Value, String Valid) async {
    return _queryAdapter.query(
        'SELECT * FROM MD_Dictionary WHERE Category = ? AND Value = ? AND Valid = ?',
        arguments: <dynamic>[Category, Value, Valid],
        mapper: _mD_DictionaryMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Dictionary WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Dictionary');
  }

  @override
  Future<List<MD_Dictionary_Entity>> findEntityByCategory(
      String category, String valid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MD_Dictionary WHERE Category = ? AND valid = ? ORDER BY Sequence ASC',
        arguments: <dynamic>[category, valid],
        mapper: _mD_DictionaryMapper);
  }

  @override
  Future<void> insertEntity(MD_Dictionary_Entity entity) async {
    await _mD_Dictionary_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(MD_Dictionary_Entity entity) {
    return _mD_Dictionary_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<MD_Dictionary_Entity> entityList) {
    return _mD_Dictionary_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$MD_Person_Dao extends MD_Person_Dao {
  _$MD_Person_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mD_Person_EntityInsertionAdapter = InsertionAdapter(
            database,
            'MD_Person',
            (MD_Person_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'UserCode': item.UserCode,
                  'Password': item.Password,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'Type': item.Type,
                  'RouteNumber': item.RouteNumber
                }),
        _mD_Person_EntityUpdateAdapter = UpdateAdapter(
            database,
            'MD_Person',
            ['id'],
            (MD_Person_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'UserCode': item.UserCode,
                  'Password': item.Password,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'Type': item.Type,
                  'RouteNumber': item.RouteNumber
                }),
        _mD_Person_EntityDeletionAdapter = DeletionAdapter(
            database,
            'MD_Person',
            ['id'],
            (MD_Person_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'UserCode': item.UserCode,
                  'Password': item.Password,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'Type': item.Type,
                  'RouteNumber': item.RouteNumber
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _mD_PersonMapper = (Map<String, dynamic> row) =>
      MD_Person_Entity(
          row['id'] as int,
          row['UserCode'] as String,
          row['Password'] as String,
          row['FirstName'] as String,
          row['LastName'] as String,
          row['Type'] as String,
          row['RouteNumber'] as String);

  final InsertionAdapter<MD_Person_Entity> _mD_Person_EntityInsertionAdapter;

  final UpdateAdapter<MD_Person_Entity> _mD_Person_EntityUpdateAdapter;

  final DeletionAdapter<MD_Person_Entity> _mD_Person_EntityDeletionAdapter;

  @override
  Future<List<MD_Person_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM MD_Person',
        mapper: _mD_PersonMapper);
  }

  @override
  Future<MD_Person_Entity> findEntityByUserCode(String UserCode) async {
    return _queryAdapter.query('SELECT * FROM MD_Person WHERE UserCode = ?',
        arguments: <dynamic>[UserCode], mapper: _mD_PersonMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Person WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DSD_M_DeliveryHeader');
  }

  @override
  Future<MD_Person_Entity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM MD_Person WHERE id = ?',
        arguments: <dynamic>[id], mapper: _mD_PersonMapper);
  }

  @override
  Future<void> insertEntity(MD_Person_Entity entity) async {
    await _mD_Person_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(MD_Person_Entity entity) {
    return _mD_Person_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<MD_Person_Entity> entityList) {
    return _mD_Person_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$MD_Product_Dao extends MD_Product_Dao {
  _$MD_Product_Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mD_Product_EntityInsertionAdapter = InsertionAdapter(
            database,
            'MD_Product',
            (MD_Product_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ProductCode': item.ProductCode,
                  'Name': item.Name,
                  'Description': item.Description,
                  'Family': item.Family,
                  'IsActive': item.IsActive,
                  'CreatedBy': item.CreatedBy,
                  'DisplayUrl': item.DisplayUrl,
                  'ExternalDataSource': item.ExternalDataSource,
                  'ExternalId': item.ExternalId,
                  'LastModifiedBy': item.LastModifiedBy,
                  'QuantityUnitOfMeasure': item.QuantityUnitOfMeasure,
                  'ebMobile__BaseUOM__c': item.ebMobile__BaseUOM__c,
                  'ebMobile__BeverageCategory__c':
                      item.ebMobile__BeverageCategory__c,
                  'ebMobile__BeverageProduct__c':
                      item.ebMobile__BeverageProduct__c,
                  'ebMobile__BeverageType__c': item.ebMobile__BeverageType__c,
                  'ebMobile__Brand__c': item.ebMobile__Brand__c,
                  'ebMobile__CarbonationIndicator__c':
                      item.ebMobile__CarbonationIndicator__c,
                  'ebMobile__Category__c': item.ebMobile__Category__c,
                  'ebMobile__Category1__c': item.ebMobile__Category1__c,
                  'ebMobile__Category2__c': item.ebMobile__Category2__c,
                  'ebMobile__Category3__c': item.ebMobile__Category3__c,
                  'ebMobile__Pack1__c': item.ebMobile__Pack1__c,
                  'ebMobile__Pack2__c': item.ebMobile__Pack2__c,
                  'ConversionRate__c': item.ConversionRate__c,
                  'ebMobile__DeliveringPlant__c':
                      item.ebMobile__DeliveringPlant__c,
                  'ebMobile__Denominator__c': item.ebMobile__Denominator__c,
                  'ebMobile__DistributionChannel__c':
                      item.ebMobile__DistributionChannel__c,
                  'ebMobile__ErpProductCode__c':
                      item.ebMobile__ErpProductCode__c,
                  'ebMobile__Flavor__c': item.ebMobile__Flavor__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'ebMobile__IndSector__c': item.ebMobile__IndSector__c,
                  'ebMobile__IANumber__c': item.ebMobile__IANumber__c,
                  'ebMobile__IsEmpty__c': item.ebMobile__IsEmpty__c,
                  'ebMobile__MatFrgtGrp__c': item.ebMobile__MatFrgtGrp__c,
                  'ebMobile__MaterialGroup1__c':
                      item.ebMobile__MaterialGroup1__c,
                  'ebMobile__MaterialGroup2__c':
                      item.ebMobile__MaterialGroup2__c,
                  'ebMobile__MaterialGroup3__c':
                      item.ebMobile__MaterialGroup3__c,
                  'ebMobile__MaterialGroup4__c':
                      item.ebMobile__MaterialGroup4__c,
                  'ebMobile__MaterialGroup5__c':
                      item.ebMobile__MaterialGroup5__c,
                  'ebMobile__MaterialPricingGroup__c':
                      item.ebMobile__MaterialPricingGroup__c,
                  'ebMobile__Numerator__c': item.ebMobile__Numerator__c,
                  'ebMobile__OOSFlag__c': item.ebMobile__OOSFlag__c,
                  'ebMobile__Package__c': item.ebMobile__Package__c,
                  'ebMobile__PackProductID__c': item.ebMobile__PackProductID__c,
                  'ebMobile__Pack__c': item.ebMobile__Pack__c,
                  'ebMobile__PackType__c': item.ebMobile__PackType__c,
                  'ebMobile__PartProductID__c': item.ebMobile__PartProductID__c,
                  'ebMobile__PhysicalState__c': item.ebMobile__PhysicalState__c,
                  'ebMobile__Plant__c': item.ebMobile__Plant__c,
                  'ebMobile__PlantDeleteFlag__c':
                      item.ebMobile__PlantDeleteFlag__c,
                  'ebMobile__PricingReferenceMaterial__c':
                      item.ebMobile__PricingReferenceMaterial__c,
                  'ebMobile__ProductGroup__c': item.ebMobile__ProductGroup__c,
                  'ebMobile__PromotionalIndicator__c':
                      item.ebMobile__PromotionalIndicator__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'ebMobile__PlRefMat__c': item.ebMobile__PlRefMat__c,
                  'ebMobile__ReturnablePackagingIndicator__c':
                      item.ebMobile__ReturnablePackagingIndicator__c,
                  'ebMobile__SalesOrg__c': item.ebMobile__SalesOrg__c,
                  'ebMobile__SalesUnit__c': item.ebMobile__SalesUnit__c,
                  'ebMobile__SalStatus__c': item.ebMobile__SalStatus__c,
                  'ebMobile__Sequence__c': item.ebMobile__Sequence__c,
                  'ebMobile__SFAGroup__c': item.ebMobile__SFAGroup__c,
                  'ebMobile__TaxClass__c': item.ebMobile__TaxClass__c,
                  'ebMobile__TaxType__c': item.ebMobile__TaxType__c,
                  'ebMobile__Trademark__c': item.ebMobile__Trademark__c,
                  'ArabicProductDescription': item.ArabicProductDescription
                }),
        _mD_Product_EntityUpdateAdapter = UpdateAdapter(
            database,
            'MD_Product',
            ['id'],
            (MD_Product_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ProductCode': item.ProductCode,
                  'Name': item.Name,
                  'Description': item.Description,
                  'Family': item.Family,
                  'IsActive': item.IsActive,
                  'CreatedBy': item.CreatedBy,
                  'DisplayUrl': item.DisplayUrl,
                  'ExternalDataSource': item.ExternalDataSource,
                  'ExternalId': item.ExternalId,
                  'LastModifiedBy': item.LastModifiedBy,
                  'QuantityUnitOfMeasure': item.QuantityUnitOfMeasure,
                  'ebMobile__BaseUOM__c': item.ebMobile__BaseUOM__c,
                  'ebMobile__BeverageCategory__c':
                      item.ebMobile__BeverageCategory__c,
                  'ebMobile__BeverageProduct__c':
                      item.ebMobile__BeverageProduct__c,
                  'ebMobile__BeverageType__c': item.ebMobile__BeverageType__c,
                  'ebMobile__Brand__c': item.ebMobile__Brand__c,
                  'ebMobile__CarbonationIndicator__c':
                      item.ebMobile__CarbonationIndicator__c,
                  'ebMobile__Category__c': item.ebMobile__Category__c,
                  'ebMobile__Category1__c': item.ebMobile__Category1__c,
                  'ebMobile__Category2__c': item.ebMobile__Category2__c,
                  'ebMobile__Category3__c': item.ebMobile__Category3__c,
                  'ebMobile__Pack1__c': item.ebMobile__Pack1__c,
                  'ebMobile__Pack2__c': item.ebMobile__Pack2__c,
                  'ConversionRate__c': item.ConversionRate__c,
                  'ebMobile__DeliveringPlant__c':
                      item.ebMobile__DeliveringPlant__c,
                  'ebMobile__Denominator__c': item.ebMobile__Denominator__c,
                  'ebMobile__DistributionChannel__c':
                      item.ebMobile__DistributionChannel__c,
                  'ebMobile__ErpProductCode__c':
                      item.ebMobile__ErpProductCode__c,
                  'ebMobile__Flavor__c': item.ebMobile__Flavor__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'ebMobile__IndSector__c': item.ebMobile__IndSector__c,
                  'ebMobile__IANumber__c': item.ebMobile__IANumber__c,
                  'ebMobile__IsEmpty__c': item.ebMobile__IsEmpty__c,
                  'ebMobile__MatFrgtGrp__c': item.ebMobile__MatFrgtGrp__c,
                  'ebMobile__MaterialGroup1__c':
                      item.ebMobile__MaterialGroup1__c,
                  'ebMobile__MaterialGroup2__c':
                      item.ebMobile__MaterialGroup2__c,
                  'ebMobile__MaterialGroup3__c':
                      item.ebMobile__MaterialGroup3__c,
                  'ebMobile__MaterialGroup4__c':
                      item.ebMobile__MaterialGroup4__c,
                  'ebMobile__MaterialGroup5__c':
                      item.ebMobile__MaterialGroup5__c,
                  'ebMobile__MaterialPricingGroup__c':
                      item.ebMobile__MaterialPricingGroup__c,
                  'ebMobile__Numerator__c': item.ebMobile__Numerator__c,
                  'ebMobile__OOSFlag__c': item.ebMobile__OOSFlag__c,
                  'ebMobile__Package__c': item.ebMobile__Package__c,
                  'ebMobile__PackProductID__c': item.ebMobile__PackProductID__c,
                  'ebMobile__Pack__c': item.ebMobile__Pack__c,
                  'ebMobile__PackType__c': item.ebMobile__PackType__c,
                  'ebMobile__PartProductID__c': item.ebMobile__PartProductID__c,
                  'ebMobile__PhysicalState__c': item.ebMobile__PhysicalState__c,
                  'ebMobile__Plant__c': item.ebMobile__Plant__c,
                  'ebMobile__PlantDeleteFlag__c':
                      item.ebMobile__PlantDeleteFlag__c,
                  'ebMobile__PricingReferenceMaterial__c':
                      item.ebMobile__PricingReferenceMaterial__c,
                  'ebMobile__ProductGroup__c': item.ebMobile__ProductGroup__c,
                  'ebMobile__PromotionalIndicator__c':
                      item.ebMobile__PromotionalIndicator__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'ebMobile__PlRefMat__c': item.ebMobile__PlRefMat__c,
                  'ebMobile__ReturnablePackagingIndicator__c':
                      item.ebMobile__ReturnablePackagingIndicator__c,
                  'ebMobile__SalesOrg__c': item.ebMobile__SalesOrg__c,
                  'ebMobile__SalesUnit__c': item.ebMobile__SalesUnit__c,
                  'ebMobile__SalStatus__c': item.ebMobile__SalStatus__c,
                  'ebMobile__Sequence__c': item.ebMobile__Sequence__c,
                  'ebMobile__SFAGroup__c': item.ebMobile__SFAGroup__c,
                  'ebMobile__TaxClass__c': item.ebMobile__TaxClass__c,
                  'ebMobile__TaxType__c': item.ebMobile__TaxType__c,
                  'ebMobile__Trademark__c': item.ebMobile__Trademark__c,
                  'ArabicProductDescription': item.ArabicProductDescription
                }),
        _mD_Product_EntityDeletionAdapter = DeletionAdapter(
            database,
            'MD_Product',
            ['id'],
            (MD_Product_Entity item) => <String, dynamic>{
                  'id': item.id,
                  'ProductCode': item.ProductCode,
                  'Name': item.Name,
                  'Description': item.Description,
                  'Family': item.Family,
                  'IsActive': item.IsActive,
                  'CreatedBy': item.CreatedBy,
                  'DisplayUrl': item.DisplayUrl,
                  'ExternalDataSource': item.ExternalDataSource,
                  'ExternalId': item.ExternalId,
                  'LastModifiedBy': item.LastModifiedBy,
                  'QuantityUnitOfMeasure': item.QuantityUnitOfMeasure,
                  'ebMobile__BaseUOM__c': item.ebMobile__BaseUOM__c,
                  'ebMobile__BeverageCategory__c':
                      item.ebMobile__BeverageCategory__c,
                  'ebMobile__BeverageProduct__c':
                      item.ebMobile__BeverageProduct__c,
                  'ebMobile__BeverageType__c': item.ebMobile__BeverageType__c,
                  'ebMobile__Brand__c': item.ebMobile__Brand__c,
                  'ebMobile__CarbonationIndicator__c':
                      item.ebMobile__CarbonationIndicator__c,
                  'ebMobile__Category__c': item.ebMobile__Category__c,
                  'ebMobile__Category1__c': item.ebMobile__Category1__c,
                  'ebMobile__Category2__c': item.ebMobile__Category2__c,
                  'ebMobile__Category3__c': item.ebMobile__Category3__c,
                  'ebMobile__Pack1__c': item.ebMobile__Pack1__c,
                  'ebMobile__Pack2__c': item.ebMobile__Pack2__c,
                  'ConversionRate__c': item.ConversionRate__c,
                  'ebMobile__DeliveringPlant__c':
                      item.ebMobile__DeliveringPlant__c,
                  'ebMobile__Denominator__c': item.ebMobile__Denominator__c,
                  'ebMobile__DistributionChannel__c':
                      item.ebMobile__DistributionChannel__c,
                  'ebMobile__ErpProductCode__c':
                      item.ebMobile__ErpProductCode__c,
                  'ebMobile__Flavor__c': item.ebMobile__Flavor__c,
                  'ebMobile__GUID__c': item.ebMobile__GUID__c,
                  'ebMobile__IndSector__c': item.ebMobile__IndSector__c,
                  'ebMobile__IANumber__c': item.ebMobile__IANumber__c,
                  'ebMobile__IsEmpty__c': item.ebMobile__IsEmpty__c,
                  'ebMobile__MatFrgtGrp__c': item.ebMobile__MatFrgtGrp__c,
                  'ebMobile__MaterialGroup1__c':
                      item.ebMobile__MaterialGroup1__c,
                  'ebMobile__MaterialGroup2__c':
                      item.ebMobile__MaterialGroup2__c,
                  'ebMobile__MaterialGroup3__c':
                      item.ebMobile__MaterialGroup3__c,
                  'ebMobile__MaterialGroup4__c':
                      item.ebMobile__MaterialGroup4__c,
                  'ebMobile__MaterialGroup5__c':
                      item.ebMobile__MaterialGroup5__c,
                  'ebMobile__MaterialPricingGroup__c':
                      item.ebMobile__MaterialPricingGroup__c,
                  'ebMobile__Numerator__c': item.ebMobile__Numerator__c,
                  'ebMobile__OOSFlag__c': item.ebMobile__OOSFlag__c,
                  'ebMobile__Package__c': item.ebMobile__Package__c,
                  'ebMobile__PackProductID__c': item.ebMobile__PackProductID__c,
                  'ebMobile__Pack__c': item.ebMobile__Pack__c,
                  'ebMobile__PackType__c': item.ebMobile__PackType__c,
                  'ebMobile__PartProductID__c': item.ebMobile__PartProductID__c,
                  'ebMobile__PhysicalState__c': item.ebMobile__PhysicalState__c,
                  'ebMobile__Plant__c': item.ebMobile__Plant__c,
                  'ebMobile__PlantDeleteFlag__c':
                      item.ebMobile__PlantDeleteFlag__c,
                  'ebMobile__PricingReferenceMaterial__c':
                      item.ebMobile__PricingReferenceMaterial__c,
                  'ebMobile__ProductGroup__c': item.ebMobile__ProductGroup__c,
                  'ebMobile__PromotionalIndicator__c':
                      item.ebMobile__PromotionalIndicator__c,
                  'ebMobile__RecordAction__c': item.ebMobile__RecordAction__c,
                  'ebMobile__PlRefMat__c': item.ebMobile__PlRefMat__c,
                  'ebMobile__ReturnablePackagingIndicator__c':
                      item.ebMobile__ReturnablePackagingIndicator__c,
                  'ebMobile__SalesOrg__c': item.ebMobile__SalesOrg__c,
                  'ebMobile__SalesUnit__c': item.ebMobile__SalesUnit__c,
                  'ebMobile__SalStatus__c': item.ebMobile__SalStatus__c,
                  'ebMobile__Sequence__c': item.ebMobile__Sequence__c,
                  'ebMobile__SFAGroup__c': item.ebMobile__SFAGroup__c,
                  'ebMobile__TaxClass__c': item.ebMobile__TaxClass__c,
                  'ebMobile__TaxType__c': item.ebMobile__TaxType__c,
                  'ebMobile__Trademark__c': item.ebMobile__Trademark__c,
                  'ArabicProductDescription': item.ArabicProductDescription
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _mD_ProductMapper = (Map<String, dynamic> row) =>
      MD_Product_Entity(
          row['id'] as int,
          row['ProductCode'] as String,
          row['Name'] as String,
          row['Description'] as String,
          row['Family'] as String,
          row['IsActive'] as String,
          row['CreatedBy'] as String,
          row['DisplayUrl'] as String,
          row['ExternalDataSource'] as String,
          row['ExternalId'] as String,
          row['LastModifiedBy'] as String,
          row['QuantityUnitOfMeasure'] as String,
          row['ebMobile__BaseUOM__c'] as String,
          row['ebMobile__BeverageCategory__c'] as String,
          row['ebMobile__BeverageProduct__c'] as String,
          row['ebMobile__BeverageType__c'] as String,
          row['ebMobile__Brand__c'] as String,
          row['ebMobile__CarbonationIndicator__c'] as String,
          row['ebMobile__Category__c'] as String,
          row['ebMobile__Category1__c'] as String,
          row['ebMobile__Category2__c'] as String,
          row['ebMobile__Category3__c'] as String,
          row['ebMobile__Pack1__c'] as String,
          row['ebMobile__Pack2__c'] as String,
          row['ConversionRate__c'] as String,
          row['ebMobile__DeliveringPlant__c'] as String,
          row['ebMobile__Denominator__c'] as String,
          row['ebMobile__DistributionChannel__c'] as String,
          row['ebMobile__ErpProductCode__c'] as String,
          row['ebMobile__Flavor__c'] as String,
          row['ebMobile__GUID__c'] as String,
          row['ebMobile__IndSector__c'] as String,
          row['ebMobile__IANumber__c'] as String,
          row['ebMobile__IsEmpty__c'] as String,
          row['ebMobile__MatFrgtGrp__c'] as String,
          row['ebMobile__MaterialGroup1__c'] as String,
          row['ebMobile__MaterialGroup2__c'] as String,
          row['ebMobile__MaterialGroup3__c'] as String,
          row['ebMobile__MaterialGroup4__c'] as String,
          row['ebMobile__MaterialGroup5__c'] as String,
          row['ebMobile__MaterialPricingGroup__c'] as String,
          row['ebMobile__Numerator__c'] as String,
          row['ebMobile__OOSFlag__c'] as String,
          row['ebMobile__Package__c'] as String,
          row['ebMobile__PackProductID__c'] as String,
          row['ebMobile__Pack__c'] as String,
          row['ebMobile__PackType__c'] as String,
          row['ebMobile__PartProductID__c'] as String,
          row['ebMobile__PhysicalState__c'] as String,
          row['ebMobile__Plant__c'] as String,
          row['ebMobile__PlantDeleteFlag__c'] as String,
          row['ebMobile__PricingReferenceMaterial__c'] as String,
          row['ebMobile__ProductGroup__c'] as String,
          row['ebMobile__PromotionalIndicator__c'] as String,
          row['ebMobile__RecordAction__c'] as String,
          row['ebMobile__PlRefMat__c'] as String,
          row['ebMobile__ReturnablePackagingIndicator__c'] as String,
          row['ebMobile__SalesOrg__c'] as String,
          row['ebMobile__SalesUnit__c'] as String,
          row['ebMobile__SalStatus__c'] as String,
          row['ebMobile__Sequence__c'] as String,
          row['ebMobile__SFAGroup__c'] as String,
          row['ebMobile__TaxClass__c'] as String,
          row['ebMobile__TaxType__c'] as String,
          row['ebMobile__Trademark__c'] as String,
          row['ArabicProductDescription'] as String);

  final InsertionAdapter<MD_Product_Entity> _mD_Product_EntityInsertionAdapter;

  final UpdateAdapter<MD_Product_Entity> _mD_Product_EntityUpdateAdapter;

  final DeletionAdapter<MD_Product_Entity> _mD_Product_EntityDeletionAdapter;

  @override
  Future<List<MD_Product_Entity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM MD_Product',
        mapper: _mD_ProductMapper);
  }

  @override
  Future<MD_Product_Entity> findEntityByCode(String ProductCode) async {
    return _queryAdapter.query('SELECT * FROM MD_Product WHERE ProductCode = ?',
        arguments: <dynamic>[ProductCode], mapper: _mD_ProductMapper);
  }

  @override
  Future<List<MD_Product_Entity>> findEntityByEmpty(
      String EbMobile__IsEmpty__c) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MD_Product WHERE EbMobile__IsEmpty__c = ?',
        arguments: <dynamic>[EbMobile__IsEmpty__c],
        mapper: _mD_ProductMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Product WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MD_Product');
  }

  @override
  Future<void> insertEntity(MD_Product_Entity entity) async {
    await _mD_Product_EntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(MD_Product_Entity entity) {
    return _mD_Product_EntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<MD_Product_Entity> entityList) {
    return _mD_Product_EntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$AppLogDao extends AppLogDao {
  _$AppLogDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _appLogEntityInsertionAdapter = InsertionAdapter(
            database,
            'app_log',
            (AppLogEntity item) => <String, dynamic>{
                  'id': item.id,
                  'versionName': item.versionName,
                  'device': item.device,
                  'type': item.type,
                  'content': item.content,
                  'stackTrace': item.stackTrace,
                  'time': item.time,
                  'note': item.note,
                  'dirty': item.dirty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _app_logMapper = (Map<String, dynamic> row) => AppLogEntity(
      row['id'] as String,
      row['versionName'] as String,
      row['device'] as String,
      row['type'] as String,
      row['content'] as String,
      row['stackTrace'] as String,
      row['time'] as String,
      row['note'] as String,
      row['dirty'] as String);

  final InsertionAdapter<AppLogEntity> _appLogEntityInsertionAdapter;

  @override
  Future<List<AppLogEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM app_log',
        mapper: _app_logMapper);
  }

  @override
  Future<AppLogEntity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM app_log WHERE id = ?',
        arguments: <dynamic>[id], mapper: _app_logMapper);
  }

  @override
  Future<void> insertEntity(AppLogEntity entity) async {
    await _appLogEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SyncDownloadLogicDao extends SyncDownloadLogicDao {
  _$SyncDownloadLogicDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _syncDownloadLogicEntityInsertionAdapter = InsertionAdapter(
            database,
            'sync_download_logic',
            (SyncDownloadLogicEntity item) => <String, dynamic>{
                  'tableName': item.tableName,
                  'tableOrder': item.tableOrder,
                  'timeStamp': item.timeStamp,
                  'version': item.version,
                  'isActive': item.isActive,
                  'transferred': item.transferred,
                  'keys': item.keys
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _sync_download_logicMapper = (Map<String, dynamic> row) =>
      SyncDownloadLogicEntity(
          row['tableName'] as String,
          row['tableOrder'] as String,
          row['timeStamp'] as String,
          row['version'] as String,
          row['isActive'] as String,
          row['transferred'] as String,
          row['keys'] as String);

  final InsertionAdapter<SyncDownloadLogicEntity>
      _syncDownloadLogicEntityInsertionAdapter;

  @override
  Future<List<SyncDownloadLogicEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM sync_download_logic',
        mapper: _sync_download_logicMapper);
  }

  @override
  Future<SyncDownloadLogicEntity> findEntityById(String tableName) async {
    return _queryAdapter.query(
        'SELECT * FROM sync_download_logic WHERE tableName = ?',
        arguments: <dynamic>[tableName],
        mapper: _sync_download_logicMapper);
  }

  @override
  Future<List<SyncDownloadLogicEntity>> findEntityByVersion(
      String version, String isActive) async {
    return _queryAdapter.queryList(
        'SELECT * FROM sync_download_logic WHERE version = ? AND isActive = ?',
        arguments: <dynamic>[version, isActive],
        mapper: _sync_download_logicMapper);
  }

  @override
  Future<void> insertEntity(SyncDownloadLogicEntity entity) async {
    await _syncDownloadLogicEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SyncPhotoUploadDao extends SyncPhotoUploadDao {
  _$SyncPhotoUploadDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _syncPhotoUploadEntityInsertionAdapter = InsertionAdapter(
            database,
            'sync_photo_upload',
            (SyncPhotoUploadEntity item) => <String, dynamic>{
                  'id': item.id,
                  'filePath': item.filePath,
                  'name': item.name,
                  'type': item.type,
                  'status': item.status,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _sync_photo_uploadMapper = (Map<String, dynamic> row) =>
      SyncPhotoUploadEntity(
          row['id'] as String,
          row['filePath'] as String,
          row['name'] as String,
          row['type'] as String,
          row['status'] as String,
          row['time'] as String);

  final InsertionAdapter<SyncPhotoUploadEntity>
      _syncPhotoUploadEntityInsertionAdapter;

  @override
  Future<List<SyncPhotoUploadEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM sync_photo_upload',
        mapper: _sync_photo_uploadMapper);
  }

  @override
  Future<SyncPhotoUploadEntity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM sync_photo_upload WHERE id = ?',
        arguments: <dynamic>[id], mapper: _sync_photo_uploadMapper);
  }

  @override
  Future<void> insertEntity(SyncPhotoUploadEntity entity) async {
    await _syncPhotoUploadEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SyncUploadDao extends SyncUploadDao {
  _$SyncUploadDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _syncUploadEntityInsertionAdapter = InsertionAdapter(
            database,
            'sync_upload',
            (SyncUploadEntity item) => <String, dynamic>{
                  'id': item.id,
                  'uniqueIdValues': item.uniqueIdValues,
                  'name': item.name,
                  'type': item.type,
                  'status': item.status,
                  'time': item.time
                }),
        _syncUploadEntityDeletionAdapter = DeletionAdapter(
            database,
            'sync_upload',
            ['id'],
            (SyncUploadEntity item) => <String, dynamic>{
                  'id': item.id,
                  'uniqueIdValues': item.uniqueIdValues,
                  'name': item.name,
                  'type': item.type,
                  'status': item.status,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _sync_uploadMapper = (Map<String, dynamic> row) =>
      SyncUploadEntity(
          row['id'] as String,
          row['uniqueIdValues'] as String,
          row['name'] as String,
          row['type'] as String,
          row['status'] as String,
          row['time'] as String);

  final InsertionAdapter<SyncUploadEntity> _syncUploadEntityInsertionAdapter;

  final DeletionAdapter<SyncUploadEntity> _syncUploadEntityDeletionAdapter;

  @override
  Future<List<SyncUploadEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM sync_upload',
        mapper: _sync_uploadMapper);
  }

  @override
  Future<SyncUploadEntity> findEntityById(String id) async {
    return _queryAdapter.query('SELECT * FROM sync_upload WHERE id = ?',
        arguments: <dynamic>[id], mapper: _sync_uploadMapper);
  }

  @override
  Future<SyncUploadEntity> findEntityByUniqueIdAndType(
      String unique, String type) async {
    return _queryAdapter.query(
        'SELECT * FROM sync_upload WHERE uniqueIdValues = ? and type = ?',
        arguments: <dynamic>[unique, type],
        mapper: _sync_uploadMapper);
  }

  @override
  Future<List<SyncUploadEntity>> findEntityByType(String type) async {
    return _queryAdapter.queryList('SELECT * FROM sync_upload WHERE type = ?',
        arguments: <dynamic>[type], mapper: _sync_uploadMapper);
  }

  @override
  Future<void> insertEntity(SyncUploadEntity entity) async {
    await _syncUploadEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<SyncUploadEntity> entityList) {
    return _syncUploadEntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}

class _$AppConfigDao extends AppConfigDao {
  _$AppConfigDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _appConfigEntityInsertionAdapter = InsertionAdapter(
            database,
            'app_config',
            (AppConfigEntity item) => <String, dynamic>{
                  'id': item.id,
                  'userCode': item.userCode,
                  'userName': item.userName,
                  'password': item.password,
                  'env': item.env,
                  'host': item.host,
                  'port': item.port,
                  'isSsl': item.isSsl,
                  'syncInitFlag': item.syncInitFlag,
                  'version': item.version,
                  'lastUpdateTime': item.lastUpdateTime
                }),
        _appConfigEntityUpdateAdapter = UpdateAdapter(
            database,
            'app_config',
            ['id'],
            (AppConfigEntity item) => <String, dynamic>{
                  'id': item.id,
                  'userCode': item.userCode,
                  'userName': item.userName,
                  'password': item.password,
                  'env': item.env,
                  'host': item.host,
                  'port': item.port,
                  'isSsl': item.isSsl,
                  'syncInitFlag': item.syncInitFlag,
                  'version': item.version,
                  'lastUpdateTime': item.lastUpdateTime
                }),
        _appConfigEntityDeletionAdapter = DeletionAdapter(
            database,
            'app_config',
            ['id'],
            (AppConfigEntity item) => <String, dynamic>{
                  'id': item.id,
                  'userCode': item.userCode,
                  'userName': item.userName,
                  'password': item.password,
                  'env': item.env,
                  'host': item.host,
                  'port': item.port,
                  'isSsl': item.isSsl,
                  'syncInitFlag': item.syncInitFlag,
                  'version': item.version,
                  'lastUpdateTime': item.lastUpdateTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _app_configMapper = (Map<String, dynamic> row) =>
      AppConfigEntity(
          row['id'] as int,
          row['userCode'] as String,
          row['userName'] as String,
          row['password'] as String,
          row['env'] as String,
          row['host'] as String,
          row['port'] as String,
          row['isSsl'] as String,
          row['syncInitFlag'] as String,
          row['version'] as String,
          row['lastUpdateTime'] as String);

  final InsertionAdapter<AppConfigEntity> _appConfigEntityInsertionAdapter;

  final UpdateAdapter<AppConfigEntity> _appConfigEntityUpdateAdapter;

  final DeletionAdapter<AppConfigEntity> _appConfigEntityDeletionAdapter;

  @override
  Future<List<AppConfigEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM app_config',
        mapper: _app_configMapper);
  }

  @override
  Future<AppConfigEntity> findEntityByUserCode(String userCode) async {
    return _queryAdapter.query('SELECT * FROM app_config WHERE userCode = ?',
        arguments: <dynamic>[userCode], mapper: _app_configMapper);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM app_config WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM app_config');
  }

  @override
  Future<void> insertEntity(AppConfigEntity entity) async {
    await _appConfigEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateEntity(AppConfigEntity entity) {
    return _appConfigEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteEntity(List<AppConfigEntity> entityList) {
    return _appConfigEntityDeletionAdapter
        .deleteListAndReturnChangedRows(entityList);
  }
}
