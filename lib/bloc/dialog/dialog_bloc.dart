import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sembast_nosql/data/fruit.dart';
import 'package:sembast_nosql/data/fruit_dao.dart';
import 'package:sembast_nosql/di/locator.dart';


part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  BuildContext context;

  DialogBloc({this.context}) : super(DialogInitial());

  FruitDao _fruitDao = locator.get<FruitDao>();

  @override
  Stream<DialogState> mapEventToState(DialogEvent event,) async* {
    if (event is BackEvent)
      Navigator.pop(context);
    if (event is SaveEvent) {
      await _fruitDao.insert(Fruit(name: event.name, isSweet: event.isSweet));
      Navigator.pop(context);
    }
    if(event is UpdateEvent) {
      await _fruitDao.update(event.newItems, event.oldItems);
      Navigator.pop(context);
    }
  }

}
