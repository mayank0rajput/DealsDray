import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildBottomNavigationBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',),
      BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories'
          ),
      BottomNavigationBarItem(
        icon: SizedBox(
          height: 23.0, // Set the height of the icon
          child: Image.asset('assets/dealsdray_logo.png',fit: BoxFit.cover,),
        ),
        label: 'Deals',
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart'
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
          ),
    ],
    selectedItemColor: Colors.redAccent,
  );
}