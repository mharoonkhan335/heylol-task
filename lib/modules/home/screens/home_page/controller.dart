import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:heylolTask/modules/home/functions/home_repository.dart';
part 'controller.g.dart';

class HomeController extends _HomeController with _$HomeController {}

abstract class _HomeController with Store {
  HomeRepository homeRepo = HomeRepository();

  @observable
  List<dynamic> unlockedCategories = [];
  

  @action
  Future<void> getUnlockedCategories() async {
    unlockedCategories = await homeRepo.getUnlockedCategories();
    print(unlockedCategories);
  }

  String capitalize (cap) {
    return "${cap[0].toUpperCase()}${cap.substring(1)}";
  }
}
