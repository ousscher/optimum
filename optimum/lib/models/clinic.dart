import 'dart:math';

class Clinic {
  String _email;
  String _phone;
  String _adress;
  String _facebookAccount;
  String _instaAccount;
  String _locationLink;
  Clinic(
      {required String email,
      required String phone,
      required String adress,
      required String facebookAccount,
      required String instaAccount,
      required String locationLink})
      : _email = email,
        _adress = adress,
        _facebookAccount = facebookAccount,
        _instaAccount = instaAccount,
        _locationLink = locationLink,
        _phone = phone;
  //les setteurs et les guetteurs
  void setEmail(String email) {
    _email = email;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  void setAdress(String adress) {
    _adress = adress;
  }

  void setFacebookAccount(String facebookAccount) {
    _facebookAccount = facebookAccount;
  }

  void setInstaAccount(String instaAccount) {
    _instaAccount = instaAccount;
  }

  void setLocationLink(String location) {
    _locationLink = location;
  }

  String getEmail() {
    return _email;
  }

  String getPhone() {
    return _phone;
  }

  String getAdress() {
    return _adress;
  }

  String getFacebookAccount() {
    return _facebookAccount;
  }

  String getInstaAccount() {
    return _instaAccount;
  }

  String getLocationLink() {
    return _locationLink;
  }
}
