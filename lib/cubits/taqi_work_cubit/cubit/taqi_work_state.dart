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

class GetJobsSuccessState extends TaqiWorkState{}
class GetJobsErrorState extends TaqiWorkState{}
class GetJobsLoadingState extends TaqiWorkState{}

class ApplyJobSuccessState extends TaqiWorkState{}
class ApplyJobErrorState extends TaqiWorkState{}
class ApplyJobLoadingState extends TaqiWorkState{}