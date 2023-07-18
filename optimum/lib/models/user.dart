
class UserOptimum {
  String _name;
  String _lastName;
  UserOptimum({required String name, required String lastName})
      : this._lastName = lastName,
        this._name = name;
  String getName() {
    return this._name;
  }
  String getLastName() {
    return this._lastName;

  }
}
