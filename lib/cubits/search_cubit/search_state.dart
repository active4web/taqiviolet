abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {}

class SelectItem extends SearchStates {}

class LoadingSearchResults extends SearchStates {}

class SuccessSearchResults extends SearchStates {}

class ErrorSearchResults extends SearchStates {}
