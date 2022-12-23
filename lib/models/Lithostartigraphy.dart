import 'dart:core';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'lithostartigraphy.g.dart';

@HiveType(typeId: 0)
class LithostratigraphyModel extends HiveObject{
//  late String _key?: any

  @HiveField(0)
  late String userId;
  @HiveField(1)
  late String country;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String lithologyMain;
  @HiveField(4)
  late String lithologySecondary;
  @HiveField(5)
  late String color;
  @HiveField(6)
  late String grainSize;
  @HiveField(7)
  late String grainShape;
  @HiveField(8)
  late String sorting;
  @HiveField(9)
  late String minerals;

  LithostratigraphyModel(
      {required this.userId,
      required this.country,
      required this.name,
      required this.lithologyMain,
      required this.lithologySecondary,
      required this.color,
      required this.grainSize,
      required this.grainShape,
      required this.sorting,
      required this.minerals});

  // static LithostratigraphyModel fromMap(Map<String, dynamic> json) {
  //   // print(json);
  //   return LithostratigraphyModel(
  //       userId: json['userId'].toString() as String,
  //       country: json['country'] as String,
  //       name: json['name'] as String,
  //       lithologyMain: json['lithologyMain'] as String,
  //       lithologySecondary: json['lithologySecondary'] as String,
  //       color: json['color'] as String,
  //       grainSize: json['grainSize'] as String,
  //       grainShape: json['grainShape'] as String,
  //       sorting: json['sorting'] as String,
  //       minerals: json['minerals'] as String);
  // }

  // static Map<String, Object?> toMap(LithostratigraphyModel values) {
  //   return Map.from({
  //     'userId': values.userId,
  //     'country': values.country,
  //     'name': values.name,
  //     'lithologyMain': values.lithologyMain,
  //     'lithologySecondary': values.lithologySecondary,
  //     'color': values.color,
  //     'grainSize': values.grainSize,
  //     'grainShape': values.grainShape,
  //     'sorting': values.sorting,
  //     'minerals': values.minerals
  //   });
  // }
}
