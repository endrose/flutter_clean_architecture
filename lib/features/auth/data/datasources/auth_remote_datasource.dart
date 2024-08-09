import 'package:flutter_clean_architecture/core/error/exception.dart';
import 'package:flutter_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  //

  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImp implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImp(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        name: name,
      });

      if (response.user == null) {
        throw ServerException('User id null');
      }
      print({response: response});
      return UserModel.fromJson({
        'id': response.user!.id,
        'email': response.user!.email,
        'name': response.user!.userMetadata!['name'],
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
