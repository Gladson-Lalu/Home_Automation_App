import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_automation/domain/repository/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthInitial());
  final AuthRepository _authRepository;

  //sign in
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final User? user = await _authRepository.signIn(
        email,
        password,
      );
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthFailure('Something went wrong'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Something went wrong'));
    }
  }

  //sign up
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(const AuthLoading());
    try {
      final User? user = await _authRepository.signUp(
        name,
        email,
        password,
        confirmPassword,
      );
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthFailure('Something went wrong'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Something went wrong'));
    }
  }

  //sign out
  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(const AuthInitial());
  }

  //get current user
  Future<void> getCurrentUser() async {
    emit(const AuthLoading());
    final User? user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(const AuthFailure('Something went wrong'));
    }
  }

  //is authenticated
  Future<void> isAuthenticated() async {
    emit(const AuthLoading());
    final bool isAuthenticated = await _authRepository.isAuthenticated();
    if (isAuthenticated) {
      getCurrentUser();
    } else {
      emit(const AuthFailure('Something went wrong'));
    }
  }

  //sign in with google
  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());
    try {
      final User? user = await _authRepository.signInWithGoogle();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthFailure('Something went wrong'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Something went wrong'));
    }
  }
}
