

import 'package:get_it/get_it.dart';
import 'package:sembast_nosql/data/fruit_dao.dart';

GetIt locator = GetIt.instance;

void locatorSetUp(){
  locator.registerSingleton(FruitDao());
}