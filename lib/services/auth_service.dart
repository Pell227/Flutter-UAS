import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<UserCredential> register(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> login(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signInWithGoogle() =>
      _auth.signInWithProvider(GoogleAuthProvider());

  Future<UserCredential> signInWithFacebook() =>
      _auth.signInWithProvider(FacebookAuthProvider());

  Future<UserCredential> signInWithX() =>
      _auth.signInWithProvider(TwitterAuthProvider());

  Future<void> logout() => _auth.signOut();
}