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
  String getName() {
    return this._name;
  }

  String getLastName() {
    return this._lastName;
  }

  String getEmail() {
    return _email;
  }
}

class Patient extends UserOptimum {
  String? _phone;
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
}

// class Utilisateur {
//   String _name;
//   String _lastName;
//   String _email;
//   String _phone;
//   int _weight;
//   int _height;
// }
