part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  final double temperature;
  final double time;

  const InventoryState({
    required this.temperature,
    required this.time,
  });

  const InventoryState.empty() : this(temperature: 50, time: 3);

  InventoryState copyWith({double? temperature, double? time}) {
    return InventoryState(temperature: temperature ?? this.temperature, time: time ?? this.time);
  }

  @override
  List<Object?> get props => [temperature, time];
}
