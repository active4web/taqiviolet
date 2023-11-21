import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/starting_wotk_from_screen/controller/starting_work_state.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../data/models/employee__data_model/employee_data_model.dart';
import '../../../../../../data/models/infraction_form_model/infraction_form_model.dart';
import '../../../../../../data/models/signature_data/signature_model.dart';
import '../../../../../../data/models/start_work_model/start_work_model.dart';
import '../../../../../../help/toast/toast_states.dart';


class StartingWorkCubit extends Cubit<StartingWorkState> {
  StartingWorkCubit() : super(StartingWorkInitial());


  static StartingWorkCubit get(context)=>BlocProvider.of(context);

  var formKey=GlobalKey<FormState>();

  var employeeName=TextEditingController();
  var employeeJob=TextEditingController();
  var employeeNationality=TextEditingController();
  var employeeStartDate=TextEditingController();
  var employeeNumber=TextEditingController();
  var directManagerDecision=TextEditingController();
  var generalManager=TextEditingController();

  var numberController=TextEditingController();
  var dateController=TextEditingController();
  void getDayDate() {
    dateController.text =
    "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  }
  List<MainInfractionFormModel> form()=>[
    MainInfractionFormModel(arabicTitle: "اسم الموظف",
        englishTitle: "Name", controller: employeeName),
  MainInfractionFormModel(arabicTitle: "الوظيفه",
  englishTitle: "Job Title", controller: employeeJob),
  MainInfractionFormModel(arabicTitle: "الجنسيه",
  englishTitle: "Nationality", controller: employeeNationality),
  MainInfractionFormModel(arabicTitle: "رقم الموظف",
  englishTitle: "Employee No", controller: employeeNumber),
  MainInfractionFormModel(arabicTitle: "تاريخ مباشرة العمل فعلي"
  , englishTitle: "Starting Date", controller: employeeStartDate),

  ];

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  final GlobalKey<SfSignaturePadState> signatureGlobalKey2 = GlobalKey();

  PMData? signatureData;

  
  Future<void> getSignatureData()async{
    emit(GetSignatureLoadingState());
    print("مصطفى"*10);
    final response=await Mhelper.getData(
        url: 'ApiConstance.hasSignature',
      token: 'Constance.tokenApp',
    );
    if(response.statusCode==200){

        signatureData=PMData.fromJson(response.data);
        numberController.text=signatureData!.data!.id.toString();
        selectedEmployeeId=signatureData!.data!.id!;
        employeeName.text=signatureData!.data!.name!;
        employeeNumber.text=signatureData!.data!.nationalNo!;
        employeeJob.text=signatureData!.data!.jobName!;
        employeeStartDate.text=signatureData!.data!.startWorkDate!;
        employeeNationality.text=signatureData!.data!.nationality!;
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
  
  

  void handleClearButtonPressed({required  GlobalKey<SfSignaturePadState>  key}) {
    key.currentState!.clear();
  }
  //late dynamic image;
  File? imageUploaded;
 void handleSaveButtonPressed({required context,required ui,required  GlobalKey<SfSignaturePadState>  key}) async {


    final image =
    await key.currentState!.toImage(pixelRatio: 3.0);
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
    employeesData=null;
    employees=[];
emit(GetEmployeesLoadingState());
    final response=await Mhelper.getData(url: 'ApiConstance.getEmployees',
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
        employeeStartDate.text=element.employeeStartWorkDate!;
        employeeNationality.text=element.employeeNationality!;
        employeeNumber.text=element.employeeId.toString();
       // employeeStartDate.text=element..toString();
      }
    });
    emit(ChangeSelectedEmployeeSuccessState());

  }




  Future<void> sendStartWorkData()async{
emit(SendStartWorkFormDataLoadingState());
    final response=await Mhelper.postData(
        url:' ApiConstance.startWork',
    token: 'AppConstance.token',
    data: FormData.fromMap({
      "employee_id":selectedEmployeeId,
      "date":dateController.text,
      "manager_signature":await MultipartFile.fromFile(imageUploaded!.path),
      "decision":directManagerDecision.text,
      "general_manager":generalManager.text
    }));

    if(response.statusCode==200){
      if(response.data["success"]==true){
        ToastConfig.showToast(msg: 'تم اضافة طلب بدء العمل بنجاح', toastStates: ToastStates.success);

      }
      if(response.data['success']==false){
        ToastConfig.showToast(msg: response.data['message'], toastStates: ToastStates.success);
      }
      emit(SendStartWorkFormDataSuccessState());
    }else{
      emit(SendStartWorkFormDataErrorState(error:response.data["message"]));
    }

  }


  void deleteAllData(){
    selectedEmployee=null;
    selectedEmployeeId=null;
    // employeeJob.text='';
    // employeeName.text='';
    // numberController.text='';
    // employeeNationality.text='';
    // employeeNationality.text='';
    // employeeNumber.text='';
    // employeeStartDate.text='';
   // handleClearButtonPressed();
    generalManager.text='';
    imageUploaded=null;
    directManagerDecision.text='';
    emit(ClearAllDataSuccessState());
  }


  StartWorkModel? startWorkModel;
  Future<void> getAllStartWorkData()async{
    emit(GetStartWorkDataLoadingState());
    final response=await Mhelper.getData(url: "/api/pm/view-strat_work",
        token: 'AppConstance.token');
    if(response.statusCode==200){
      startWorkModel=StartWorkModel.fromJson(response.data);
      emit(GetStartWorkDataSuccessState());
    }else{
      emit(GetStartWorkDataErrorState(error: response.data['message']));
    }
  }
}
