import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'whislist_event.dart';
part 'whislist_state.dart';

class WhislistBloc extends Bloc<WhislistEvent, WhislistState> {
  WhislistBloc() : super(WhislistInitial()) {
    on<WhislistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
