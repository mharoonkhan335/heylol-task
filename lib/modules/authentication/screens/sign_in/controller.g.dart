// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInController, Store {
  final _$isSigningAtom = Atom(name: '_SignInController.isSigning');

  @override
  bool get isSigning {
    _$isSigningAtom.reportRead();
    return super.isSigning;
  }

  @override
  set isSigning(bool value) {
    _$isSigningAtom.reportWrite(value, super.isSigning, () {
      super.isSigning = value;
    });
  }

  final _$signInAsyncAction = AsyncAction('_SignInController.signIn');

  @override
  Future<void> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  @override
  String toString() {
    return '''
isSigning: ${isSigning}
    ''';
  }
}
