part of 'dialog_bloc.dart';

@immutable
abstract class DialogEvent extends Equatable{}

class BackEvent extends DialogEvent {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SaveEvent extends DialogEvent {
  final String name;
  final bool isSweet;

  SaveEvent({this.name, this.isSweet});

  @override
  // TODO: implement props
  List<Object> get props => [name, isSweet];
}

class UpdateEvent extends DialogEvent {
  final Fruit oldItems;
  final Fruit newItems;

  UpdateEvent({this.oldItems, this.newItems});

  @override
  List<Object> get props => [oldItems, newItems];
}