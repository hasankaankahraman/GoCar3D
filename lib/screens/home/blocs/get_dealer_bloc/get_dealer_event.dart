// lib/src/bloc/dealer_event.dart

import 'package:equatable/equatable.dart';

abstract class DealerEvent extends Equatable {
  const DealerEvent();

  @override
  List<Object> get props => [];
}

class LoadDealers extends DealerEvent {}
