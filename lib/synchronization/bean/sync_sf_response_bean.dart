/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-11 19:10

class SyncSfResponseBean {
    List<Record> records;

    SyncSfResponseBean({this.records});

    factory SyncSfResponseBean.fromJson(Map<String, dynamic> json) {
        return SyncSfResponseBean(
            records: json['records'] != null ? (json['records'] as List).map((i) => Record.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.records != null) {
            data['records'] = this.records.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Record {
    String fields;
    String name;
    List<String> values;

    Record({this.fields, this.name, this.values});

    factory Record.fromJson(Map<String, dynamic> json) {
        return Record(
            fields: json['fields'],
            name: json['name'],
            values: json['values'] != null ? new List<String>.from(json['values']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fields'] = this.fields;
        data['name'] = this.name;
        if (this.values != null) {
            data['values'] = this.values;
        }
        return data;
    }
}