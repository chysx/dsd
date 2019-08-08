import 'package:json_annotation/json_annotation.dart';

part 'sync_request_bean.g.dart';

@JsonSerializable()
class SyncRequestBean extends Object {
  @JsonKey(name: 'ReqContent')
  ReqContent reqContent;

  @JsonKey(name: 'DomainId')
  String domainId;

  @JsonKey(name: 'IsGzip')
  String isGzip;

  @JsonKey(name: 'LoginName')
  String loginName;

  @JsonKey(name: 'Password')
  String password;

  @JsonKey(name: 'Version')
  String version;

  SyncRequestBean([this.reqContent, this.domainId, this.isGzip, this.loginName, this.password, this.version]);

  SyncRequestBean.empty();

  factory SyncRequestBean.fromJson(Map<String, dynamic> srcJson) => _$SyncRequestBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SyncRequestBeanToJson(this);
}

@JsonSerializable()
class ReqContent extends Object {
  @JsonKey(name: 'Tables')
  List<Tables> tables;

  ReqContent([this.tables]);

  factory ReqContent.fromJson(Map<String, dynamic> srcJson) => _$ReqContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReqContentToJson(this);
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

  Tables([this.name, this.paramValues, this.fields, this.rows]);

  factory Tables.fromJson(Map<String, dynamic> srcJson) => _$TablesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TablesToJson(this);
}
