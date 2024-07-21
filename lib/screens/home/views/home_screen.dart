import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romaingirou/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:romaingirou/screens/home/blocs/get_car_bloc/get_car_bloc.dart';
import 'package:romaingirou/screens/home/views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset('assets/fiat-egea-hb.png', scale: 14),
            const SizedBox(width: 8),
            const Text(
              'GoCar',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetCarBloc, GetCarState>(
          builder: (context, state) {
            if (state is GetCarSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 9 / 12,
                ),
                itemCount: state.cars.length,
                itemBuilder: (context, i) {
                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => DetailsScreen(
                                state.cars[i]
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(state.cars[i].picture),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 19.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: state.cars[i].isEv ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Text(
                                      state.cars[i].isEv ? "EV" : "NON-EV",
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Text(
                                      state.cars[i].type == 1 ? "⚠️ ECO" : state.cars[i].type == 2 ? "⚠️ COMFORT" : "⚠️ SPORT",
                                      style: TextStyle(
                                        color: state.cars[i].type == 1 ? Colors.green : state.cars[i].type == 2 ? Colors.orange : Colors.redAccent,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              state.cars[i].modelname,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "\$${state.cars[i].price - (state.cars[i].price * (state.cars[i].discount) / 100)}0",
                                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "\$${state.cars[i].price}.00",
                                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w700, decoration: TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                                IconButton(onPressed: () {}, icon: const Icon(Icons.add_shopping_cart))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is GetCarLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("An error has occurred..."),
              );
            }
          },
        ),
      ),
    );
  }
}