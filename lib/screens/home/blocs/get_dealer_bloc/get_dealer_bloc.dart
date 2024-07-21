// lib/src/bloc/dealer_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dealer_repository/dealer_repository.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_event.dart';
import 'package:romaingirou/screens/home/blocs/get_dealer_bloc/get_dealer_state.dart';


class DealerBloc extends Bloc<DealerEvent, DealerState> {
  final DealerRepo dealerRepo;

  DealerBloc({required this.dealerRepo}) : super(DealerInitial()) {
    on<LoadDealers>(_onLoadDealers);
  }

  void _onLoadDealers(LoadDealers event, Emitter<DealerState> emit) async {
    emit(DealerLoading());
    try {
      final dealers = await dealerRepo.getDealers();
      emit(DealerLoaded(dealers: dealers));
    } catch (_) {
      emit(DealerError());
    }
  }
}