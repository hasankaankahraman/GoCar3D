class DealerEntity {
  String dealerId;
  String dealerName;
  String dealerCity;
  Map<String, bool> inStocks;

  DealerEntity({
    required this.dealerId,
    required this.dealerName,
    required this.dealerCity,
    required this.inStocks,
  });

  Map<String, Object?> toDocument() {
    return {
      'dealerId': dealerId,
      'dealerName': dealerName,
      'dealerCity': dealerCity,
      'inStocks': inStocks,
    };
  }

  static DealerEntity fromDocument(Map<String, dynamic> doc) {
    return DealerEntity(
      dealerId: doc['dealerId'],
      dealerName: doc['dealerName'],
      dealerCity: doc['dealerCity'],
      inStocks: Map<String, bool>.from(doc['inStocks']),
    );
  }
}
