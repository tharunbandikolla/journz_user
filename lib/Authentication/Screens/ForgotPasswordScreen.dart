import 'package:firebase_auth/firebase_auth.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController controller = TextEditingController();
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(getWidth(context) * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: getWidth(context) * 0.1),
              Container(child: Image.asset('images/ForgotPassword.png')),
              SizedBox(height: getWidth(context) * 0.08),
              Text('Enter Your Email To Send Reset Password Link',
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: getWidth(context) * 0.08),
              TextField(
                controller: controller,
                onChanged: (val) {
                  email = val;
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: getWidth(context) * 0.05),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(getWidth(context) * 0.1))),
              ),
              SizedBox(height: getWidth(context) * 0.08),
              ElevatedButton(
                  onPressed: () {
                    if (email.trim().isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Enter Email')));
                    } else if (!RegExp(
                            r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
                            caseSensitive: false)
                        .hasMatch(email.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Valid Email')));
                    } else {
                      controller.clear();
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.trim())
                          .whenComplete(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Processing Please Check Your Mail After SomeTime')));
                        Navigator.pop(context);
                      }).onError((e, stackTrace) => {
                                print('nnnnnnn $e'),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.toString().replaceFirst(
                                      RegExp(r'\[(.*?)\]',
                                          caseSensitive: false),
                                      '')),
                                ))
                              });
                    }
                  },
                  child: Text('Send'))
            ],
          ),
        ),
      ),
    );
  }
}
