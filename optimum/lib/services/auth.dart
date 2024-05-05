import 'package:optimum/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimum/services/database.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseAuth getAuth() {
    return _auth;
  }
  

//sign in anon

  static Future signInAnoun() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      print("sign un anon succes");
      print(user.uid);

      return user;
    } catch (e) {
      print("error  " + e.toString());
      return null;
    }
  }

//sign in with email & pass

  static Future signInWithEmailAndPasswd(String email, String passwd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: passwd);
      User user = result.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email & pass

  static Future registerWithEmailAndPasswd(String email, String passwd ) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: passwd);
    User user = result.user!;

    // Créer un nouveau document pour l'utilisateur avec l'ID
    
  
    return user;
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
  
  //reset passwd

  void resetPassword(String email) {
 _auth.sendPasswordResetEmail(email: email)
    .then((_) {
      // L'e-mail de réinitialisation du mot de passe a été envoyé avec succès
      // Vous pouvez afficher un message à l'utilisateur ou le rediriger vers une page de confirmation
    })
    .catchError((error) {
      // Une erreur s'est produite lors de l'envoi de l'e-mail de réinitialisation du mot de passe
      // Vous pouvez afficher un message d'erreur à l'utilisateur ou effectuer d'autres actions en fonction de l'erreur
    });
}

}