part of 'fruit_bloc.dart';

@immutable
abstract class FruitEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadFruits extends FruitEvent {}

class AddRandomFruit extends FruitEvent {}


class DeleteEvent extends FruitEvent {
   final Fruit fruit;

   DeleteEvent(this.fruit);

   @override
  // TODO: implement props
  List<Object> get props => [fruit];
}
