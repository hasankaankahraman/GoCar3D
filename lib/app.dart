import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romaingirou/app_view.dart';
import 'package:user_repository/user_repository.dart';
import 'package:dealer_repository/dealer_repository.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final DealerRepo dealerRepo;

  const MyApp(this.userRepository, this.dealerRepo, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(userRepository: userRepository),
        ),
        RepositoryProvider<DealerRepo>(
          create: (context) => dealerRepo,
        ),
      ],
      child: const MyAppView(),
    );
  }
}