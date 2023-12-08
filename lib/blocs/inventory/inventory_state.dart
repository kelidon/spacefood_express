part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  final double temperature;

  const InventoryState({
    required this.temperature,
  });

  const InventoryState.empty() : this(temperature: 0);

  InventoryState copyWith({
    double? temperature,
  }) {
    return InventoryState(temperature: temperature ?? this.temperature);
  }

  @override
  List<Object?> get props => [temperature];
}
