class UserOptimum {
  String _uid;
  String _name;
  String _lastName;
  String _email;
  String? _urlPhoto ;

  UserOptimum({
    required String uid,
    required String name,
    required String lastName,
    required String email,
    String? urlPhoto,
  })  : _uid = uid,
        _lastName = lastName,
        _name = name,
        _email = email,
        _urlPhoto = urlPhoto;

  String getUid() {
    return this._uid;
  }

  String getName() {
    return this._name;
  }

  String getLastName() {
    return this._lastName;
  }

  String getEmail() {
    return _email;
  }

  String setName() {
    return this._name;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  void setEmail(String email) {
    _email = email;
  }

  String? getUrlPhoto() {
    return _urlPhoto;
  }

  void setUrlPhoto(String urlPhoto) {
    _urlPhoto = urlPhoto;
  }
}

class Patient extends UserOptimum {
  String? _phone;
  String? _location;
  String? _weight;
  String? _height;
  DateTime? _dateOfBirth;
  String? _adress;
  String? _bloodType;
  bool? _alergic;
  List<String>? _surgery;
  List<String>? _cronicDesease;
  Patient(
      {required String uid,
      required String patientName,
      required String patientLastName,
      required String patientEmail,
      String? urlPhoto,
      String? location,
      String? phone,
      String? weight,
      String? height,
      DateTime? dateOfBirth,
      String? adress,
      String? bloodType,
      bool? alergic,
      List<String>? surgery,
      List<String>? cronicDesease})
      : _phone = phone,
        _location = location,
        _weight = weight,
        _height = height,
        _dateOfBirth = dateOfBirth,
        _adress = adress,
        _bloodType = bloodType,
        _alergic = alergic,
        _surgery = surgery,
        _cronicDesease = cronicDesease,
        super(
            uid: uid,
            name: patientName,
            lastName: patientLastName,
            email: patientEmail,
            urlPhoto: urlPhoto);

  String? getPhone() {
    return _phone;
  }

  DateTime? getDateBirth() {
    return _dateOfBirth;
  }

  String? getLocation() {
    return _location;
  }

  String? getBloodType() {
    return _bloodType;
  }

  bool? getAlergic() {
    return _alergic;
  }

  String? getAdress() {
    return _adress;
  }

  String? getHeight() {
    return _height;
  }

  String? getWeight() {
    return _weight;
  }

  List<String>? getSurgery() {
    return _surgery;
  }

  List<String>? getCronicDesease() {
    return _cronicDesease;
  }

  //les seteurs
  void setPhone(String? phone) {
    if (phone == null)
      _phone = phone;
    else if (phone.isEmpty)
      _phone = null;
    else
      _phone = phone;
  }

  void setDateBirth(DateTime? date) {
    if (date == null)
      _dateOfBirth = null;
    else
      _dateOfBirth = date;
  }

  void setAdress(String? adress) {
    if (adress == null)
      _adress = adress;
    else if (adress.isEmpty)
      _adress = null;
    else
      _adress = adress;
  }

  void setHeight(String? height) {
      _height = height;
  }

  void setWeight(String? weight) {
      _weight = weight;
  }
}

// class Utilisateur {
//   String _name;
//   String _lastName;
//   String _email;
//   String _phone;
//   int _weight;
//   int _height;
// }
