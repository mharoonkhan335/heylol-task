// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthController, Store {
  final _$userAtom = Atom(name: '_AuthController.user');

  @override
  FirebaseUser get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(FirebaseUser value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$isSetAtom = Atom(name: '_AuthController.isSet');

  @override
  bool get isSet {
    _$isSetAtom.reportRead();
    return super.isSet;
  }

  @override
  set isSet(bool value) {
    _$isSetAtom.reportWrite(value, super.isSet, () {
      super.isSet = value;
    });
  }

  final _$userIDAtom = Atom(name: '_AuthController.userID');

  @override
  String get userID {
    _$userIDAtom.reportRead();
    return super.userID;
  }

  @override
  set userID(String value) {
    _$userIDAtom.reportWrite(value, super.userID, () {
      super.userID = value;
    });
  }

  final _$setUserIDAsyncAction = AsyncAction('_AuthController.setUserID');

  @override
  Future<dynamic> setUserID() {
    return _$setUserIDAsyncAction.run(() => super.setUserID());
  }

  final _$getCurrentUserAsyncAction =
      AsyncAction('_AuthController.getCurrentUser');

  @override
  Future<dynamic> getCurrentUser() {
    return _$getCurrentUserAsyncAction.run(() => super.getCurrentUser());
  }

  final _$checkIsSetAsyncAction = AsyncAction('_AuthController.checkIsSet');

  @override
  Future<dynamic> checkIsSet() {
    return _$checkIsSetAsyncAction.run(() => super.checkIsSet());
  }

  final _$setUserAsyncAction = AsyncAction('_AuthController.setUser');

  @override
  Future<dynamic> setUser(FirebaseUser fUser) {
    return _$setUserAsyncAction.run(() => super.setUser(fUser));
  }

  final _$logOutAsyncAction = AsyncAction('_AuthController.logOut');

  @override
  Future<dynamic> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  @override
  String toString() {
    return '''
user: ${user},
isSet: ${isSet},
userID: ${userID}
    ''';
  }
}
