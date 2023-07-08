abstract class NewGiftsStates{}

class NewGiftsInitState extends NewGiftsStates{}

class GetAllNewGiftsLoadingState extends NewGiftsStates{}
class GetAllNewGiftsSuccessState extends NewGiftsStates{}
class GetAllNewGiftsErrorState extends NewGiftsStates{}


class GetNewGiftsDetailsLoadingState extends NewGiftsStates{}
class GetNewGiftsDetailsSuccessState extends NewGiftsStates{}
class GetNewGiftsDetailsErrorState extends NewGiftsStates{}

class SendNewCardLoadingState extends NewGiftsStates{}
class SendNewCardSuccessState extends NewGiftsStates{}
class SendNewCardErrorState extends NewGiftsStates{}

class ChangeImageState extends NewGiftsStates{}
class ChangePriceState extends NewGiftsStates{}