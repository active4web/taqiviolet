import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/receipt_record_screen/controller/receipt_record_state.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../data/models/employee__data_model/employee_data_model.dart';
import '../../../../../../data/models/infraction_form_model/infraction_form_model.dart';
import '../../../../../../data/models/receipt_record_model/receipt_record_model.dart';
import '../../../../../../data/models/signature_data/signature_model.dart';
import '../../../../../../help/toast/toast_states.dart';



class ReceiptRecordCubit extends Cubit<ReceiptRecordState> {
  ReceiptRecordCubit() : super(ReceiptRecordInitial());

  static ReceiptRecordCubit get(context)=>BlocProvider.of(context);
var formKey=GlobalKey<FormState>();
var formKey2=GlobalKey<FormState>();

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  List<String> arabicTitles = ['البيان', 'العدد', 'الملاحظات'];
  List<String> englishTitles = ['Statement', 'Number', 'Notes'];

  var statementController=TextEditingController();
  var numberController=TextEditingController();
  var notesController=TextEditingController();


  List<MainInfractionFormModel> otherData()=>[

    MainInfractionFormModel(arabicTitle: "البيان",
        englishTitle: "Statement", controller: TextEditingController(),),
    MainInfractionFormModel(arabicTitle: "العدد",
        englishTitle: "Number", controller: TextEditingController(),),
    MainInfractionFormModel(arabicTitle: "الملاحظات",
        englishTitle: "Notes", controller: TextEditingController(),),
  ];
  var nameController=TextEditingController();
  var personalIdController=TextEditingController();
  var departmentNameController=TextEditingController();
  var jobTitleController=TextEditingController();
  List<MainInfractionFormModel> form()=>[
    MainInfractionFormModel(arabicTitle: "رقم الهويه", englishTitle: "Nationality Id", controller:employeeNationality),
    MainInfractionFormModel(arabicTitle: "الوظيفه", englishTitle: "Job Title", controller: employeeJob),

  ];
  var employeeJob=TextEditingController();
  var employeeNationality=TextEditingController();

  PMData? signatureData;


  Future<void> getSignatureData()async{
    emit(GetSignatureLoadingState());
    print("مصطفى"*10);
    final response=await Mhelper.getData(
      url: 'ApiConstance.hasSignature',
      token: 'AppConstance.token',
    );
    if(response.statusCode==200){
      signatureData=PMData.fromJson(response.data);
      // numberController.text=signatureData!.data!.id.toString();
      selectedEmployeeId=signatureData!.data!.id!;
      nameController.text=signatureData!.data!.name!;
      employeeNationality.text=signatureData!.data!.nationalNo!;
      employeeJob.text=signatureData!.data!.jobName!;
      departmentNameController.text=signatureData!.data!.jobName!;
      // employeeNationality.text=signatureData!.data!.nationality!;
      //employeeNumber.text=signatureData.toString();
      // if(response.data["success"]==false){
      //   signatureData=SignatureModel(
      //     data: Data(
      //       signature: ""
      //     )
      //   );
      //   numberController.text=signatureData!.data!.id.toString();
      // }
      emit(GetSignatureSuccessState());
      print("مصطفى"*10);
    }
    else{
      emit(GetSignatureErrorState(error:response.data['message']));
    }
  }



  void handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }
  //late dynamic image;
  File? imageUploaded;
  void handleSaveButtonPressed({required context,required ui}) async {


    final image =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await image.toByteData(format: ui);

    final myImage=bytes!.buffer.asUint8List();
    imageUploaded = await saveUint8ListToFile(myImage);
    // final directory = await getApplicationDocumentsDirectory();
    // final path = '${directory.path}/signature.png';
    // final file = io.File(path);
    // await file.writeAsBytes(image);


  }

  Future<File> saveUint8ListToFile(Uint8List bytes) async {
    // Get the system temporary directory.
    final directory = await getTemporaryDirectory();

    // Generate a unique file name.
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';

    // Create a File object with the temporary directory and file name.
    final file = File('${directory.path}/$fileName');

    // Write the bytes to the file.
    await file.writeAsBytes(bytes);

    return file;
  }
  EmployeeDataModel? employeesData;
  List<String> employees=[];
  Future<void> getEmployees()async{
    emit(GetEmployeesLoadingState());
    final response=await Mhelper.getData(url:' ApiConstance.getEmployees',
        token: 'AppConstance.token');

    if(response.statusCode==200){
      employeesData=EmployeeDataModel.fromJson(response.data);
      employeesData!.message!.listemployess!.forEach((element) {
        employees.add(element.employeeName!);
      });
      emit(GetEmployeesSuccessState());

    }else{
      emit(GetEmployeesErrorState(error: response.data["data"]));
    }
  }


  String? selectedEmployee;
  int? selectedEmployeeId;
  void changeSelectedEmployee(String value){

    selectedEmployee=value;
    employeesData!.message!.listemployess!.forEach((element) {
      if(element.employeeName==value){
        selectedEmployeeId=element.employeeId!;
        employeeJob.text=element.employeeJob!;
        employeeNationality.text=element.employeeNationality!;
        departmentNameController.text=element.employeeDepartmentName!;
       // employeeNumber.text=element.employeeId.toString();
        // employeeStartDate.text=element..toString();
      }
    });
    emit(ChangeSelectedEmployeeSuccessState());

  }


  Future<void> sendReceiptRecordFormData()async{
    emit(SendReceiptRecordFormDataLoadingState());
    final response=await Mhelper.postData(
        url: 'ApiConstance.receiptRecord',
    token:' AppConstance.token',
    data: FormData.fromMap({
      "employee_id":selectedEmployeeId,
      "resource_id":1,
      "date":dateOfDay,
      "signature":await  MultipartFile.fromFile(imageUploaded!.path),
      "items":jsonEncode([
        {
          "item": statementController.text,
          "qty": int.parse(numberController.text),
          "notes": notesController.text
        },

      ])
    }));
    if(response.statusCode==200){
      if(response.data["success"]==true){
        ToastConfig.showToast(msg: 'تم اضافة محضر الاستلام بنجاح', toastStates: ToastStates.success);

      }
      if(response.data['success']==false){
        ToastConfig.showToast(msg: response.data['message'], toastStates: ToastStates.success);
      }
      emit(SendReceiptRecordFormDataSuccessState());
    }else{
      emit(SendReceiptRecordFormDataErrorState(error: response.data['message']));
    }
  }

  void deleteAllData(){
    selectedEmployee=null;
    selectedEmployeeId=null;
    statementController.text='';
    numberController.text='';
    notesController.text='';
    imageUploaded=null;

  }

  String dateOfDay='';
  void getDayDate() {
    dateOfDay =
    "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  }



  ReceiptRecordModel? receiptRecordModel;
  Future<void> getAllReceiptData()async{
    emit(GetReceiptRecordDataLoadingState());
    final response=await Mhelper.getData(url: "/api/pm/view-receipt_records",
    token: 'AppConstance.token');
    if(response.statusCode==200){
      receiptRecordModel=ReceiptRecordModel.fromJson(response.data);
      emit(GetReceiptRecordDataSuccessState());
    }else{
      emit(GetReceiptRecordDataErrorState(error: response.data['message']));
    }
  }
}
