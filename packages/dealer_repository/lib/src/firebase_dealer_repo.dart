import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealer_repository/dealer_repository.dart';


class FirebaseDealerRepo implements DealerRepo {
  final dealerCollection = FirebaseFirestore.instance.collection('dealers');

  @override
  Future<List<Dealer>> getDealers() async {
    try {
      return await dealerCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Dealer.fromEntity(DealerEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}