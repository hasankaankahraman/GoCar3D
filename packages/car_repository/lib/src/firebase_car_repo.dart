import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_repository/car_repository.dart';

class FirebaseCarRepo implements CarRepo {
  final carCollection = FirebaseFirestore.instance.collection('cars');

  @override
  Future<List<Car>> getCars() async {
    try {
      return await carCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Car.fromEntity(CarEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}