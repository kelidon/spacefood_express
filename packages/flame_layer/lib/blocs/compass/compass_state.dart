part of 'compass_cubit.dart';

class CompassState extends Equatable {
  const CompassState(this.angle);

  final double angle;

  @override
  List<Object?> get props => [angle];
}
