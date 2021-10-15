import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import '/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import '/Authentication/AuthenticationBloc/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignUpBloc/signup_bloc.dart';
import '/Authentication/AuthenticationBloc/SignUpCubit/signup_cubit.dart';
import '/Authentication/AuthenticationBloc/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';
import '/Authentication/Screens/ForgotPasswordScreen.dart';
import '/Authentication/Screens/SignupScreen.dart';
import '/Common/AppTheme/ThemeBloc/theme_bloc.dart';
import '/Common/AppTheme/ThemePreferenses.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import '/Common/Widgets/ButtonForApp.dart';
import '/Common/Widgets/TextFieldHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
/*  _setTheme(bool darkTheme) {
    AppTheme selectedTheme =
        darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
    context.read<ThemeBloc>().add(ThemeEvent(appTheme: selectedTheme));
    Preferences.saveTheme(selectedTheme);
  }*/

  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _loadTheme(pref);
  }

  _loadTheme(SharedPreferences preferences) {
    context.read<ThemeBloc>().add(ThemeEvent(
        appTheme: Preferences.getTheme(
            preferences, context.read<ThemebasedwidgetCubit>())));
  }

  @override
  void initState() {
    //_curTheme = AppTheme.lightTheme;
    getSharedPref();
    super.initState();
  }

  loginFunc() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      context.read<LoadingscreenCubit>().changeLoadingState(false);
      context.read<LoginCubit>().checkUserLogin(
          context, _emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pass = BlocProvider.of<ShowhidepasswordCubit>(context);

    print('nnn build');
    return WillPopScope(
      onWillPop: () {
        //loadingCubit.changeLoadingState(true);
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 12,
            //        leading: IconButton(
            //          icon: Image.asset('images/fluenzologo.png'), onPressed: () {}),
            title: Text(
              appName,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: BlocBuilder<LoadingscreenCubit, LoadingscreenState>(
            builder: (context, state) {
              return state.isNotLoading
                  ? Container(
                      width: getWidth(context),
                      height: getHeight(context),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getWidth(context) * 0.2,
                            ),
                            Container(
                              child: Image.asset('images/fluenzologo.png'),
                            ),
                            SizedBox(
                              height: getWidth(context) * 0.07,
                            ),
                            Container(
                              width: getWidth(context) * 0.9,
                              height: getWidth(context) * 0.75,
                              child: Form(
                                  key: _loginFormKey,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textFieldHeader(context,
                                            'Username/Email/MobileNumber'),
                                        TextFormField(
                                          controller: _emailController,
                                          textInputAction: TextInputAction.next,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Enter Email/UserName/Mobile Number';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left:
                                                      getWidth(context) * 0.05),
                                              hintText: 'Username',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getWidth(context) *
                                                              0.1))),
                                        ),
                                        SizedBox(
                                          height: getWidth(context) * 0.07,
                                        ),
                                        textFieldHeader(context, 'Password'),
                                        BlocBuilder<ShowhidepasswordCubit,
                                            ShowHidePasswordState>(
                                          builder: (context, state) {
                                            print('nnn Widget');
                                            return TextFormField(
                                                onFieldSubmitted: (String v) {
                                                  loginFunc();
                                                },
                                                controller: _passwordController,
                                                validator: (val) {
                                                  if (!RegExp(
                                                          r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                                                      .hasMatch(val!)) {
                                                    return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          state.showHidePassWord
                                                              ? pass
                                                                  .updateShowHidePasswordBool(
                                                                      false)
                                                              : pass
                                                                  .updateShowHidePasswordBool(
                                                                      true);
                                                        },
                                                        icon: Icon(
                                                          state.showHidePassWord
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                        )),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: getWidth(
                                                                    context) *
                                                                0.05),
                                                    hintText: 'Password',
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(getWidth(
                                                                    context) *
                                                                0.1))),
                                                obscureText:
                                                    state.showHidePassWord);
                                          },
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: getWidth(context) * 0.02),
                                          alignment: Alignment.topRight,
                                          width: getWidth(context),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ForgotPasswordScreen()));
                                              },
                                              child: Text(
                                                'Forget Password?',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ),
                                      ])),
                            ),
                            AppButton(
                              ctx: scaffoldKey,
                              title: 'Login',
                              func: loginFunc,
                            ),
                            SizedBox(height: getWidth(context) * 0.007),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MultiProvider(providers: [
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
                                    ], child: SignUpScreen()),
                                  ),
                                );
                              },
                              child: Container(
                                height: getWidth(context) * 0.08,
                                width: getWidth(context) * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'New Here?',
                                    ),
                                    Text(
                                      'SignUp here',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
