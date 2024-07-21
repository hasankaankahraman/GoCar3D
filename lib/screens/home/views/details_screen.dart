import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_repository/car_repository.dart';
import 'package:dealer_repository/dealer_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:o3d/o3d.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_bloc.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_event.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_state.dart';
import '../../../components/macro.dart';

class DetailsScreen extends StatefulWidget {
  final Car car;
  const DetailsScreen(this.car, {super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? selectedDealerName, selectedDealerCity;

  void showModelViewer(BuildContext context, String modelUrl) {
    final O3DController modelController = O3DController();
    print('Model URL: $modelUrl');  // URL'yi konsola yazdırarak kontrol edin

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('3D Model Görünümü'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: O3D(
              controller: modelController,
              src: modelUrl,
              //src: 'assets/m3.glb'
              //src: 'https://gocar-6c342.web.app/m3.glb',
            ),
          ),
              //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb'
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealerBloc(
        dealerRepo: context.read<DealerRepo>(),
      )..add(LoadDealers()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: PageView.builder(
                  itemCount: widget.car.pictures.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(widget.car.pictures[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.car.description,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModelViewer(context, widget.car.o3dmodel);
                },
                child: Text(
                  widget.car.modelname,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<DealerBloc, DealerState>(
                builder: (context, state) {
                  if (state is DealerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DealerLoaded) {
                    final dealers = state.dealers
                        .where((dealer) => dealer.inStocks[widget.car.carId] ?? false)
                        .toList();
                    return Column(
                      children: [
                        for (int i = 0; i < dealers.length; i += 3)
                          Row(
                            children: [
                              for (int j = i; j < i + 3 && j < dealers.length; j++)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedDealerName = dealers[j].dealerName;
                                        selectedDealerCity = dealers[j].dealerCity;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: (selectedDealerName == dealers[j].dealerName &&
                                            selectedDealerCity == dealers[j].dealerCity)
                                            ? Colors.green
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(3, 3),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            dealers[j].dealerName,
                                            style: TextStyle(
                                              color: (selectedDealerName == dealers[j].dealerName &&
                                                  selectedDealerCity == dealers[j].dealerCity)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            dealers[j].dealerCity,
                                            style: TextStyle(
                                              color: (selectedDealerName == dealers[j].dealerName &&
                                                  selectedDealerCity == dealers[j].dealerCity)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    );
                  } else if (state is DealerError) {
                    return const Text("An error has occurred...");
                  } else {
                    return const Text("No dealers found.");
                  }
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(
                                    widget.car.modelname,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.car.carId,
                                    style: const TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${widget.car.price - (widget.car.price * (widget.car.discount) / 100)}0",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Text(
                                    "\$${widget.car.price}.00",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          MyMacroWidget(
                            title: "High Speed",
                            value: widget.car.macros.highspeed,
                            icon: FontAwesomeIcons.gaugeHigh,
                          ),
                          const SizedBox(width: 10),
                          MyMacroWidget(
                            title: "Horse Power",
                            value: widget.car.macros.horsepower,
                            icon: FontAwesomeIcons.horseHead,
                          ),
                          const SizedBox(width: 10),
                          MyMacroWidget(
                            title: "Model Year",
                            value: widget.car.macros.modelyear,
                            icon: FontAwesomeIcons.solidCalendarDays,
                          ),
                          const SizedBox(width: 10),
                          MyMacroWidget(
                            title: "Displacement",
                            value: widget.car.macros.displacement,
                            icon: FontAwesomeIcons.breadSlice,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Teklif İsteği"),
                                  content: Text(
                                    "${selectedDealerCity ?? ''}'daki ${selectedDealerName ?? ''} bayisinde teklif alma isteği gönderildi.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Tamam"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Teklif Al",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
