
abstract class ReviewsCommentsState {}

class ReviewsCommentsInitial extends ReviewsCommentsState {}
class AllReviewsLoadingState extends ReviewsCommentsState {}
class AllReviewsSuccessState extends ReviewsCommentsState {}
class AllReviewsErrorState extends ReviewsCommentsState {}
