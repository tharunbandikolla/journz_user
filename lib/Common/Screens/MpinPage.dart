import 'package:Journz/Authentication/DataModel/SignUpDataModel.dart';
import 'package:Journz/Authentication/DataServices/SignupDatabase.dart';
import 'package:Journz/Common/Helper/CountDownCubit/countdown_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Authentication/AuthenticationBloc/SignUpBloc/signup_bloc.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Screens/MpinWidget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MpinPage extends StatefulWidget {
  String name,
      userName,
      email,
      password,
      mobileNumber,
      token,
      firstName,
      lastName;
  UserCredential userCredential;
  MpinPage(
      {required this.name,
      required this.firstName,
      required this.lastName,
      required this.token,
      required this.userName,
      required this.userCredential,
      required this.email,
      required this.password,
      required this.mobileNumber});
  @override
  _MpinPageState createState() => _MpinPageState();
}

class _MpinPageState extends State<MpinPage> {
  MpinAddDeleteController? mPinAddDeleteController = MpinAddDeleteController();
  String _verificationCode = '';

  @override
  void initState() {
    //FocusScope.of(context).unfocus();
    verifyPhone(
        context.read<SignupBloc>(),
        widget.name,
        widget.userName,
        widget.email,
        widget.password,
        widget.mobileNumber,
        context.read<CountdownCubit>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signupBloc = BlocProvider.of<SignupBloc>(context);
    signupBloc.add(SignupDataCollectionEvent());
    final countdown = BlocProvider.of<CountdownCubit>(context);

    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, cState) {
        if (cState.time == 0) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            cState.isEndedTimer!.cancel();
            //Navigator.pop(context);
            showDialog(
                //  isDismissible: false,
                //enableDrag: false,
                context: context,
                builder: (context) {
                  return WillPopScope(
                    onWillPop: () {
                      return Future.value(true);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('We have created your account with mail ID, Please login with your mail Id and confirm your phone number to complete your profile to post comment.')
                                .text
                                .xl
                                .black
                                .justify
                                .makeCentered()
                                .box
                                .width(context.screenWidth * 0.8)
                                .height(context.screenWidth * 0.5)
                                //.gray100
                                .p16
                                .makeCentered(),
                            ElevatedButton(
                                onPressed: () {
                                  /*   FirebaseFirestore.instance
                                      .collection('UserProfile')
                                      .get()
                                      .then((value) {
                                    value.docs.forEach((element) {
                                      FirebaseFirestore.instance
                                          .collection('UserProfile')
                                          .doc(element.id)
                                          .update({
                                        'IsMobileNumberVerified': 'Verified'
                                      });
                                    });
                                  });*/
                                  print('upto here 8');
                                  print(
                                      'datas ${widget.email}  ${widget.firstName}  ${widget.lastName}  ${widget.mobileNumber}  ${widget.name}  ${widget.password}  ${widget.token}  ${widget.userName}  ');
                                  String uid =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  print('upto here $uid');
                                  print('upto here 7');
                                  SignUpDataModel userProfileData =
                                      SignUpDataModel(
                                          notificationToken: widget.token,
                                          role: 'User',
                                          firstName: widget.firstName,
                                          lastName: widget.lastName,
                                          email: widget.email,
                                          disableTill: null,
                                          isDisable: 'False',
                                          noOfArticlesPostedByAuthor: 0,
                                          authorPermissionRequest: "False",
                                          mobileNumber: widget.mobileNumber,
                                          name: widget.name,
                                          isMobileNumberVerified: 'NotVerified',
                                          userName: widget.userName,
                                          photoUrl: 'images/fluenzologo.png',
                                          userUID: uid);
                                  print('upto here 5');
                                  FirebaseFirestore.instance
                                      .collection(
                                          'GeneralAppUserNotificationToken')
                                      .doc(uid)
                                      .set({'NotificationToken': widget.token});
                                  print('upto here 4');
                                  SignupDataBase().createUserProfile(
                                      uid, userProfileData.toJson());
                                  print('upto here 3');
                                  SignupDataBase().createUserNameColl(
                                      uid,
                                      widget.email,
                                      widget.userName,
                                      widget.mobileNumber);
                                  print('upto here 1');
                                  Navigator.pop(context);
                                  print('upto here 2');
                                  Navigator.pushReplacementNamed(
                                      context, '/VerifyEmail');
                                  /*(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VerifyEmailScreen()),
                                  );*/
                                },
                                child: Text('Proceed'))
                          ],
                        )
                            .box
                            .p16
                            .withDecoration(BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [Colors.grey[200]!, Colors.grey],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)))
                            .width(context.screenWidth * 0.8)
                            .height(context.screenWidth * 0.75)
                            .makeCentered(),
                      ),
                    ),
                  );
                });
          });
        }
        return WillPopScope(
          onWillPop: () {
            /*  if (FirebaseAuth.instance.currentUser != null) {
              print('nnn err dispose');
              FirebaseAuth.instance.currentUser!.reload();
              FirebaseAuth.instance.currentUser!.delete();
            }
            */
            if (!cState.isEnded!) {
              //              ScaffoldMessenger.of(context).showSnackBar(
              //                SnackBar(content: Text('Be Patience And Enter Otp')));
              showDialog(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      body: Center(
                        child: Text('Be Patience And Enter OTP')
                            .text
                            .black
                            .center
                            .bold
                            .xl2
                            .makeCentered()
                            .box
                            .p16
                            .withDecoration(BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [Colors.grey[200]!, Colors.grey],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)))
                            .width(context.screenWidth * 0.8)
                            .height(context.screenWidth * 0.5)
                            .makeCentered(),
                      ),
                    );
                  });
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            }
            return Future.value(cState.isEnded);
          },
          child: Scaffold(
              body: Stack(
            children: [
              SafeArea(
                  child: Column(
                children: [
                  SizedBox(
                    height: getWidth(context) * 0.15,
                  ),
                  VxBox()
                      .square(context.screenWidth * 0.25)
                      .bgImage(DecorationImage(
                          image: AssetImage('images/fluenzologo.png')))
                      .make(),
                  20.heightBox,
                  Text(
                    'verify +91${widget.mobileNumber}',
                    style: TextStyle(
                        fontSize: getWidth(context) * 0.07,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getWidth(context) * 0.03,
                  ),
                  Text('00 : ${cState.time.toString()}')
                      .text
                      .xl
                      .bold
                      .make()
                      .box
                      .p8
                      .make(),
                  15.heightBox,
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                        fontSize: getWidth(context) * 0.045,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getWidth(context) * 0.05,
                  ),
                  MpinWidget(
                    pinLength: 6,
                    addDeleteController: mPinAddDeleteController!,
                    onCompleted: (getMpin) async {
                      print(
                          'you can save entered value to your variable $getMpin');
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: getMpin);

                        print(
                            'nnn cred ${credential}   , ${credential.smsCode}  $getMpin');

                        manualVerification(
                            signupBloc,
                            widget.name,
                            widget.userName,
                            widget.email,
                            widget.password,
                            widget.mobileNumber,
                            credential);
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Enter Correct OTP')));
                      }
                    },
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: 1.6,
                    crossAxisCount: 3,
                    children: List.generate(
                        9, (index) => buildMaterialButton(index + 1)),
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: 1.6,
                      crossAxisCount: 3,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(Icons.fingerprint),
                        ),
                        buildMaterialButton(0),
                        MaterialButton(
                          onPressed: () {
                            mPinAddDeleteController!.delete!();
                          },
                          child: Icon(Icons.backspace),
                        ),
                      ])
                ],
              ))
            ],
          )),
        );
      },
    );
  }

  MaterialButton buildMaterialButton(int input) {
    return MaterialButton(
        onPressed: () {
          mPinAddDeleteController!.addInput!('$input');
        },
        child: Text(
          '$input',
          style: TextStyle(
            fontSize: 24,
          ),
        ));
  }

  verifyPhone(SignupBloc signupBloc, String name, String userName, String email,
      String password, String mobileNumber, CountdownCubit countdown) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.mobileNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('nnn credential $credential');

          signupBloc.add(SignupDataUploadEvent(
              firstName: widget.firstName,
              lastName: widget.lastName,
              token: widget.token,
              userCredential: widget.userCredential,
              context: context,
              name: name,
              userName: userName,
              email: email,
              password: password,
              mobileNumber: mobileNumber,
              credential: credential));
        },
        verificationFailed: (FirebaseException e) {
          print('getting otp Error ${e.message}');
        },
        codeSent: (String? verificationId, int? resendToken) {
          _verificationCode = verificationId!;
          setState(() {});
          print('getting otp Code Sent');
          countdown.stateTimer(30, 1, false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationCode = verificationId;
          setState(() {});
          print('getting otp Auto Retrival');
          countdown.stateTimer(28, 1, true);
        },
        timeout: Duration(seconds: 30));
  }

  manualVerification(
      SignupBloc signupBloc,
      String name,
      String userName,
      String email,
      String password,
      String mobileNumber,
      PhoneAuthCredential credential) {
    signupBloc.add(SignupDataUploadEvent(
        context: context,
        token: widget.token,
        userCredential: widget.userCredential,
        name: name,
        firstName: widget.firstName,
        lastName: widget.lastName,
        userName: userName,
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        credential: credential));
  }
}
