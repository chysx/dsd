import 'i_parse_policy.dart';
import 'i_parser_flow.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/29 11:44

abstract class AbstractParser<T> implements IParserFlow<T> {
  IParsePolicy parsePolicy;

  AbstractParser(this.parsePolicy);
}
