import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'checkuserlogined_state.dart';

class CheckuserloginedCubit extends Cubit<CheckuserloginedState> {
  CheckuserloginedCubit()
      : super(CheckuserloginedState(
            isLoggined: false,
            favCategories: [],
            userUid: "",
            anniversaryDate: "",
            bio: "",
            country: "",
            countryCode: "",
            dateOfBirth: "",
            email: "",
            facebook: "",
            firstName: "",
            gender: "",
            instagram: "",
            lastName: "",
            linkedin: "",
            maritalStatus: "",
            mobileNumber: "",
            noOfPublishedArticles: 0,
            occupation: "",
            photoUrl: "",
            role: "",
            stateName: "",
            twitter: "",
            user: FirebaseAuth.instance.currentUser,
            username: ""));

  checkLogin() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user == null) {
      emit(state.copyWith(
          checkLogin: false,
          favCat: [],
          uUid: "",
          annivDate: "",
          birtDate: "",
          ctry: "",
          em: "",
          fName: "",
          fb: "",
          insta: "",
          job: "",
          lName: "",
          linkedinAcc: "",
          marital: "",
          mobileCode: "",
          noOfArticles: 0,
          pUrl: "",
          personalInfo: "",
          phoneNummber: "",
          rle: "",
          state: "",
          twitterAcc: "",
          userGender: "",
          usernme: "",
          usr: FirebaseAuth.instance.currentUser));
    } else {
      FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(user.uid)
          .snapshots()
          .listen((value) async {
        emit(state.copyWith(
            usr: user,
            checkLogin: true,
            mobileCode: value.data()!['PhoneCode'],
            phoneNummber: value.data()!['MobileNumber'],
            usernme: value.data()!['UserName'],
            fb: await value.data()!['FacebookLink'],
            insta: await value.data()!['InstagramLink'],
            linkedinAcc: await value.data()!['LinkedinLink'],
            twitterAcc: await value.data()!['TwitterLink'],
            ctry: await value.data()!['Country'],
            rle: await value.data()!['Role'],
            em: await value.data()!['Email'],
            nme: await value.data()!['Name'],
            pUrl: await value.data()!['PhotoUrl'],
            favCat: await value.data()!['UsersFavouriteArticleCategory'],
            uUid: await value.data()!['UserUid'],
            annivDate: await value.data()!['AnniversaryDate'],
            birtDate: await value.data()!['DateOfBirth'],
            job: await value.data()!['Occupation'],
            marital: await value.data()!['MaritalStatus'],
            personalInfo: await value.data()!['Bio'],
            state: await value.data()!['StateName'],
            userGender: await value.data()!['Gender'],
            noOfArticles: await value.data()!['NoOfArticlesPosted'],
            fName: await value.data()!['FirstName'],
            lName: await value.data()!['LastName']));
      });
    }
  }
}
