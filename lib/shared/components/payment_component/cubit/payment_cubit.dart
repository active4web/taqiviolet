
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/components/payment_component/cubit/payment_state.dart';
import 'package:safsofa/shared/constants.dart';

import '../../../../main.dart';
import '../../../../models/payment_model/payment_model.dart';
import '../../../../network/local/cache_helper.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context)=>BlocProvider.of(context);


  PaymentModel? paymentModel;

  PaymentSdkConfigurationDetails generateConfig(BillingDetails billingDetailsData,ShippingDetails shippingDetailsData) {
    var billingDetails = billingDetailsData;
    var shippingDetails = shippingDetailsData;
    List<PaymentSdkAPms> apms = [
      PaymentSdkAPms.FAWRY,
      PaymentSdkAPms.APPLE_PAY,
    ];
    apms.add(PaymentSdkAPms.AMAN);
    final configuration = PaymentSdkConfigurationDetails(
        profileId: "105601",
        serverKey: "SWJN6WHN6M-JHGZHWGRB9-W2BDN6LZWT",
        clientKey: "CTKMVK-VB9B6H-T9HVTR-9MTQHB",
        cartId: billingDetails.orderId,
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        screentTitle: "Pay with Card",
        amount:billingDetails.total.toDouble(),
        showBillingInfo: true,
        forceShippingInfo: false,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);
    final theme = IOSThemeConfigurations();
    //  theme.logoImage = "assets/logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;

    return configuration;
  }

  Future<void> payPressed({
    required BillingDetails billingDetailsData,
    required ShippingDetails shippingDetailsData
}) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(billingDetailsData,shippingDetailsData), (event) {

      // emit(PaymentErrorState());
      //   print("Dataaaaaaaaaaaa: ${event}");
        if (event["status"] == "success") {
          // Handle transaction details here.

          var transactionDetails = event["data"];
          print("Tarnsaction Detailsssss: ${transactionDetails}");
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            CacheHelper.setData(key: "isPaid",value:true);
            isPaid= CacheHelper.getData("isPaid");

            paymentModel=PaymentModel.fromJson(transactionDetails);

            if(paymentModel!=null){
              updateOrder(paymentModel: billingDetailsData, paymentModel2: paymentModel!);
            }
            print("resssssssssssssssssssssssss$transactionDetails");
            emit(PaymentSuccessState());


            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");

          }

          // print(transactionDetails["isSuccess"]);
        }
        else if (event["status"] == "error") {
          print("Errorrrrrr: ${event["message"]}");
          emit(PaymentErrorState());
          // Handle error here.
        } else if (event["status"] == "event") {
          print("event $event");
          emit(PaymentErrorState());
          // Handle events here.
        }

      });
  }



Future<void> updateOrder({required BillingDetails paymentModel,required PaymentModel paymentModel2})async{
  emit(UpdateOrderLoadingState());
  print("aaaaaaaaaaaaaaaaaaaa${paymentModel.countryId}");
  print("aaaaaaaaaaaaaaaaaaaa${paymentModel.orderId}");
  print("aaaaaaaaaaaaaaaaaaaa${paymentModel.total}");
    final response=await Mhelper.postData(url: 'api/orders/${paymentModel.orderId}',data: {
      "_method":"put",
      "user_name":paymentModel.name,
      "user_email":paymentModel.email,
      "user_phone":paymentModel.phone,
      "country_id":paymentModel.countryId,
      "state_id":paymentModel.cityId,
      "country_ref_code":paymentModel.country,
      "payment_ref_code":paymentModel2.transactionReference,
      "zip_code":paymentModel.zipCode,
      "address":paymentModel.addressLine,
      "rate_status":1,
      "response_status":paymentModel2.paymentResult?.responseStatus
    },token: kToken);

    if(response.data["status"]){
      emit(UpdateOrderSuccessState());
    }else{
      emit(UpdateOrderErrorState());
    }
}



}
