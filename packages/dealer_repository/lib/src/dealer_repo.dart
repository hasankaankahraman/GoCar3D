import 'models/models.dart';

abstract class DealerRepo {
  Future<List<Dealer>> getDealers();
}
