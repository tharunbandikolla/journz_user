import 'dart:async';

import '/Common/Constant/Constants.dart';
import '/Common/Helper/BottomNavBar/bottomnavbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tab2HomeScreen extends StatefulWidget {
  final String message;
  const Tab2HomeScreen({Key? key, required this.message}) : super(key: key);

  @override
  _Tab2HomeScreenState createState() => _Tab2HomeScreenState();
}

class _Tab2HomeScreenState extends State<Tab2HomeScreen> {
  late Timer t;

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BlocProvider.of<BottomnavbarCubit>(context);
    t = Timer(Duration(seconds: 2), () {
      //Navigator.pushAndRemoveUntil(
      //  context,
      // MaterialPageRoute(
      //  builder: (context) => HomeScreen(
      //  curIndex: 0,
      // ),
      // ),
      // (route) => false);
      bottomNavBarCubit.setCurrentIndex(0);
    });

    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        alignment: Alignment.bottomCenter,
        child: AlertDialog(
          content: Text('${widget.message} Secion Coming Soon'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
  }
}
