import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/data/cart_items.dart';
import 'package:bloc_example/data/grocery_data.dart';
import 'package:bloc_example/data/whislist_items.dart';
import 'package:bloc_example/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //firest event is Inital event
    on<HomeInitalEvent>(homeInitalEvent);
    //on this event pass this state
    on<HomeProductWhislistButtonClickedEvent>(
        homeProductWhislistButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);

    on<HomeWhislistButtonNavigateEvent>(homeWhislistButtonNavigateEvent);

    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  //created a functions

  //first event when app gets opened
  Future<void> homeInitalEvent(
      HomeInitalEvent event, Emitter<HomeState> emit) async {
    //loading state is emitted
    emit(HomeLoadingState());
    //second duration
    await Future.delayed(Duration(seconds: 2));
    //third success state
    //your products in list form
    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map(
              (e) => ProductDataModel(
                  id: e['id'],
                  name: e['name'],
                  description: e['description'],
                  price: e['price'],
                  imageUrl: e['imageUrl']),
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> homeProductWhislistButtonClickedEvent(
      HomeProductWhislistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Whislist Product clicked');
    //passing data through event
    whislistItems.add(event.clickedProduct);
    //emit the state
    emit(HomeProductItemWhislistActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Product clicked');
    //passing data through event
    cartItems.add(event.clickedProduct);
    //emit the state
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWhislistButtonNavigateEvent(
      HomeWhislistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Whislist Navigate clicked');
    //action state
    emit(HomeNavigateToWhislistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate clicked');
    //action state
    emit(HomeNavigateToCartPageActionState());
  }
}
