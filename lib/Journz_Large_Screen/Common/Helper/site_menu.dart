import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class SiteMenu extends StatelessWidget {
  const SiteMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.white, width: context.screenHeight * 0.003),
            borderRadius: BorderRadius.circular(context.screenHeight * 0.025)),
        elevation: 4,
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.0125,
              vertical: context.screenWidth * 0.0125),
          duration: Duration(milliseconds: 300),
          constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.15,
              minHeight: context.screenHeight * 0.15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.screenHeight * 0.025),
            border: Border.all(color: Colors.white),
            color: Colors.grey.shade300,
          ),
          child: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
            builder: (context, loginState) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loginState.isLoggined!
                        ? loginState.user!.isAnonymous
                            ? Container()
                            : loginState.isLoggined!
                                ? loginState.role == "Author" ||
                                        loginState.role == 'ContentWriter'
                                    ? InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          'Add Articles',
                                        ).text.xl.semiBold.make(),
                                      ).box.alignCenterLeft.make()
                                    : Container()
                                : Container()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? InkWell(
                            onTap: () {},
                            child: const Text('Add Favourites')
                                .text
                                .xl
                                .semiBold
                                .make(),
                          ).box.alignCenterLeft.make()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? InkWell(
                            onTap: () {},
                            child: const Text(
                              'Bookmarked Articles',
                            ).text.xl.semiBold.make(),
                          ).box.alignCenterLeft.make()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? loginState.role == "Author" ||
                                loginState.role == 'ContentWriter'
                            ? InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Articles Published',
                                ).text.xl.semiBold.make(),
                              ).box.alignCenterLeft.make()
                            : Container()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? loginState.role == "Author" ||
                                loginState.role == 'ContentWriter'
                            ? InkWell(
                                onTap: () {},
                                child: const Text('Articles Under Review')
                                    .text
                                    .xl
                                    .semiBold
                                    .make(),
                              ).box.alignCenterLeft.make()
                            : Container()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? loginState.role == "Author" ||
                                loginState.role == 'ContentWriter'
                            ? InkWell(
                                onTap: () {},
                                child: const Text('Articles Rejected')
                                    .text
                                    .xl
                                    .semiBold
                                    .make(),
                              ).box.alignCenterLeft.make()
                            : Container()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? loginState.user!.isAnonymous
                            ? Container()
                            : InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Profile',
                                ).text.xl.semiBold.make(),
                              ).box.alignCenterLeft.make()
                        : Container(),
                    SizedBox(height: context.screenHeight * 0.001),
                    loginState.isLoggined!
                        ? !loginState.user!.isAnonymous
                            ? InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Settings',
                                ).text.xl.semiBold.make(),
                              ).box.alignCenterLeft.make()
                            : Container()
                        : Container(),
                  ]);
            },
          ),
        ));
  }
}
