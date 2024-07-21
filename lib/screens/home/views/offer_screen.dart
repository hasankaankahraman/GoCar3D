import 'package:flutter/material.dart';
import 'package:car_repository/car_repository.dart';

class OfferScreen extends StatelessWidget {
  final Car car;
  OfferScreen(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.modelname),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(car.pictures[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text("Offer screen content"),
        ],
      ),
    );
  }
}
