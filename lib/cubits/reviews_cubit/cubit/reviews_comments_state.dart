
abstract class ReviewsCommentsState {}

class ReviewsCommentsInitial extends ReviewsCommentsState {}
class AllReviewsLoadingState extends ReviewsCommentsState {}
class AllReviewsSuccessState extends ReviewsCommentsState {}
class AllReviewsErrorState extends ReviewsCommentsState {}

class ChangeRate extends ReviewsCommentsState {}
class ImageSuccess extends ReviewsCommentsState {}

class ProductReviewSuccess extends ReviewsCommentsState {}
class ProductReviewError extends ReviewsCommentsState {}
class ProductReviewLoading extends ReviewsCommentsState {}

