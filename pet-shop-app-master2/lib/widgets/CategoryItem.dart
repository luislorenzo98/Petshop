import 'package:flutter/material.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/models/CategoriaModel.dart';

import '../models/CategoriaModel.dart';

class CategoryItem extends StatelessWidget {
  final CategoriaModel category;
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:  category.nombre != null ? deepPurple : white,
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: white),
              child: Image(
                image: NetworkImage('http://192.168.29.2/petshop/img/'+category.url_categoria.toString()),
                height: 20,
              )),
          const SizedBox(width: 10),
          Text(
            category.nombre!,
            style: poppin.copyWith(
                color:  category.nombre != null ? white : deepPurple),
          )
        ],
      ),
    );
  }
}
