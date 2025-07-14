import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../models/cart_item.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(items: [], orderSuccess: false)) {
    on<AddItem>((event, emit) {
      final updated = List<CartItem>.from(state.items);
      final index = updated.indexWhere((e) => e.resto.name == event.item.name);
      if (index != -1) {
        updated[index] = updated[index].copyWith(
          quantity: updated[index].quantity + 1,
        );
      } else {
        updated.add(CartItem(resto: event.item, quantity: 1));
      }
      emit(state.copyWith(items: updated, orderSuccess: false));
    });

    on<RemoveItem>((event, emit) {
      final updated = List<CartItem>.from(state.items);
      final index = updated.indexWhere((e) => e.resto.name == event.item.name);
      if (index != -1) {
        if (updated[index].quantity > 1) {
          updated[index] = updated[index].copyWith(
            quantity: updated[index].quantity - 1,
          );
        } else {
          updated.removeAt(index);
        }
      }
      emit(state.copyWith(items: updated, orderSuccess: false));
    });

    on<ClearCart>((_, emit) {
      emit(state.copyWith(items: [], orderSuccess: false));
    });

    on<MarkOrderSuccess>((_, emit) {
      emit(state.copyWith(orderSuccess: true));
    });
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      return CartState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    return state.toJson();
  }
}