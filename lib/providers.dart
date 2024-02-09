// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateProvider<bool> visibleBotonRV =
    StateProvider.autoDispose<bool>((ref) {
  bool _valor = false;
  return _valor;
});

final AutoDisposeStateProvider<bool> mostrarPantallaCarga =
    StateProvider.autoDispose<bool>((ref) {
  bool _valor = false;
  return _valor;
});
