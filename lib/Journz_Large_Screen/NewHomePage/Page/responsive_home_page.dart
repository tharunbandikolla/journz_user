import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journz_web/Journz_Large_Screen/NewHomePage/Page/new_home_page.dart';

import 'package:journz_web/test.dart';
import '../../../Journz_Mini_Desktop/HomePage/mini_desktop_home.dart';
import '/Journz_Mobile/HomePage/mobile_home.dart';
import 'package:journz_web/Journz_Tab/tab_home.dart';
import 'package:velocity_x/velocity_x.dart';

class ResponsiveHomePage extends StatefulWidget {
  final String showFavCategoryname;
  const ResponsiveHomePage({Key? key, required this.showFavCategoryname})
      : super(key: key);

  @override
  State<ResponsiveHomePage> createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends State<ResponsiveHomePage> {
  @override
  void didChangeDependencies() {
    updateWebNotificationToken();
    super.didChangeDependencies();
  }

  updateWebNotificationToken() {
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                "BOuQ9ODWQnHDc4ObmZHYEZ9dIjKcszc2EpRVv6e8sAGs4t05tfBpilhPatLnwmqHMa4Pn5UnjIy978P_fHu3kvM")
        .then((token) async {
      print("device type $kIsWeb");
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      //WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      String? deviceIdentifier;

      if (kIsWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        deviceIdentifier =
            "${webInfo.vendor!}${webInfo.userAgent!}${webInfo.hardwareConcurrency}";

        print(
            "device identifier ${deviceIdentifier.replaceAll("/", "").replaceAll(" ", "")}");

        FirebaseFirestore.instance
            .collection("PublicNotification")
            .where("NotificationToken",
                isEqualTo:
                    deviceIdentifier.replaceAll("/", "").replaceAll(" ", ""))
            .get()
            .then((value) {
          if (value.size == 0) {
            FirebaseFirestore.instance
                .collection("PublicNotification")
                .doc(deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
                .set({"NotificationToken": token});
          }
        });
      } else {
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceIdentifier = androidInfo.androidId;

          FirebaseFirestore.instance
              .collection("PublicNotification")
              .where("NotificationToken",
                  isEqualTo:
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
              .get()
              .then((value) {
            if (value.size == 0) {
              FirebaseFirestore.instance
                  .collection("PublicNotification")
                  .doc(
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
                  .set({"NotificationToken": token});
            }
          });
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceIdentifier = iosInfo.identifierForVendor;

          FirebaseFirestore.instance
              .collection("PublicNotification")
              .where("NotificationToken",
                  isEqualTo:
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
              .get()
              .then((value) {
            if (value.size == 0) {
              FirebaseFirestore.instance
                  .collection("PublicNotification")
                  .doc(
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
                  .set({"NotificationToken": token});
            }
          });
        } else if (Platform.isLinux) {
          LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
          deviceIdentifier = linuxInfo.machineId;

          FirebaseFirestore.instance
              .collection("PublicNotification")
              .where("NotificationToken",
                  isEqualTo:
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
              .get()
              .then((value) {
            if (value.size == 0) {
              FirebaseFirestore.instance
                  .collection("PublicNotification")
                  .doc(
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
                  .set({"NotificationToken": token});
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            //           getDataFromDB() {
            // context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
            //context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
//  }

            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return Home(
                  wantSearchBar: true,
                  showFavCategory: widget.showFavCategoryname);
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MiniDeskHome(wantSearchBar: true);
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return TabHome(wantSearchBar: true);
            } else {
              print("Mobile");
              return MobileHome(wantSearchBar: true);
            }
          },
        ),
      ),
    );
  }
}
