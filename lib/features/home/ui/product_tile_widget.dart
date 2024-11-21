import 'package:bloc_example/features/home/bloc/home_bloc.dart';
import 'package:bloc_example/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.blueGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            productDataModel.name,
            style: TextStyle(
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 1.0,
                  color: Colors.grey,
                ),
              ],
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            productDataModel.description,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rs. ' + productDataModel.price.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWhislistButtonClickedEvent(
                            clickedProduct: productDataModel));
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
                        homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: productDataModel));
                      },
                      icon: Icon(
                        shadows: [
                          Shadow(blurRadius: 20),
                        ],
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
