import 'package:flutter_new_projects/features/auth_page/repository/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });
  Future<void> signUp(String email, String password, String fullname) async {
    return await authRepository.signUp(email, password, fullname);
  }

  Future<void> signIn(String email, String password) async {
    return await authRepository.signIn(email, password);
  }

  bool checkUser() {
    return authRepository.checkUser();
  }
}
