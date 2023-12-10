

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'compass_state.dart';

class CompassCubit extends Cubit<CompassState> {
  CompassCubit() : super(const CompassState(0));

  void changeAngle(double newAngle){
    emit(CompassState(newAngle));
  }
}
