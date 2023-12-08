part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class TemperatureChange extends InventoryEvent {
  final double value;

  const TemperatureChange(this.value);

  @override
  List<Object?> get props => [value];
}
