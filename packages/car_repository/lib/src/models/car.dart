import 'package:car_repository/src/entities/car_entity.dart';
import '../entities/entities.dart';
import 'models.dart';

class Car {
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

  Car({
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

  CarEntity toEntity() {
    return CarEntity(
      carId: carId,
      picture: picture,
      o3dmodel: o3dmodel,
      pictures: pictures,
      isEv: isEv,
      type: type,
      modelname: modelname,
      brand: brand,
      description: description,
      price: price,
      discount: discount,
      macros: macros,
    );
  }

  static Car fromEntity(CarEntity entity) {
    return Car(
      carId: entity.carId,
      picture: entity.picture,
      o3dmodel: entity.o3dmodel,
      pictures: entity.pictures,
      isEv: entity.isEv,
      type: entity.type,
      modelname: entity.modelname,
      brand: entity.brand,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      macros: entity.macros,
    );
  }
}