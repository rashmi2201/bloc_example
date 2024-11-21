import 'package:bloc_example/features/cart/ui/cart.dart';
import 'package:bloc_example/features/home/bloc/home_bloc.dart';
import 'package:bloc_example/features/home/ui/product_tile_widget.dart';
import 'package:bloc_example/features/whislist/ui/whislist.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitalEvent());

    super.initState();
  }

  //instance of homebloc
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      // //listenwhen paramter is for listening(action state)
      listenWhen: (previous, current) => current is HomeActionState,
      //buildwhen paramter is for not listening (action state)
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        //here we are getting some state taking action

        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ));
        } else if (state is HomeNavigateToWhislistPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Whislist(),
              ));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  'Woww! 🥭',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        } else if (state is HomeProductItemWhislistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  'Great 🍎 ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        //three state that handling the builder
        switch (state.runtimeType) {
          //first loading state
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          //second success state
          case HomeLoadedSuccessState:
            //use this success vairable as
            final sucessState = state as HomeLoadedSuccessState;

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60,
                leadingWidth: 20,
                backgroundColor: Colors.yellow.shade500,
                surfaceTintColor: Colors.transparent,
                elevation: 50,
                titleTextStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                shape: Border.all(color: Colors.black),
                title: Text(
                  'Grocery App',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 3.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWhislistButtonNavigateEvent());
                      },
                      icon: Icon(
                        shadows: [
                          Shadow(blurRadius: 20),
                        ],
                        Icons.favorite_border,
                        color: Colors.black,
                      )),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeCartButtonNavigateEvent(),
                      );
                    },
                    icon: Icon(
                      shadows: [
                        Shadow(blurRadius: 20),
                      ],
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: sucessState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                      homeBloc: homeBloc,
                      productDataModel: sucessState.products[index]);
                },
              ),
            );

          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
