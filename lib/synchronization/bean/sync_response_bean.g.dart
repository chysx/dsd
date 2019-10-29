// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_response_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncResponseBean _$SyncResponseBeanFromJson(Map<String, dynamic> json) {
  return SyncResponseBean(
    json['LoginName'] as String,
    json['Status'] as int,
    json['SyncType'] as int,
    json['ExceptionCode'] as int,
    json['Exception'] as String,
    json['Result'] == null
        ? null
        : Result.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SyncResponseBeanToJson(SyncResponseBean instance) =>
    <String, dynamic>{
      'LoginName': instance.loginName,
      'Status': instance.status,
      'SyncType': instance.syncType,
      'ExceptionCode': instance.exceptionCode,
      'Exception': instance.exception,
      'Result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    (json['Tables'] as List)
        ?.map((e) =>
            e == null ? null : Tables.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
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
