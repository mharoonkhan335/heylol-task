// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VideoPageController on _VideoPageController, Store {
  final _$propAtom = Atom(name: '_VideoPageController.prop');

  @override
  List<Map<String, dynamic>> get prop {
    _$propAtom.reportRead();
    return super.prop;
  }

  @override
  set prop(List<Map<String, dynamic>> value) {
    _$propAtom.reportWrite(value, super.prop, () {
      super.prop = value;
    });
  }

  final _$likesAtom = Atom(name: '_VideoPageController.likes');

  @override
  int get likes {
    _$likesAtom.reportRead();
    return super.likes;
  }

  @override
  set likes(int value) {
    _$likesAtom.reportWrite(value, super.likes, () {
      super.likes = value;
    });
  }

  final _$getLikesAsyncAction = AsyncAction('_VideoPageController.getLikes');

  @override
  Future<int> getLikes(dynamic videoID) {
    return _$getLikesAsyncAction.run(() => super.getLikes(videoID));
  }

  final _$getUnlockedVideosAsyncAction =
      AsyncAction('_VideoPageController.getUnlockedVideos');

  @override
  Future<void> getUnlockedVideos(
      dynamic userRef, dynamic userID, dynamic category) {
    return _$getUnlockedVideosAsyncAction
        .run(() => super.getUnlockedVideos(userRef, userID, category));
  }

  @override
  String toString() {
    return '''
prop: ${prop},
likes: ${likes}
    ''';
  }
}
