part of 'inventory_cubit.dart';

@immutable
abstract class InventoryState {}

class InventoryInitial extends InventoryState {}
class GetListInventorySuccess extends InventoryState {}
class GetListInventoryLoading extends InventoryState {}
class GetListInventoryError extends InventoryState {}
