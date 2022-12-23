import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '../models/Lithostartigraphy.dart';

class Boxes {
  static Box<LithostratigraphyModel> getLithostratigraphy()  {
    return Hive.box('lithostratigraphy');
  }
}
