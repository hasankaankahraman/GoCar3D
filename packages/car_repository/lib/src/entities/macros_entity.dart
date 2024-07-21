class MacrosEntity {
  int highspeed;
  int horsepower;
  int modelyear;
  int displacement;

  MacrosEntity({
    required this.highspeed,
    required this.horsepower,
    required this.modelyear,
    required this.displacement,

});

  Map<String, Object?> toDocument() {
    return {
      'highspeed': highspeed,
      'horsepower': horsepower,
      'modelyear': modelyear,
      'displacement': displacement
    };
  }

  static MacrosEntity fromDocument(Map<String, dynamic> doc) {
    return MacrosEntity(
      highspeed: doc['highspeed'],
      horsepower: doc['horsepower'],
      modelyear: doc['modelyear'],
      displacement: doc['displacement'],
    );
  }
}