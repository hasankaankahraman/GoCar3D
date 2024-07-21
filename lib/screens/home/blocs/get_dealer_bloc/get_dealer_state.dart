// lib/src/bloc/dealer_state.dart

import 'package:equatable/equatable.dart';
import 'package:dealer_repository/dealer_repository.dart';

abstract class DealerState extends Equatable {
  const DealerState();

  @override
  List<Object> get props => [];
}

class DealerInitial extends DealerState {}

class DealerLoading extends DealerState {}

class DealerLoaded extends DealerState {
  final List<Dealer> dealers;

  const DealerLoaded({required this.dealers});

  @override
  List<Object> get props => [dealers];
}

class DealerError extends DealerState {}