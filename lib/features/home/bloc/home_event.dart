part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeInitalEvent extends HomeEvent {}

class HomeProductWhislistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWhislistButtonClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWhislistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
