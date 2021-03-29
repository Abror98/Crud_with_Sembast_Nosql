import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sembast_nosql/data/fruit.dart';
import 'package:sembast_nosql/data/fruit_dao.dart';
import 'package:sembast_nosql/di/locator.dart';


part 'fruit_event.dart';
part 'fruit_state.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  FruitDao _fruitDao = locator.get<FruitDao>();

  FruitBloc() : super(FruitLoadingState());


  @override
  Stream<FruitState> mapEventToState(
      FruitEvent event,
      ) async* {
    if (event is LoadFruits) {
      yield FruitLoadingState();
      yield* _reloadFruits();
    } else if (event is DeleteEvent) {
      await _fruitDao.delete(event.fruit);
      yield* _reloadFruits();
    }
  }

  Stream<FruitState> _reloadFruits() async* {
    final fruits = await _fruitDao.getAllSortedByName();
    yield FruitLoadedState(fruits);
  }
}

