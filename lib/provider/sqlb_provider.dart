import 'package:flutter/material.dart';

import '../database_helper.dart';

class SQLBProvider extends ChangeNotifier{
  final DatabaseHelper _db = DatabaseHelper.instance;
}