import 'package:json_annotation/json_annotation.dart';

part 'sync_response_bean.g.dart';

@JsonSerializable()
class SyncResponseBean extends Object {
  @JsonKey(name: 'LoginName')
  String loginName;

  @JsonKey(name: 'Status')
  int status;

  @JsonKey(name: 'SyncType')
  int syncType;

  @JsonKey(name: 'ExceptionCode')
  int exceptionCode;

  @JsonKey(name: 'Exception')
  String exception;

  @JsonKey(name: 'Result')
  Result result;

  SyncResponseBean(
    this.loginName,
    this.status,
    this.syncType,
    this.exceptionCode,
    this.exception,
    this.result,
  );

  factory SyncResponseBean.fromJson(Map<String, dynamic> srcJson) => _$SyncResponseBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SyncResponseBeanToJson(this);
}

@JsonSerializable()
class Result extends Object {
  @JsonKey(name: 'Tables')
  List<Tables> tables;

  Result(
    this.tables,
  );

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Tables extends Object {
  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'ParamValues')
  List<String> paramValues;

  @JsonKey(name: 'Fields')
  String fields;

  @JsonKey(name: 'Rows')
  List<String> rows;

  Tables(
    this.name,
    this.paramValues,
    this.fields,
    this.rows,
  );

  factory Tables.fromJson(Map<String, dynamic> srcJson) => _$TablesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TablesToJson(this);
}
