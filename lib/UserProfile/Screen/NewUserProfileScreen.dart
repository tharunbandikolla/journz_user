import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Articles/ArticlesBloc/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '/UserProfile/Screen/UserProfileDataEditScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class NewUserProfileScreen extends StatefulWidget {
  const NewUserProfileScreen({Key? key}) : super(key: key);

  @override
  _NewUserProfileScreenState createState() => _NewUserProfileScreenState();
}

class _NewUserProfileScreenState extends State<NewUserProfileScreen> {
  String? photoUrl, name, mobileNumber, email, userName, role;

  getUserDatafromDb() async {
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      photoUrl = await value.data()!['PhotoUrl'];
      print('nnn photo $photoUrl');
      name = await value.data()!['Name'];
      mobileNumber = await value.data()!['MobileNumber'];
      email = await value.data()!['Email'];
      userName = await value.data()!['UserName'];
      role = await value.data()!['Role'];
    });
  }

  @override
  initState() {
    getUserDatafromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => Future.value(true)),
        /*FirebaseFirestore.instance
            .collection('UserProfile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()*/

        builder: (context, snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  appBar: AppBar(
                    title: Text('Profile Screen'),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              AddphotoarticleCubit(),
                                          child: UserProfileDataEditScreen(
                                            userName: userName!,
                                            email: email!,
                                            mobileNumber: mobileNumber!,
                                            name: name!,
                                            photoUrl: photoUrl!,
                                          ),
                                        )));
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                  body: VStack([
                    Container(
                      width: context.screenWidth * 0.34,
                      height: context.screenWidth * 0.34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: photoUrl == 'images/fluenzologo.png'
                              ? DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('images/fluenzologo.png'))
                              : DecorationImage(
                                  image:
                                      CachedNetworkImageProvider(photoUrl!))),
                    ).box.py24.makeCentered(),
                    Divider(thickness: 3),
                    5.heightBox,
                    '$name ($role)'.text.xl2.bold.makeCentered().box.px4.make(),
                    5.heightBox,
                    mobileNumber!.text.xl.makeCentered(),
                    5.heightBox,
                    email!.text.xl.makeCentered()
                  ])
                      .box
                      .width(context.screenWidth)
                      .height(context.screenHeight)
                      .make())
              : Scaffold(body: Center(child: Text('Loading...')));
        });
  }
}
