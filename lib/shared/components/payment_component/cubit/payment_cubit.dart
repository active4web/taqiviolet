
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTransactionType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:safsofa/models/update_order_model.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';
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
      PaymentSdkAPms.STC_PAY,
      PaymentSdkAPms.VALU,
      PaymentSdkAPms.TABBY
    ];
    apms.add(PaymentSdkAPms.AMAN);
    final configuration = PaymentSdkConfigurationDetails(
        // profileId: "97745", //test
      profileId: '98609', //live
        // serverKey: "SHJNGGK6D9-J6B9NZHNWN-ZRN6M9TKRM",//test
        // clientKey: "CMKMNP-RK696G-2PQ9HQ-HKN9GD",//test
        serverKey: 'S6JNGGK6ZK-J6DM6GBHDL-NR6JMJLB26',//live
        clientKey: 'C7KMNP-RK666G-DNGT2H-B7BVBQ',//live
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

        merchantApplePayIndentifier: "merchant.com.taqiviolet",
        linkBillingNameWithCardHolderName: true);
    final theme = IOSThemeConfigurations(

    );
    configuration.simplifyApplePayValidation=true;
    //  theme.logoImage = "assets/logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;

    return configuration;
  }

  Future<void> apmsPayPressed({required BillingDetails billingDetailsData,
    required ShippingDetails shippingDetailsData}) async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(generateConfig(
        billingDetailsData,shippingDetailsData
    ),
            (event) {

          if (event["status"] == "success") {
            // Handle transaction details here.
            var transactionDetails = event["data"];
            print(transactionDetails);
          } else if (event["status"] == "error") {
            // Handle error here.
          } else if (event["status"] == "event") {
            // Handle events here.
          }
        });

  }
  Future<void> payPressed({
    required BillingDetails billingDetailsData,
    required ShippingDetails shippingDetailsData
}) async {
    emit(PaymentLoadingState());
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
            ToastConfig.showToast(msg: 'حدث خطأ اثناء الدفع', toastStates:ToastStates.error);

          }

          // print(transactionDetails["isSuccess"]);
        }
        else if (event["status"] == "error") {
          print("Errorrrrrr: ${event["message"]}");
          emit(PaymentErrorState());
          ToastConfig.showToast(msg: 'حدث خطأ اثناء الدفع', toastStates:ToastStates.error);
          // Handle error here.
        } else if (event["status"] == "event") {
          print("event $event");
          ToastConfig.showToast(msg: 'حدث خطأ اثناء الدفع', toastStates:ToastStates.error);
          emit(PaymentErrorState());
          // Handle events here.
        }

      });
  }


UpdateOrderModel? order;
  int? orderId;
Future<void> updateOrder({required BillingDetails paymentModel,required PaymentModel paymentModel2})async{
  orderId=int.parse(paymentModel.orderId);
  emit(UpdateOrderLoadingState());
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
      order=UpdateOrderModel.fromJson(response.data);
      emit(UpdateOrderSuccessState());
    }else{
      emit(UpdateOrderErrorState());
    }
}


  Future<void> applePayPressed({
    required BillingDetails billingDetailsData,
    required ShippingDetails shippingDetailsData
  }) async {
    var configuration = PaymentSdkConfigurationDetails(
      // profileId: "97745", //test
      profileId: '98609', //live
      // serverKey: "SHJNGGK6D9-J6B9NZHNWN-ZRN6M9TKRM",//test
      // clientKey: "CMKMNP-RK696G-2PQ9HQ-HKN9GD",//test
      serverKey: 'S6JNGGK6ZK-J6DM6GBHDL-NR6JMJLB26',//live
      clientKey: 'C7KMNP-RK666G-DNGT2H-B7BVBQ',//live
      cartId:billingDetailsData.orderId,
      cartDescription: "cart desc",
      screentTitle: "Pay with Apple Pay",
      billingDetails: billingDetailsData,
      shippingDetails: shippingDetailsData,
      locale: PaymentSdkLocale.EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
      amount: billingDetailsData.total.toDouble(),
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      merchantName: "Taqi Violet Commercial",
      alternativePaymentMethods: [
        PaymentSdkAPms.APPLE_PAY,
      ],
      merchantApplePayIndentifier: "merchant.com.bundleID",
    );
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {

      print("Event:::${event}");
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          print("successful transaction");
          CacheHelper.setData(key: "isPaid",value:true);
          isPaid= CacheHelper.getData("isPaid");

          paymentModel=PaymentModel.fromJson(transactionDetails);

          if(paymentModel!=null){
            updateOrder(paymentModel: billingDetailsData, paymentModel2: paymentModel!);
          }
          print("resssssssssssssssssssssssss$transactionDetails");
          emit(PaymentSuccessState());

        } else if (event["status"] == "error") {
          emit(PaymentErrorState());
          ToastConfig.showToast(msg: 'حدث خطأ اثناء الدفع', toastStates:ToastStates.error);
        } else if (event["status"] == "event") {
          // Handle events here.
          print("event $event");
          emit(PaymentErrorState());
          ToastConfig.showToast(msg: 'ليس لديك حساب مسجل', toastStates:ToastStates.error);
        }

    });
  }

  Future<void> payWithTabby({
    required BillingDetails billingDetailsData,
    required ShippingDetails shippingDetailsData
  }) async {
    List<PaymentSdkAPms> apms = [
      PaymentSdkAPms.TABBY,

    ];
    var configuration = PaymentSdkConfigurationDetails(
      // profileId: "97745", //test
      profileId: '98608', //live
      // serverKey: "SHJNGGK6D9-J6B9NZHNWN-ZRN6M9TKRM",//test
      // clientKey: "CMKMNP-RK696G-2PQ9HQ-HKN9GD",//test
      serverKey: 'S6JNGGK6ZK-J6DM6GBHDL-NR6JMJLB26',//live
      clientKey: 'C7KMNP-RK666G-DNGT2H-B7BVBQ',//live
      // profileId: "105601",
      // serverKey: "SWJN6WHN6M-JHGZHWGRB9-W2BDN6LZWT",
      alternativePaymentMethods: apms,
      // clientKey: "CTKMVK-VB9B6H-T9HVTR-9MTQHB",
      cartId:billingDetailsData.orderId,
      cartDescription: "cart desc",
      screentTitle: "Pay with Apple Pay",
      billingDetails: billingDetailsData,
      shippingDetails: shippingDetailsData,
      locale: PaymentSdkLocale.EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
      amount: billingDetailsData.total.toDouble(),
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      merchantName: "Taqi Violet Commercial",
      merchantApplePayIndentifier: "merchant.com.bundleID",
    );
    FlutterPaytabsBridge.startAlternativePaymentMethod(configuration, (event) {

      print("Event:::${event}");
      if (event["status"] == "success") {
        // Handle transaction details here.
        var transactionDetails = event["data"];
        print(transactionDetails);
        print("successful transaction");
        CacheHelper.setData(key: "isPaid",value:true);
        isPaid= CacheHelper.getData("isPaid");

        paymentModel=PaymentModel.fromJson(transactionDetails);

        if(paymentModel!=null){
          updateOrder(paymentModel: billingDetailsData, paymentModel2: paymentModel!);
        }
        print("resssssssssssssssssssssssss$transactionDetails");
        emit(PaymentSuccessState());

      } else if (event["status"] == "error") {
        emit(PaymentErrorState());
        ToastConfig.showToast(msg: 'حدث خطأ اثناء الدفع', toastStates:ToastStates.error);
      } else if (event["status"] == "event") {
        // Handle events here.
        print("event $event");
        emit(PaymentErrorState());
      }

    });
  }


  int chosePay=0;
changePay(int pay){
  if(pay==chosePay){
    chosePay=0;
  }else{
    chosePay=pay;

  }
emit(ChangePay());
}

String? html;
  testF()async{
   final resp=await Mhelper.postData(url: 'https://taqiviolet.com/api/orders/to-paytabs',token: kToken,data: {
    'address':"dsflmvm",
    "name":"ahmed",
    "email":"activ@gmail.com",
    "phone":"032359358",
    "state_id":4,
    "country_id":1,
    "zip_code":1234
  }).then((value) => {
      print("value"),
       print(value),
  }).catchError((error){

    print("eeeeeeeeeeeeeeeeee");
    print(error);
   });

  // if(response)
  // html=responseStatu.toString();
  // print("resssssssssssssssss${html}");
}
}
