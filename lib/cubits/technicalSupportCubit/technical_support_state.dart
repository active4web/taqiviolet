
abstract class TechnicalSupportState {}

class TechnicalSupportInitial extends TechnicalSupportState {}

class GetTechnicalSupportLoadingState extends TechnicalSupportState{}

class GetTechnicalSupportSuccessState extends TechnicalSupportState{}

class GetTechnicalSupportErrorState extends TechnicalSupportState{}
