class UserOptimum {
  String _uid;
  String _name;
  String _lastName;
  String _email;
  String _gender;
  String? _urlPhoto;
  String? _phone;

  UserOptimum({
    required String uid,
    required String name,
    required String lastName,
    required String email,
    required String gender,
    String? urlPhoto,
    String? phone,
  })  : _uid = uid,
        _lastName = lastName,
        _name = name,
        _email = email,
        _urlPhoto = urlPhoto,
        _phone = phone,
        _gender = gender;

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

  String getGender() {
    return _gender;
  }

  void setName(String name) {
    _name = name;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  void setEmail(String email) {
    _email = email;
  }


  void setGender(String gender) {
    _gender = gender;
  }

  String? getUrlPhoto() {
    return _urlPhoto;
  }

  void setUrlPhoto(String urlPhoto) {
    _urlPhoto = urlPhoto;
  }

  String? getPhone() {
    return _phone;
  }

  void setPhone(String? phone) {
    if (phone == null)
      _phone = phone;
    else if (phone.isEmpty)
      _phone = null;
    else
      _phone = phone;
  }
}

class Patient extends UserOptimum {
  String? _location;
  String? _weight;
  String? _height;
  String? _dateOfBirth;
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
      required String gender,
      String? urlPhoto,
      String? location,
      String? phone,
      String? weight,
      String? height,
      String? dateOfBirth,
      String? adress,
      String? bloodType,
      bool? alergic,
      List<String>? surgery,
      List<String>? cronicDesease})
      : _location = location,
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
            urlPhoto: urlPhoto,
            gender : gender,
            );

  String? getDateBirth() {
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

  void addSurgery(String s) {
    _surgery!.add(s);
  }

  void addChronicDisease(String s) {
    _cronicDesease!.add(s);
  }

  void setSurgery(List<String>? s) {
    _surgery = s;
  }

  //les seteurs
  void setDateBirth(String? date) {
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

  void setBloodType(String? bloodType) {
    _bloodType = bloodType;
  }

  void setAlergic(bool? alergic) {
    _alergic = alergic;
  }
}

class Medecin extends UserOptimum {
  String? _specialite;
  String? _attendence;
  String? _professionalCreer;
  Medecin({
    required uid,
    required String name,
    required String lastName,
    required String email,
    required String gender,
    String? specialite,
    String? phone,
    String? urlPhoto,
    String? attendece,
    String? professionalCreer,
  })  : _specialite = specialite,
        _attendence = attendece,
        _professionalCreer = professionalCreer,
        super(
            email: email,
            lastName: lastName,
            name: name,
            uid: uid,
            phone: phone,
            urlPhoto: urlPhoto,
            gender: gender);
  //les guetteurs et les seuteurs
  String? getAttendence() {
    return _attendence;
  }

  String? getProfessionalCarrer() {
    return _professionalCreer;
  }

  void setAttendence(String? attendence) {
    _attendence = attendence;
  }

  void setProfessionalCarrer(String? p) {
    _professionalCreer = p;
  }

  String? getSpecialite() {
    return _specialite;
  }

  void setSpecialite(String? sp) {
    _specialite = sp;
  }
}
