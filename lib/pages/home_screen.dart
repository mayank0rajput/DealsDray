import 'package:dealsdray_assignment/pages/HomeScreenWidget/home_kycpendingcard.dart';
import 'package:dealsdray_assignment/pages/HomeScreenWidget/home_screen_banner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Products.dart';
import 'HomeScreenWidget/home_screen_bottomNav.dart';
import 'HomeScreenWidget/home_screen_category.dart';
import 'HomeScreenWidget/home_screen_exclusive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _data;
  var banner;
  List<Products> items = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    var request = http.Request('GET', Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      setState(() {
        _data = json.decode(responseBody)['data'];
        loadData();
      });
    } else {
      print('Failed to load data: ${response.reasonPhrase}');
    }
    isLoading = false;
  }

  void loadData () {
    banner = [
      if (_data?['banner_one'] != null)
        ..._data?['banner_one'].map((item) => item['banner']).toList(),
      if (_data?['banner_two'] != null)
        ..._data?['banner_two'].map((item) => item['banner']).toList(),
      if (_data?['banner_three'] != null)
        ..._data?['banner_three'].map((item) => item['banner']).toList(),
    ];
    if (_data!.containsKey('products')) {
      var productsData = _data!['products'] as List<dynamic>;

      items = productsData.map((product) {
        return Products.fromJson(product as Map<String, dynamic>);
      }).toList();
    }
  }


  @override
  Widget build(BuildContext context) {
    var category = _data?['category'];
    return Scaffold(
      appBar: AppBar(
        title:  TextField(
          decoration: InputDecoration(
            hintText: 'Search here',
            prefixIcon: Image.asset('assets/dealsdray_logo.png',height: 50.0,),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: isLoading ?
      Center(child: CircularProgressIndicator()) :
      ListView(
        children: [
          buildBannerSection(banner),
          SizedBox(height: 5.0),
          KYCPendingCard(),
          SizedBox(height: 5.0),
          buildCategoriesSection(category),
          SizedBox(height: 10.0),
          ExclusiveForYouSection(products: items)
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
