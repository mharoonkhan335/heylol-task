// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SetInterest on _SetInterest, Store {
  final _$isSettingAtom = Atom(name: '_SetInterest.isSetting');

  @override
  bool get isSetting {
    _$isSettingAtom.reportRead();
    return super.isSetting;
  }

  @override
  set isSetting(bool value) {
    _$isSettingAtom.reportWrite(value, super.isSetting, () {
      super.isSetting = value;
    });
  }

  final _$setInterestsAsyncAction = AsyncAction('_SetInterest.setInterests');

  @override
  Future<void> setInterests() {
    return _$setInterestsAsyncAction.run(() => super.setInterests());
  }

  @override
  String toString() {
    return '''
isSetting: ${isSetting}
    ''';
  }
}
