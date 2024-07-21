import 'package:car_repository/car_repository.dart';
import 'package:car_repository/src/entities/macros_entity.dart';

class CarEntity {
  String carId;
  String picture;
  String o3dmodel;
  List<dynamic> pictures;
  bool isEv;
  int type;
  String modelname;
  String brand;
  String description;
  int price;
  int discount;
  Macros macros;

  CarEntity({
    required this.carId,
    required this.picture,
    required this.o3dmodel,
    required this.pictures,
    required this.isEv,
    required this.type,
    required this.modelname,
    required this.brand,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  Map<String, Object?> toDocument() {
    return {
      'carId': carId,
      'picture': picture,
      'o3dmodel': o3dmodel,
      'pictures': pictures,
      'isEv': isEv,
      'type': type,
      'modelname': modelname,
      'brand': brand,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toEntity().toDocument(),
    };
  }

  static CarEntity fromDocument(Map<String, dynamic> doc) {
    return CarEntity(
      carId: doc['carId'],
      picture: doc['picture'],
      o3dmodel: doc['o3dmodel'],
      pictures: doc['pictures'],
      isEv: doc['isEv'],
      type: doc['type'],
      modelname: doc['modelname'],
      brand: doc['brand'],
      description: doc['description'],
      price: doc['price'],
      discount: doc['discount'],
      macros: Macros.fromEntity(MacrosEntity.fromDocument(doc['macros'])),
    );
  }
}