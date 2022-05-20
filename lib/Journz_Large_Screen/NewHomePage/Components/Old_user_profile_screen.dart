import 'package:flutter/material.dart';
import '/Journz_Large_Screen/NewHomePage/Components/user_profile_edit_screen.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class OldUserProfileScreen extends StatefulWidget {
  final CheckuserloginedState userState;
  const OldUserProfileScreen({Key? key, required this.userState})
      : super(key: key);

  @override
  State<OldUserProfileScreen> createState() => _OldUserProfileScreenState();
}

class _OldUserProfileScreenState extends State<OldUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.7,
      height: context.screenHeight * 0.75,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset('assets/images/journzLogoFigma.png'),
            Row(
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: UserProfileEditScreen(
                                    userState: widget.userState));
                          });
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit')),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.userState.isLoggined!
                      ? widget.userState.photoUrl != "WithoutImage"
                          ? Container(
                              width: context.screenWidth * 0.1,
                              height: context.screenHeight * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(250),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.userState.photoUrl!))),
                            )
                          : Image.asset("assets/images/logo.png")
                      : Container(),
                  widget.userState.name!.text.xl3.semiBold.make(),
                  widget.userState.role!.text.xl.semiBold.make(),
                  //  widget.userState.email!.text.xl2.semiBold.make(),
                  widget.userState.country!.text.xl2.semiBold.make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.userState.facebook! == "Add Link") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Please Add Your Facebook Profile in Edit Section'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('close'))
                                    ],
                                  );
                                });
                          } else {
                            launch(widget.userState.facebook!);
                          }
                        },
                        child: Container(
                          width: context.screenWidth * 0.045,
                          height: context.screenHeight * 0.085,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(250),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/facebookIcon.png'))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (widget.userState.twitter! == "Add Link") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Please Add Your Twitter Profile in Edit Section'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('close'))
                                    ],
                                  );
                                });
                          } else {
                            launch(widget.userState.twitter!);
                          }
                        },
                        child: Container(
                          width: context.screenWidth * 0.045,
                          height: context.screenHeight * 0.085,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(250),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/twitterIcon.png'))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (!(widget.userState.linkedin! == "Add Link")) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Please Add Your LinkedIn Profile in Edit Section'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('close'))
                                    ],
                                  );
                                });
                          } else {
                            launch(widget.userState.linkedin!);
                          }
                        },
                        child: Container(
                          width: context.screenWidth * 0.045,
                          height: context.screenHeight * 0.085,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(250),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/linkedinIcon.png'))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (!(widget.userState.instagram! == "Add Link")) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Please Add Your Instagram Profile in Edit Section'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('close'))
                                    ],
                                  );
                                });
                          } else {
                            launch(widget.userState.instagram!);
                          }
                        },
                        child: Container(
                          width: context.screenWidth * 0.035,
                          height: context.screenHeight * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(250),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/images/instagram.png'))),
                        ),
                      ),
                    ],
                  )
                      .box
                      .height(context.screenHeight * 0.1)
                      .width(context.screenWidth * 0.25)
                      .make()
                ],
              )
                  .box
                  .width(context.screenWidth * 0.3)
                  .height(context.screenHeight * 0.625)
                  .make(),
              /* Container(
                width: 3,
                height: context.screenHeight * 0.662,
                color: Colors.black,
              ), */
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDataInRow(
                      left: "User Name", right: widget.userState.username!),
                  UserDataInRow(left: "Mobile Number", right: "+91 8524823785"),
                  UserDataInRow(left: "Published Articles", right: "20")
                ],
              )
                  .box
                  .width(context.screenWidth * 0.3)
                  .height(context.screenHeight * 0.625)
                  .make(),
            ],
          )
        ],
      ),
    );
  }
}

class UserDataInRow extends StatelessWidget {
  final String left, right;
  const UserDataInRow({Key? key, required this.left, required this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        left
            .trim()
            .text
            .xl
            .semiBold
            .make()
            .box
            .alignCenterLeft
            .width(context.screenWidth * 0.125)
            .make(),
        "-".text.xl.semiBold.make(),
        SizedBox(width: context.screenWidth * 0.0075),
        right
            .trim()
            .text
            .xl
            .semiBold
            .make()
            .box
            .alignCenterLeft
            .width(context.screenWidth * 0.15)
            .make(),
      ],
    )
        .box
        .height(context.screenHeight * 0.1)
        .width(context.screenWidth * 0.35)
        .make();
  }
}
