part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {}

class ContactsInitial extends ContactsState {}
class ContactsLoadingState  extends ContactsState {}
class ContactsStateSuccessState extends ContactsState {}
class ContactsStateErrorState extends ContactsState {}
