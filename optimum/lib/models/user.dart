class UserOptimum {
  String _uid;
  String _name;
  String _lastName;
  String _email;

  UserOptimum({
    required String uid,
    required String name,
    required String lastName,
    required String email,
  })  : _uid = uid,
        _lastName = lastName,
        _name = name,
        _email = email;

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
}

class Patient extends UserOptimum {
  String? _phone;
  String? _location;
  int? _weight;
  int? _height;
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
      String? location,
      String? phone,
      int? weight,
      int? height,
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
            email: patientEmail);

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

  int? getHeight() {
    return _height;
  }

  int? getWeight() {
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

  void setHeight(int? height) {
    if (height == 0)
      _height = null;
    else
      _height = height;
  }
  void setWeight(int? weight) {
    if (weight == 0)
      _weight = null;
    else
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
