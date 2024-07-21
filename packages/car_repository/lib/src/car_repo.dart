import 'models/models.dart';

abstract class CarRepo {
  Future<List<Car>> getCars();

}