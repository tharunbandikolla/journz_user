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
    json['Name'] = this.name;
    json['UserName'] = this.userName;
    json['Email'] = this.email;
    json['MobileNumber'] = this.mobileNumber;
    json['Role'] = this.role;
    json['UserUid'] = this.userUID;
    json['RequestAuthor'] = this.authorPermissionRequest;
    json['NoOfArticlesPosted'] = this.noOfArticlesPostedByAuthor;
    json['DisableTill'] = this.disableTill;
    json['IsDisable'] = this.isDisable;
    json['PhotoUrl'] = this.photoUrl;
    json['NotificationToken'] = this.notificationToken;
    json['FirstName'] = this.firstName;
    json['LastName'] = this.lastName;
    json['IsMobileNumberVerified'] = this.isMobileNumberVerified;
    json['UsersFavouriteArticleCategory'] = this.userFavouriteArticle;
    json['Country'] = this.countryName;
    json['PhoneCode'] = this.countryCode;

    return json;
  }
}
