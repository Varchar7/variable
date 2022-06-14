import 'package:flutter_bloc/flutter_bloc.dart';

class MessageSizeBloc extends Bloc<double, double> {
  MessageSizeBloc() : super(15) {
    on<double>((event, emit) {
      emit(event);
    });
  }
}
