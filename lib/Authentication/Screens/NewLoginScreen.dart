import '/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import '/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import '/Authentication/AuthenticationBloc/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignUpBloc/signup_bloc.dart';
import '/Authentication/AuthenticationBloc/SignUpCubit/signup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Authentication/AuthenticationBloc/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';
import '/Authentication/Screens/ForgotPasswordScreen.dart';
import '/Authentication/Screens/NewSignupScreen.dart';
import '/Common/AppTheme/ThemeBloc/theme_bloc.dart';
import '/Common/AppTheme/ThemePreferenses.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Widgets/NewCircularElevattedButton.dart';
import '/Common/Widgets/NewTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class NewLoginScreen extends StatefulWidget {
  NewLoginScreen({Key? key}) : super(key: key);

  @override
  _NewLoginScreenState createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _loadTheme(pref);
  }

  _loadTheme(SharedPreferences preferences) {
    context.read<ThemeBloc>().add(ThemeEvent(
        appTheme: Preferences.getTheme(
            preferences, context.read<ThemebasedwidgetCubit>())));
  }

  loginFunc() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      context.read<LoadingscreenCubit>().changeLoadingState(false);
      context.read<LoginCubit>().checkUserLogin(
          context, userNameController.text, passwordController.text);
    }
  }

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginPassWordVisibilityCubit =
        BlocProvider.of<ShowhidepasswordCubit>(context);
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.40), BlendMode.darken),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/AuthenticationBG.jpg'))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/journzpng2.png')
                    .box
                    .width(40)
                    .height(40)
                    // .width(context.screenWidth * 0.15)
                    // .height(context.screenWidth * 0.15)
                    .makeCentered(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "JOURNZ"
                        .text
                        .white
                        .xl4
                        .bold
                        //.letterSpacing(context.screenWidth * 0.045)
                        .make(),
                    10.heightBox,
                    "Journal of Your Lifetime Journey"
                        .text
                        .white
                        .lg
                        .tight
                        .align(TextAlign.right)
                        .bold
                        .make(),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black,
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NewTextFormField(
                      readOnly: false,
                      keyBoardType: TextInputType.name,
                      newWidth: context.screenWidth,
                      //newHeight: 50,
                      hintText: 'UserName \\ Email \\ Mobile Number',
                      controller: userNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter Email/UserName/Mobile Number';
                        }
                      }),
                  20.heightBox,
                  BlocBuilder<ShowhidepasswordCubit, ShowHidePasswordState>(
                    builder: (context, passwordState) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: passwordState.showHidePassWord,
                        onFieldSubmitted: (String v) {
                          loginFunc();
                        },
                        validator: (val) {
                          if (!RegExp(
                                  r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                              .hasMatch(val!)) {
                            return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: Colors.black.withOpacity(0.35),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordState.showHidePassWord) {
                                    loginPassWordVisibilityCubit
                                        .updateShowHidePasswordBool(false);
                                  } else {
                                    loginPassWordVisibilityCubit
                                        .updateShowHidePasswordBool(true);
                                  }
                                },
                                icon: passwordState.showHidePassWord
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    },
                  ),
                  InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: "Forgot Password?".text.white.bold.lg.make())
                      .box
                      .alignCenterRight
                      .width(150)
                      .height(40)
                      .makeCentered(),
                  20.heightBox,
                  NewCircularElevattedButton(
                    name: "Sign in",
                    func: loginFunc,
                    padHorizontal: 40,
                    padVertical: 20,
                    fontSize: 15,
                  ),
                  20.heightBox,
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MultiBlocProvider(providers: [
                                  BlocProvider(
                                      create: (context) =>
                                          SignupcheckboxCubit()),
                                  BlocProvider(
                                      create: (context) =>
                                          LoadingscreenCubit()),
                                  BlocProvider(
                                      create: (context) => SignupCubit()),
                                  BlocProvider(
                                      create: (context) =>
                                          ShowhidepasswordinsignupCubit()),
                                  BlocProvider(
                                      create: (context) =>
                                          ShowHideReEnterPasswordCubit()),
                                  BlocProvider(
                                      create: (context) => SignupBloc())
                                ], child: NewSignupScreen()),
                              ),
                            );
                          },
                          child: "New to Journz? Sign up Here.."
                              .text
                              .white
                              .bold
                              .xl
                              .wordSpacing(2)
                              .makeCentered())
                      .box
                      .width(220)
                      .height(40)
                      .makeCentered(),
                ],
              ).p12(),
            ),
          ),
        )
      ],
    ));
  }
}
