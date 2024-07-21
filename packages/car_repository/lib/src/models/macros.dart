import '../entities/macros_entity.dart';

class Macros {
  int highspeed;
  int horsepower;
  int modelyear;
  int displacement;

  Macros({
    required this.highspeed,
    required this.horsepower,
    required this.modelyear,
    required this.displacement,
  });

  MacrosEntity toEntity() {
    return MacrosEntity(
      highspeed: highspeed,
      horsepower: horsepower,
      modelyear: modelyear,
      displacement: displacement,
    );
  }

  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
        highspeed: entity.highspeed,
        horsepower: entity.horsepower,
        modelyear: entity.modelyear,
        displacement: entity.displacement
    );
  }
}