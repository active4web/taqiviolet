
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesListLoading extends FavoritesState {}
class FavoritesListSuccess extends FavoritesState {}
class FavoritesListError extends FavoritesState {}

class LoadingFavoritesAllData extends FavoritesState {}
class SuccessFavoritesAllData extends FavoritesState {}
class ErrorFavoritesAllData extends FavoritesState {}
