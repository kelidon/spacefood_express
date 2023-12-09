import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(const InventoryState.empty()) {
    on<TemperatureChange>(
      (event, emit) => emit(
        state.copyWith(temperature: state.temperature + event.value),
      ),
    );

    on<TimeChange>(
          (event, emit) => emit(
        state.copyWith(temperature: state.temperature + event.value),
      ),
    );
  }
}
