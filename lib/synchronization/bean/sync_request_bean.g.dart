// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_request_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncRequestBean _$SyncRequestBeanFromJson(Map<String, dynamic> json) {
  return SyncRequestBean(
    json['ReqContent'] == null
        ? null
        : ReqContent.fromJson(json['ReqContent'] as Map<String, dynamic>),
    json['DomainId'] as String,
    json['IsGzip'] as String,
    json['LoginName'] as String,
    json['Password'] as String,
    json['Version'] as String,
  );
}

Map<String, dynamic> _$SyncRequestBeanToJson(SyncRequestBean instance) =>
    <String, dynamic>{
      'ReqContent': instance.reqContent,
      'DomainId': instance.domainId,
      'IsGzip': instance.isGzip,
      'LoginName': instance.loginName,
      'Password': instance.password,
      'Version': instance.version,
    };

ReqContent _$ReqContentFromJson(Map<String, dynamic> json) {
  return ReqContent(
    (json['Tables'] as List)
        ?.map((e) =>
            e == null ? null : Tables.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReqContentToJson(ReqContent instance) =>
    <String, dynamic>{
      'Tables': instance.tables,
    };

Tables _$TablesFromJson(Map<String, dynamic> json) {
  return Tables(
    json['Name'] as String,
    (json['ParamValues'] as List)?.map((e) => e as String)?.toList(),
    json['Fields'] as String,
    (json['Rows'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TablesToJson(Tables instance) => <String, dynamic>{
      'Name': instance.name,
      'ParamValues': instance.paramValues,
      'Fields': instance.fields,
      'Rows': instance.rows,
    };
