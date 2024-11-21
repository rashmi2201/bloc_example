import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/data/cart_items.dart';
import 'package:bloc_example/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    //on this event i want to run a function
    on<CartInitialEvent>(cartInitialEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    //emitting the success state which putten in cart
    emit(CartSuccessState(cartItems: cartItems));
  }
}
