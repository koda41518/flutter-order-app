import 'package:equatable/equatable.dart';
import '../../models/restaut.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final Restaut item;
  AddItem(this.item);
  @override
  List<Object> get props => [item];
}

class RemoveItem extends CartEvent {
  final Restaut item;
  RemoveItem(this.item);
  @override
  List<Object> get props => [item];
}

class ClearCart extends CartEvent {}

class MarkOrderSuccess extends CartEvent {}