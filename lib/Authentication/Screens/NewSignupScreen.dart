import '/Authentication/AuthenticationBloc/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignUpBloc/signup_bloc.dart';
import '/Authentication/AuthenticationBloc/SignUpCubit/signup_cubit.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Authentication/AuthenticationBloc/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';
import '/Authentication/DataServices/SignupDatabase.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/CountDownCubit/countdown_cubit.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Screens/MpinPage.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import '/Common/Widgets/AlertDialogWidget.dart';
import '/Common/Widgets/NewCircularElevattedButton.dart';
import '/Common/Widgets/NewTextFormField.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class NewSignupScreen extends StatefulWidget {
  const NewSignupScreen({Key? key}) : super(key: key);

  @override
  _NewSignupScreenState createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final GlobalKey<FormState> _signUpFormkey = GlobalKey<FormState>();

  bool checked = false;

  String? token;

  @override
  Widget build(BuildContext context) {
    final checkBoxCubit = BlocProvider.of<SignupcheckboxCubit>(context);
    final signupCubit = BlocProvider.of<SignupCubit>(context);
    final loadingscreenCubit = BlocProvider.of<LoadingscreenCubit>(context);
    final passwordCubit =
        BlocProvider.of<ShowhidepasswordinsignupCubit>(context);
    final reEnterPasswordCubit =
        BlocProvider.of<ShowHideReEnterPasswordCubit>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: context.screenWidth,
          height: context.screenHeight * 1.25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.75), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: AssetImage('images/AuthenticationBG.jpg'))),
          child: Form(
              key: _signUpFormkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.screenWidth * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/journzpng2.png')
                          .box
                          .width(context.screenWidth * 0.15)
                          .height(context.screenWidth * 0.15)
                          .makeCentered(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "JOURNZ"
                              .text
                              .white
                              .xl4
                              .bold
                              .letterSpacing(context.screenWidth * 0.04)
                              .make(),
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
                  )
                      .box
                      .width(context.screenWidth * 0.8)
                      .height(context.screenWidth * 0.175)
                      .makeCentered(),
                  SizedBox(height: context.screenWidth * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NewTextFormField(
                          keyBoardType: TextInputType.name,
                          readOnly: false,
                          newHeight: context.screenWidth * 0.15,
                          newWidth: context.screenWidth * 0.45,
                          hintText: 'First Name',
                          controller: _firstNameController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter a Valid Name';
                            }
                          }),
                      NewTextFormField(
                          keyBoardType: TextInputType.name,
                          readOnly: false,
                          newHeight: context.screenWidth * 0.15,
                          newWidth: context.screenWidth * 0.45,
                          hintText: 'Last Name',
                          controller: _lastNameController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter a Valid Name';
                            }
                          })
                    ],
                  )
                      .box
                      .width(context.screenWidth)
                      .height(context.screenHeight * 0.09)
                      .px16
                      .make(),
                  NewTextFormField(
                      keyBoardType: TextInputType.emailAddress,
                      readOnly: false,
                      hintText: 'Email',
                      controller: _emailController,
                      validator: (val) {
                        if (!RegExp(r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                                caseSensitive: false)
                            .hasMatch(val!)) {
                          return 'Enter a Valid Email';
                        }
                      }).box.py8.px16.make(),
                  SizedBox(height: context.screenWidth * 0.02),
                  NewTextFormField(
                      keyBoardType: TextInputType.name,
                      readOnly: false,
                      hintText: 'User Name',
                      controller: _userNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter a Valid Name';
                        }
                      }).box.py16.px16.make(),
                  SizedBox(height: context.screenWidth * 0.02),
                  BlocBuilder<ShowhidepasswordinsignupCubit,
                      ShowhidepasswordinsignupState>(
                    builder: (context, passwordState) {
                      return TextFormField(
                        controller: _reEnterPasswordController,
                        obscureText: passwordState.passWordInSignup,
                        onFieldSubmitted: (String v) {},
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          if (!RegExp(
                                  r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                              .hasMatch(val!)) {
                            return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: Colors.black.withOpacity(0.35),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordState.passWordInSignup) {
                                    passwordCubit
                                        .updateSignUpPasswordBool(false);
                                  } else {
                                    passwordCubit
                                        .updateSignUpPasswordBool(true);
                                  }
                                },
                                icon: passwordState.passWordInSignup
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.screenWidth * 0.5)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.05,
                                vertical: context.screenWidth * 0.04),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    },
                  ).box.py16.px16.make(),
                  SizedBox(height: context.screenWidth * 0.02),
                  BlocBuilder<ShowHideReEnterPasswordCubit,
                      ShowHideReEnterPasswordState>(
                    builder: (context, passwordState) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: passwordState.showHideReEnterPassWord,
                        onFieldSubmitted: (String v) {},
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          if (!RegExp(
                                  r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                              .hasMatch(val!)) {
                            return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: Colors.black.withOpacity(0.35),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordState.showHideReEnterPassWord) {
                                    reEnterPasswordCubit
                                        .updateShowHidePasswordBool(false);
                                  } else {
                                    reEnterPasswordCubit
                                        .updateShowHidePasswordBool(true);
                                  }
                                },
                                icon: passwordState.showHideReEnterPassWord
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    context.screenWidth * 0.5)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.05,
                                vertical: context.screenWidth * 0.04),
                            hintText: 'Re-Password',
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    },
                  ).box.py16.px16.make(),
                  SizedBox(height: context.screenWidth * 0.01),
                  "Password must contain(\'A-Z\' \'a-z\' \'0-9\' \'@#\')"
                      .text
                      .white
                      .lg
                      .makeCentered()
                      .box
                      .py16
                      .px16
                      .make(),
                  SizedBox(height: context.screenWidth * 0.025),
                  NewTextFormField(
                      keyBoardType: TextInputType.multiline,
                      readOnly: true,
                      onTap: () {
                        showCountryPicker(
                            showPhoneCode: true,
                            context: context,
                            onSelect: (Country? country) {
                              _countryController.text = country!.name;
                              _countryCodeController.text =
                                  "+${country.phoneCode}";
                            });
                      },
                      hintText: 'Tap to Select Country',
                      controller: _countryController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Select A Country';
                        }
                      }).box.py16.px16.make(),
                  SizedBox(height: context.screenWidth * 0.02),
                  NewTextFormField(
                      keyBoardType: TextInputType.phone,
                      prefixWidget: Text(_countryCodeController.text),
                      readOnly: false,
                      hintText: 'Mobile Number',
                      controller: _mobileNumberController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter 10 Digit Mobile Number';
                        } else if (val.length != 10) {
                          return 'Enter 10 Digit Mobile Number';
                        }
                      }).box.py8.px16.make(),
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
                        .white
                        .bold
                        .lg
                        .underline
                        .makeCentered()
                        .box
                        .alignCenterLeft
                        .height(context.screenWidth * 0.05)
                        .width(context.screenWidth)
                        .make(),
                  ).box.py16.make(),
                  BlocBuilder<SignupcheckboxCubit, SignupcheckboxState>(
                    builder: (context, state) {
                      checked = state.check;
                      token = state.token;
                      print('Token data $token');
                      return CheckboxListTile(
                        title: "Agree All Terms & Conditions."
                            .text
                            .white
                            .bold
                            .xl
                            .make(),
                        value: state.check,
                        onChanged: (newValue) {
                          print('nnn checked ');

                          checkBoxCubit.checkToggle(newValue);
                          FocusScope.of(context).unfocus();
                          //setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  )
                      .box
                      .alignCenter
                      .width(context.screenWidth)
                      .height(context.screenWidth * 0.1)
                      .makeCentered(),
                  SizedBox(height: context.screenWidth * 0.03),
                  Align(
                    alignment: Alignment.center,
                    child: BlocBuilder<ThemebasedwidgetCubit,
                        ThemebasedwidgetState>(
                      builder: (context, tState) {
                        return NewCircularElevattedButton(
                            name: 'Sign Up',
                            func: () {
                              if (_signUpFormkey.currentState!.validate()) {
                                _signUpFormkey.currentState!.save();
                                FocusScope.of(context).unfocus();
                                if (checked) {
                                  if (_passwordController.text ==
                                      _reEnterPasswordController.text) {
                                    print('nnn password Matches');

                                    SignupDataBase()
                                        .checkUserName(_userNameController.text)
                                        .then((value) async {
                                      print(
                                          'nnn size ${value.size.toString()}');
                                      if (value.size != 0) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return tState.isLightTheme
                                                  ? ShowAlertNewDarkDialogBox(
                                                      alertType: 'Warning..!',
                                                      alertMessage:
                                                          'Username Not Available')
                                                  : ShowAlertNewLightDialogBox(
                                                      alertType: 'Warning..!',
                                                      alertMessage:
                                                          'Username Not Available');
                                            });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        SignupBloc(),
                                                  ),
                                                  BlocProvider(
                                                    create: (context) =>
                                                        CountdownCubit(),
                                                  ),
                                                ],
                                                child: MpinPage(
                                                    country:
                                                        _countryController.text,
                                                    countryCode:
                                                        _countryCodeController
                                                            .text,
                                                    firstName:
                                                        _firstNameController
                                                            .text,
                                                    lastName:
                                                        _lastNameController
                                                            .text,
                                                    token: token!,
                                                    name:
                                                        '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
                                                    userName:
                                                        _userNameController
                                                            .text,
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    mobileNumber:
                                                        _mobileNumberController
                                                            .text),
                                              ),
                                            ));
                                        /*   signupCubit.createAccountWithMail(
                                                context: context,
                                                countryCode:
                                                    _countryCodeController.text,
                                                countryName:
                                                    _countryController.text,
                                                firstName: _firstNameController
                                                    .text
                                                    .trim(),
                                                lastName: _lastNameController.text
                                                    .trim(),
                                                name:
                                                    '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
                                                userName: _userNameController.text
                                                    .trim(),
                                                email:
                                                    _emailController.text.trim(),
                                                password: _passwordController.text
                                                    .trim(),
                                                mobileNumber:
                                                    _mobileNumberController.text
                                                        .trim(),
                                                token: token!); */
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
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: 'Warning..!'.text.make(),
                                          content:
                                              'Please Accept To verify Mobile Number'
                                                  .text
                                                  .make(),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('close'))
                                          ],
                                        );
                                      });
                                }
                              }
                            },
                            fontSize: context.screenWidth * 0.05,
                            padHorizontal: context.screenWidth * 0.01,
                            padVertical: context.screenWidth * 0.025);
                      },
                    ).box.width(context.screenWidth * 0.5).make(),
                  ),
                  SizedBox(height: context.screenWidth * 0.01),
                  InkWell(
                    onTap: () {},
                    child: "Already a Journz Member..! Sign in here."
                        .text
                        .white
                        .lg
                        .makeCentered()
                        .box
                        .py16
                        .px16
                        .make(),
                  ),
                ],
              ))),
    ));
  }
}
