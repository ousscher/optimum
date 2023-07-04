import 'package:optimum/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseAuth getAuth() {
    return _auth;
  }
  //auth change user stram

  static Stream<Utilisateur?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

//sign in anon

  static Future signInAnoun() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      print("sign un anon succes");
      print(user.uid);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print("error  " + e.toString());
      return null;
    }
  }

  // create a user obj based on Firebase user
  static Utilisateur? _userFromFirebaseUser(User? user) {
    return user != null ? Utilisateur(uid: user.uid) : null;
  }

//sign in with email & pass

static Future signInWithEmailAndPasswd(String email, String passwd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: passwd);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email & pass

  static Future registerWithEmailAndPasswd(String email, String passwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print((e.toString()));
      return null;
    }
  }
}
