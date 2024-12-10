import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_with_firebase/modals/user.dart';
import 'package:flutter_with_firebase/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  UserModal? _userFromFirebaseUser(User? user) {
    return user != null ? UserModal(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserModal?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // .map((User? user) => _userFromFirebaseUser(user));  is equals to line above
  }
  
  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      // this User object is the signed-in user 'FirebaseUser'
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}

extension on FirebaseAuth {
  Stream<User?>? get onAuthStateChanged => null;
}