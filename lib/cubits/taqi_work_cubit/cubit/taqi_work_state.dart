abstract class TaqiWorkState {}

class TaqiWorkCubitInitial extends TaqiWorkState {}

class TaqiWorkCubitLoadingState extends TaqiWorkState {}

class TaqiWorkCubitSuccessState extends TaqiWorkState {}

class TaqiWorkCubitErrorState extends TaqiWorkState {}

class FilePickedSuccessfullyState extends TaqiWorkState {}

class FileRemovedSuccessfullyState extends TaqiWorkState {}

class SendingLoadingState extends TaqiWorkState {}

class SendingSuccessState extends TaqiWorkState {
  final bool status;

  SendingSuccessState(this.status);
}

class SendingErrorState extends TaqiWorkState {}
