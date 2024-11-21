import 'package:bloc_example/features/cart/cart_tile.dart';
import 'package:bloc_example/features/cart/ui/bloc/cart_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    //initail event
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Cart Items',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  blurRadius: 5.0,
                  offset: Offset(3.0, 3.0),
                  color: Colors.grey),
            ],
          ),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final sucessState = state as CartSuccessState;
              return ListView.builder(
                itemCount: sucessState.cartItems.length,
                itemBuilder: (context, index) {
                  return CartTileWidget(
                      cartBloc: cartBloc,
                      productDataModel: sucessState.cartItems[index]);
                },
              );

            default:
          }

          return Container();
        },
      ),
    );
  }
}
