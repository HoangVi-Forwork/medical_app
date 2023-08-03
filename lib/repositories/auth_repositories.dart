import 'package:firebase_auth/firebase_auth.dart';

import '../config/url_config.dart';

class AuthRepositories {
  final firebaseAuth = FirebaseAuth.instance;

  // Sign Up Func
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // var url = '${Configs.IP4Local}api/danhsachbenh';

  // Future<List<DiseasesModel>> fetchDiseasesList() async {
  //   http.Response response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 201) {
  //     final result = jsonDecode(response.body) as List;
  //     return result.map((i) => DiseasesModel.fromJson(i)).toList();
  //   } else {
  //     throw 'Error In DiseaseRepository';
  //   }
  // }

  var url = '${Configs.IP4Local}api/danhsachbenh';
  Future<void> signIn({
    required String email,
    required String password,
  }) async {}

  // // Sign In Func
  // Future<void> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       throw Exception('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       throw Exception('Wrong password provided for that user.');
  //     }
  //   }
  // }

  // Sign Out Func
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
