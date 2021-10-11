import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import '/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import '/Authentication/Screens/LoginScreen.dart';
import '/Common/Constant/Constants.dart';

class UserNotLoggedInScreen extends StatelessWidget {
  const UserNotLoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: getWidth(context),
      height: getHeight(context),
      child: Column(
        children: [
          Container(
            width: getWidth(context),
            height: getWidth(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/mobileLife.png'))),
          ),
          SizedBox(height: getWidth(context) * 0.003),
          Container(
              child: Text(
            'Looks Like You are Not logged In',
            style: Theme.of(context).textTheme.headline6,
          )),
          SizedBox(height: getWidth(context) * 0.07),
          Container(
              child: Text(
            'To Login',
            style: Theme.of(context).textTheme.headline6,
          )),
          SizedBox(height: getWidth(context) * 0.07),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(providers: [
                              BlocProvider(
                                  create: (context) => ShowhidepasswordCubit()),
                              BlocProvider(create: (context) => LoginCubit())
                            ], child: LoginScreen())));
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) return Colors.red;
                return null;
              })),
              child: Text('Click Me.!'))
        ],
      ),
    ));
  }
}
