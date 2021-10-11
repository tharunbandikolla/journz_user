import 'dart:io';
import 'dart:ui';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import '/Authentication/AuthenticationBloc/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignUpCubit/signup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Authentication/AuthenticationBloc/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';
import '/Authentication/DataServices/SignupDatabase.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import '/Common/Widgets/AlertDialogWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import '/Common/Widgets/ButtonForApp.dart';
import '/Common/Widgets/TextFieldHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _signUpFormkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  File? profilePic;
  bool checked = false;
  String? token;

  @override
  Widget build(BuildContext context) {
    final passwordCubit =
        BlocProvider.of<ShowhidepasswordinsignupCubit>(context);
    final reEnterPasswordCubit =
        BlocProvider.of<ShowHideReEnterPasswordCubit>(context);
    final checkBoxCubit = BlocProvider.of<SignupcheckboxCubit>(context);
    final signupCubit = BlocProvider.of<SignupCubit>(context);
    final loadingscreenCubit = BlocProvider.of<LoadingscreenCubit>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        //leading: IconButton(
        //  icon: Image.asset('images/fluenzologo.png'), onPressed: () {}),
        title: Text(
          appName,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(getWidth(context) * 0.03),
            width: getWidth(context),
            height: getHeight(context) * 1.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getWidth(context) * 0.02),
                Container(
                  child: Form(
                    key: _signUpFormkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: getWidth(context),
                            height: getWidth(context) * 0.24,
                            //constraints: BoxConstraints(
                            //  maxHeight: getWidth(context) * 0.2,
                            // maxWidth: getWidth(context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: textFieldHeader(
                                              context, 'First Name')),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Enter a Valid Name';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left:
                                                      getWidth(context) * 0.05),
                                              hintText: 'First Name',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getWidth(context) *
                                                              0.1))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: getWidth(context) * 0.01),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: textFieldHeader(
                                              context, 'Last Name')),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _lastNameController,
                                          textInputAction: TextInputAction.next,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'Enter a Valid Name';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left:
                                                      getWidth(context) * 0.05),
                                              hintText: 'Last Name',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getWidth(context) *
                                                              0.1))),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getWidth(context) * 0.025,
                          ),
                          textFieldHeader(context, 'Email'),
                          TextFormField(
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (!RegExp(
                                      r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                      caseSensitive: false)
                                  .hasMatch(val!)) {
                                return 'Enter a Valid Email';
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: getWidth(context) * 0.05),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        getWidth(context) * 0.1))),
                          ),
                          SizedBox(
                            height: getWidth(context) * 0.025,
                          ),
                          textFieldHeader(context, 'UserName'),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter a Valid Name';
                              }
                            },
                            controller: _userNameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: getWidth(context) * 0.05),
                                hintText: 'Username',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        getWidth(context) * 0.1))),
                          ),
                          SizedBox(
                            height: getWidth(context) * 0.025,
                          ),
                          textFieldHeader(context, 'Password'),
                          BlocBuilder<ShowhidepasswordinsignupCubit,
                              ShowhidepasswordinsignupState>(
                            builder: (context, state) {
                              return TextFormField(
                                  controller: _passwordController,
                                  textInputAction: TextInputAction.next,
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
                                            state.passWordInSignup
                                                ? passwordCubit
                                                    .updateSignUpPasswordBool(
                                                        false)
                                                : passwordCubit
                                                    .updateSignUpPasswordBool(
                                                        true);
                                          },
                                          icon: Icon(
                                            state.passWordInSignup
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          )),
                                      contentPadding: EdgeInsets.only(
                                          left: getWidth(context) * 0.05),
                                      hintText:
                                          'Must Contain (\'a-z\' \'0-9\' \'@#\')',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              getWidth(context) * 0.1))),
                                  obscureText: state.passWordInSignup);
                            },
                          ),
                          SizedBox(
                            height: getWidth(context) * 0.025,
                          ),
                          textFieldHeader(context, 'Re-enter Password'),
                          BlocBuilder<ShowHideReEnterPasswordCubit,
                              ShowHideReEnterPasswordState>(
                            builder: (context, state) {
                              return TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _reEnterPasswordController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            state.showHideReEnterPassWord
                                                ? reEnterPasswordCubit
                                                    .updateShowHidePasswordBool(
                                                        false)
                                                : reEnterPasswordCubit
                                                    .updateShowHidePasswordBool(
                                                        true);
                                          },
                                          icon: Icon(
                                            state.showHideReEnterPassWord
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          )),
                                      contentPadding: EdgeInsets.only(
                                          left: getWidth(context) * 0.05),
                                      hintText: 'Retype Password',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              getWidth(context) * 0.1))),
                                  obscureText: state.showHideReEnterPassWord);
                            },
                          ),
                          SizedBox(
                            height: getWidth(context) * 0.025,
                          ),
                          textFieldHeader(context, 'Mobile Number'),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _mobileNumberController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter 10 Digit Mobile Number';
                              } else if (val.length != 10) {
                                return 'Enter 10 Digit Mobile Number';
                              }
                            },
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                prefixText: '+91',
                                contentPadding: EdgeInsets.only(
                                    left: getWidth(context) * 0.05),
                                hintText: 'Mobile Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        getWidth(context) * 0.1))),
                          ),
                          SizedBox(height: getWidth(context) * 0.01),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Future.delayed(Duration(milliseconds: 500), () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShowAlertDialog(
                                          alertType: 'Terms & Condition',
                                          alertMessage: userTerms);
                                    });
                              });
                            },
                            child: "Please Read Terms & Conditions"
                                .text
                                .blue400
                                .lg
                                .underline
                                .make()
                                .box
                                .padding(EdgeInsets.only(left: 28))
                                .height(context.screenWidth * 0.05)
                                .width(context.screenWidth * 0.9)
                                .make(),
                          ).box.p16.make(),
                          Container(
                            width: getWidth(context),
                            child: Column(children: [
                              BlocBuilder<SignupcheckboxCubit,
                                  SignupcheckboxState>(
                                builder: (context, state) {
                                  checked = state.check;
                                  token = state.token;
                                  print('Token data $token');
                                  return CheckboxListTile(
                                    title:
                                        Text("Agree All Terms & Conditions."),
                                    value: state.check,
                                    onChanged: (newValue) {
                                      print('nnn checked ');

                                      checkBoxCubit.checkToggle(newValue);
                                      FocusScope.of(context).unfocus();
                                      //setState(() {});
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  );
                                },
                              ),
                              BlocBuilder<ThemebasedwidgetCubit,
                                  ThemebasedwidgetState>(
                                builder: (context, tState) {
                                  print(
                                      'nnn thmeState bool ${tState.isLightTheme}');
                                  return AppButton(
                                    ctx: scaffoldKey,
                                    title: 'Continue',
                                    func: () {
                                      if (_signUpFormkey.currentState!
                                          .validate()) {
                                        _signUpFormkey.currentState!.save();
                                        FocusScope.of(context).unfocus();
                                        if (checked) {
                                          if (_passwordController.text ==
                                              _reEnterPasswordController.text) {
                                            print('nnn password Matches');

                                            SignupDataBase()
                                                .checkUserName(
                                                    _userNameController.text)
                                                .then((value) async {
                                              print(
                                                  'nnn size ${value.size.toString()}');
                                              if (value.size != 0) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return tState.isLightTheme
                                                          ? ShowAlertNewDarkDialogBox(
                                                              alertType:
                                                                  'Warning..!',
                                                              alertMessage:
                                                                  'Username Not Available')
                                                          : ShowAlertNewLightDialogBox(
                                                              alertType:
                                                                  'Warning..!',
                                                              alertMessage:
                                                                  'Username Not Available');
                                                    });
                                              } else {
                                                signupCubit.createAccountWithMail(
                                                    context: context,
                                                    firstName:
                                                        _firstNameController
                                                            .text
                                                            .trim(),
                                                    lastName:
                                                        _lastNameController.text
                                                            .trim(),
                                                    name:
                                                        '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
                                                    userName:
                                                        _userNameController.text
                                                            .trim(),
                                                    email: _emailController.text
                                                        .trim(),
                                                    password:
                                                        _passwordController.text
                                                            .trim(),
                                                    mobileNumber:
                                                        _mobileNumberController
                                                            .text
                                                            .trim(),
                                                    token: token!);
                                                /*      Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    BlocProvider(
                                                                                  create: (context) =>
                                                                                      SignupBloc(),
                                                                                  child: MpinPage(
                                                                                    name:
                                                                                        '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
                                                                                    userName:
                                                                                        _userNameController
                                                                                            .text
                                                                                            .trim(),
                                                                                    email: _emailController
                                                                                        .text
                                                                                        .trim(),
                                                                                    password:
                                                                                        _passwordController
                                                                                            .text
                                                                                            .trim(),
                                                                                    mobileNumber:
                                                                                        _mobileNumberController
                                                                                            .text
                                                                                            .trim(),
                                                                                  ),
                                                                                ),
                                                                              ));*/
                                              }
                                            });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return tState.isLightTheme
                                                      ? ShowAlertNewDarkDialogBox(
                                                          alertType: 'Alert..!',
                                                          alertMessage:
                                                              'Enter PassWord Must Match')
                                                      : ShowAlertNewLightDialogBox(
                                                          alertType: 'Alert..!',
                                                          alertMessage:
                                                              'Enter PassWord Must Match');
                                                });
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //         content: Text(
                                            //             'Enter PassWord Must Match')));
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return tState.isLightTheme
                                                    ? ShowAlertNewDarkDialogBox(
                                                        alertType: 'Alert..!',
                                                        alertMessage:
                                                            'Please Accept To Verify Mobile Number')
                                                    : ShowAlertNewLightDialogBox(
                                                        alertType: 'Alert..!',
                                                        alertMessage:
                                                            'Please Accept To Verify Mobile Number');
                                              });
                                          //ScaffoldMessenger.of(context)
                                          //  .showSnackBar(SnackBar(
                                          //    content: Text(
                                          //      'Please Accept To Verify Mobile Number')));
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: getWidth(context) * 0.007),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: getWidth(context) * 0.08,
                                  width: getWidth(context) * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already Have An Acc?',
                                      ),
                                      Text(
                                        'Login here',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
