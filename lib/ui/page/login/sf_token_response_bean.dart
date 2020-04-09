/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-09 15:03

class SFTokenResponseBean {
    String accessToken;
    String error;
    String errorDescription;
    String id;
    String instanceUrl;
    String issuedAt;
    String orgId;
    String signature;
    String tokenType;
    String userId;

    SFTokenResponseBean({this.accessToken, this.error, this.errorDescription, this.id, this.instanceUrl, this.issuedAt, this.orgId, this.signature, this.tokenType, this.userId});

    factory SFTokenResponseBean.fromJson(Map<String, dynamic> json) {
        return SFTokenResponseBean(
            accessToken: json['access_token'],
            error: json['error'],
            errorDescription: json['error_description'],
            id: json['id'],
            instanceUrl: json['instance_url'],
            issuedAt: json['issued_at'],
            orgId: json['org_id'],
            signature: json['signature'],
            tokenType: json['token_type'],
            userId: json['user_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['access_token'] = this.accessToken;
        data['error'] = this.error;
        data['error_description'] = this.errorDescription;
        data['id'] = this.id;
        data['instance_url'] = this.instanceUrl;
        data['issued_at'] = this.issuedAt;
        data['org_id'] = this.orgId;
        data['signature'] = this.signature;
        data['token_type'] = this.tokenType;
        data['user_id'] = this.userId;
        return data;
    }
}