import 'package:car_repository/car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romaingirou/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:romaingirou/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:romaingirou/screens/home/blocs/get_car_bloc/get_car_bloc.dart';
import 'package:dealer_repository/dealer_repository.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_bloc.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_event.dart';

import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoCar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => GetCarBloc(FirebaseCarRepo())..add(GetCar()),
                ),
                BlocProvider(
                  create: (context) => DealerBloc(
                    dealerRepo: context.read<DealerRepo>(),
                  )..add(LoadDealers()),
                ),
              ],
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        }),
      ),
    );
  }
}