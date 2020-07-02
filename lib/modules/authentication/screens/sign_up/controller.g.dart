// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpController, Store {
  final _$isSigningUpAtom = Atom(name: '_SignUpController.isSigningUp');

  @override
  bool get isSigningUp {
    _$isSigningUpAtom.reportRead();
    return super.isSigningUp;
  }

  @override
  set isSigningUp(bool value) {
    _$isSigningUpAtom.reportWrite(value, super.isSigningUp, () {
      super.isSigningUp = value;
    });
  }

  final _$signUpAsyncAction = AsyncAction('_SignUpController.signUp');

  @override
  Future<void> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  @override
  String toString() {
    return '''
isSigningUp: ${isSigningUp}
    ''';
  }
}
