import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/presentation/screens/components/personel_screens/vacation_form/controller/vacation_state.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../data/models/employee__data_model/employee_data_model.dart';
import '../../../../../../data/models/infraction_form_model/infraction_form_model.dart';
import '../../../../../../data/models/signature_data/signature_model.dart';
import '../../../../../../data/models/vacation_model/vacation_model.dart';
import '../../../../../../help/toast/toast_states.dart';


class VacationCubit extends Cubit<VacationState> {
  VacationCubit() : super(VacationInitial());

  static VacationCubit get(context)=>BlocProvider.of(context);

  var formKey=GlobalKey<FormState>();


  var nameController=TextEditingController();
  var employeeNoController=TextEditingController();
  var nationalityController=TextEditingController();
  var departmentController=TextEditingController();
  var jobTitleController=TextEditingController();
  var lastVacationController=TextEditingController();
  var startJobDateController=TextEditingController();
  var infractionController=TextEditingController();
  var vacationStartingDateController=TextEditingController();
  var vacationEndingDateController=TextEditingController();
  var addressController=TextEditingController();
  var phoneController=TextEditingController();
  var directManagerDecisionController=TextEditingController();
  var generalManagerController=TextEditingController();
  List<MainInfractionFormModel> form()=>[
    MainInfractionFormModel(arabicTitle: "اسم الموظف", englishTitle: "Name", controller: nameController),
    MainInfractionFormModel(arabicTitle: "المهنه", englishTitle: "Occupation", controller: jobTitleController),
    MainInfractionFormModel(arabicTitle: "الجنسيه", englishTitle: "Nationality", controller: nationalityController),
    MainInfractionFormModel(arabicTitle: "رقم الموظف", englishTitle: "Employee No", controller: employeeNoController),
    MainInfractionFormModel(arabicTitle: "تاريخ التعيين", englishTitle: "Starting Date", controller: startJobDateController),
     MainInfractionFormModel(arabicTitle: "القسم", englishTitle: "Department", controller: departmentController),
    MainInfractionFormModel(arabicTitle: "تاريخ اخر اجازه", englishTitle: "Last Vacation Date", controller: lastVacationController),
  ];

  // void getDayDate() {
  //   dateController.text =
  //   "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  // }

  EmployeeDataModel? employeesData;
  List<String> employees=[];
  Future<void> getEmployees()async{
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
        jobTitleController.text=element.employeeJob!;
        nationalityController.text=element.employeeNationality!;
        startJobDateController.text=element.employeeStartWorkDate!;
        employeeNoController.text=element.employeeId.toString();
        phoneController.text=element.employeePhone!;
        addressController.text=element.employeeAddress!;
        departmentController.text=element.employeeDepartmentName!;

        if(element.employeeLastVacationData!="") {
          lastVacationController.text = element.employeeLastVacationData!;
        }else{
          lastVacationController.text="لم يسبق له اجازه";
        }
      }
    });
    emit(ChangeSelectedEmployeeSuccessState());

  }


  // signature bloc
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  PMData? signatureData;
  Future<void> getSignatureData()async{
    emit(GetSignatureLoadingState());
    final response=await Mhelper.getData(
        url:' ApiConstance.hasSignature',
    token: 'AppConstance.token');
    if(response.statusCode==200){
      signatureData=PMData.fromJson(response.data);
      print("dataaaaa:${signatureData}");
      selectedEmployeeId=signatureData!.data!.id!;
      nameController.text=signatureData!.data!.name!;
      jobTitleController.text=signatureData!.data!.jobName!;
      nationalityController.text=signatureData!.data!.nationality!;
      startJobDateController.text='16-3-2023';
      employeeNoController.text=signatureData!.data!.nationalNo!;
      phoneController.text=signatureData!.data!.phone!;
      addressController.text=signatureData!.data!.address!;
      departmentController.text=signatureData!.data!.jobName!;
      if(signatureData!.data!.lastVacation!=""){
        lastVacationController.text=signatureData!.data!.lastVacation!;
      }else{
        lastVacationController.text="لم يسبق له الاجازه";
      }

      emit(GetSignatureSuccessState());
    }else{
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
// signature bloc


// check box bloc

//vacation type check box bloc
  bool isFromYearVacation=false;
  bool isWithoutSalary=false;
  bool isYearVacation=false;

  int currentIndex=0;
  void changeVacationType(int index){
    currentIndex=index;
   // print("isDeduction:::${isDeduction}");
    if(index==0){
      isFromYearVacation=!isFromYearVacation;
      if(isWithoutSalary==true){
        isWithoutSalary=false;
      }
      if(isYearVacation==true){
        isYearVacation=false;
      }

    }
    if(index==1){
      isWithoutSalary=!isWithoutSalary;
      if(isFromYearVacation==true){
        isFromYearVacation=false;
      }
      if(isYearVacation==true){
        isYearVacation =false;
      }
    }
    if(index==2){
      isYearVacation=!isYearVacation;
      if(isWithoutSalary==true){
        isWithoutSalary=false;
      }
      if(isFromYearVacation==true){
        isFromYearVacation=false;
      }
    }
    emit(ChangePunishmentTypeSuccessState());
  }
//vacation type check box bloc


//ticket check box

  bool isHundred=false;
  bool isEmployeeAndFamily=false;
  bool isEmployee=false;

  int currentTicketIndex=0;
  void changeTicketType(int index){
    currentTicketIndex=index;
    // print("isDeduction:::${isDeduction}");
    if(index==0){
      isHundred=!isHundred;
      if(isEmployeeAndFamily==true){
        isEmployeeAndFamily=false;
      }
      if(isEmployee==true){
        isEmployee=false;
      }

    }
    if(index==1){
      isEmployeeAndFamily=!isEmployeeAndFamily;
      if(isHundred==true){
        isHundred=false;
      }
      if(isEmployee==true){
        isEmployee =false;
      }
    }
    if(index==2){
      isEmployee=!isEmployee;
      if(isHundred==true){
        isHundred=false;
      }
      if(isEmployeeAndFamily==true){
        isEmployeeAndFamily=false;
      }
    }
    emit(ChangePunishmentTypeSuccessState());
  }
//ticket check box

//replacement check box

  bool isNotRequired=false;
  bool isRequired=false;
  bool isEmployeeOnly=false;

  int currentReplacementIndex=0;
  void changeReplacementType(int index){
    currentReplacementIndex=index;
    // print("isDeduction:::${isDeduction}");
    if(index==0){
      isNotRequired=!isNotRequired;
      if(isRequired==true){
        isRequired=false;
      }
      if(isEmployeeOnly==true){
        isEmployeeOnly=false;
      }

    }
    if(index==1){
      isRequired=!isRequired;
      if(isNotRequired==true){
        isNotRequired=false;
      }
      if(isEmployeeOnly==true){
        isEmployeeOnly =false;
      }
    }
    if(index==2){
      isEmployeeOnly=!isEmployeeOnly;
      if(isNotRequired==true){
        isNotRequired=false;
      }
      if(isRequired==true){
        isRequired=false;
      }
    }
    emit(ChangePunishmentTypeSuccessState());
  }
//replacement check box


//send vacation form data
Future<void> sendVacationFormData()async{
    emit(SendVacationFormDataLoadingState());
    final response=await Mhelper.postData(url: 'ApiConstance.sendVacation',
    token: 'AppConstance.token',
    data:FormData.fromMap({
      "employee_id":selectedEmployeeId,
      "resource_id":1,
      "from":vacationStartingDateController.text,
      "to":vacationEndingDateController.text,
      "type":currentIndex,
      "ticket_requirement":currentTicketIndex,
      "replacement":currentReplacementIndex,
      "address":addressController.text,
      "phone":phoneController.text,
      'manager_signature':await MultipartFile.fromFile(imageUploaded!.path),
      "decision":directManagerDecisionController.text,
      "general_manager":generalManagerController.text,
    }));

    if(response.statusCode==200){
      if(response.data["success"]==true){
       ToastConfig.showToast(msg: 'تم اضافة طلب الاجازة بنجاح', toastStates: ToastStates.success);

      }
      if(response.data['success']==false){
        ToastConfig.showToast(msg: response.data['message'], toastStates: ToastStates.success);
      }
      emit(SendVacationFormDataSuccessState());
    }else{
      emit(SendVacationFormDataErrorState(error: response.data['message']));
    }
}

//send vacation form data

//delete All data
void deleteAllData(){
    // jobTitleController.text="";
    // nationalityController.text="";
    // employeeNoController.text="";
    directManagerDecisionController.text="";
    generalManagerController.text="";
    // startJobDateController.text="";
    // departmentController.text="";
    // nameController.text='';
    lastVacationController.text="";
    vacationStartingDateController.text="";
    vacationEndingDateController.text="";
    // addressController.text="";
    // phoneController.text="";
    isNotRequired=false;
     isRequired=false;
    isEmployeeOnly=false;
     isFromYearVacation=false;
     isWithoutSalary=false;
     isYearVacation=false;
     isHundred=false;
     isEmployeeAndFamily=false;
     isEmployee=false;
    imageUploaded=null;
    selectedEmployee=null;
    selectedEmployeeId=null;
    emit(ClearAllDataSuccessState());

}

//delete All data


  VacationModel? vacationModel;
  Future<void> getAllVacationsData()async{
    emit(GetVacationsDataLoadingState());
    final response=await Mhelper.getData(url: "/api/pm/view-vacation",
        token: 'AppConstance.token');
    if(response.statusCode==200){
      vacationModel=VacationModel.fromJson(response.data);
      emit(GetVacationsDataSuccessState());
    }else{
      emit(GetVacationsDataErrorState(error: response.data['message']));
    }
  }

}
