import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpDataModel {
  String? role,
      name,
      firstName,
      lastName,
      countryName,
      countryCode,
      notificationToken,
      email,
      userName,
      isMobileNumberVerified,
      mobileNumber,
      userUID,
      photoUrl,
      isDisable,
      authorPermissionRequest;
  FieldValue? disableTill;
  int? noOfArticlesPostedByAuthor;
  List<dynamic>? userFavouriteArticle = [];
  List<dynamic>? userCountryPreferences = [];
  SignUpDataModel(
      {this.role,
      this.disableTill,
      this.countryCode,
      this.countryName,
      this.isMobileNumberVerified,
      this.noOfArticlesPostedByAuthor,
      this.userFavouriteArticle,
      this.isDisable,
      this.name,
      this.notificationToken,
      this.authorPermissionRequest,
      this.userName,
      this.email,
      this.mobileNumber,
      this.userUID,
      this.firstName,
      this.lastName,
      this.userCountryPreferences,
      this.photoUrl});

  SignUpDataModel.fromJson(Map<String, dynamic> json) {
    role = json['Role'];
    name = json['Name'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    email = json['Email'];
    mobileNumber = json['MobileNumber'];
    photoUrl = json['PhotoUrl'];
    authorPermissionRequest = json['RequestAuthor'];
    isMobileNumberVerified = json['IsMobileNumberVerified'];
    countryName = json['Country'];
    countryCode = json['PhoneCode'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['Name'] = name;
    json['UserName'] = userName;
    json['Email'] = email;
    json['MobileNumber'] = mobileNumber;
    json['Role'] = role;
    json['UserUid'] = userUID;
    json['RequestAuthor'] = authorPermissionRequest;
    json['NoOfArticlesPosted'] = noOfArticlesPostedByAuthor;
    json['DisableTill'] = disableTill;
    json['IsDisable'] = isDisable;
    json['PhotoUrl'] = photoUrl;
    json['NotificationToken'] = notificationToken;
    json['FirstName'] = firstName;
    json['LastName'] = lastName;
    json['IsMobileNumberVerified'] = isMobileNumberVerified;
    json['UsersFavouriteArticleCategory'] = userFavouriteArticle;
    json['Country'] = countryName;
    json['PhoneCode'] = countryCode;
    json['UserCountryPreferences'] = userCountryPreferences;
    return json;
  }
}
