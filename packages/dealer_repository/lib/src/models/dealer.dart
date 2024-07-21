import '../entities/dealer_entity.dart';

class Dealer {
  String dealerId;
  String dealerName;
  String dealerCity;
  Map<String, bool> inStocks;

  Dealer({
    required this.dealerId,
    required this.dealerName,
    required this.dealerCity,
    required this.inStocks,
  });

  DealerEntity toEntity(){
    return DealerEntity(
      dealerId: dealerId,
      dealerName: dealerName,
      dealerCity: dealerCity,
      inStocks: inStocks,
    );
  }

  static Dealer fromEntity(DealerEntity entity) {
    return Dealer(
      dealerId: entity.dealerId,
      dealerName: entity.dealerName,
      dealerCity: entity.dealerCity,
      inStocks: entity.inStocks,
    );
  }
}
