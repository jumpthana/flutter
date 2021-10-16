import 'package:basic_flutter/widget/my_service.dart';
import 'package:basic_flutter/widget/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widget/authen.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
};
