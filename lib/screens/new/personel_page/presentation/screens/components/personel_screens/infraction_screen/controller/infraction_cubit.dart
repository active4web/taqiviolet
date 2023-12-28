import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../data/models/employee__data_model/employee_data_model.dart';
import '../../../../../../data/models/infraction_form_model/infraction_form_model.dart';
import '../../../../../../data/models/infraction_model/infraction_model.dart';
import '../../../../../../data/models/signature_data/signature_model.dart';
import '../../../../../../help/toast/toast_states.dart';
import 'infraction_state.dart';



class InfractionCubit extends Cubit<InfractionState> {
  InfractionCubit() : super(InfractionInitial());

  static InfractionCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var dateController = TextEditingController();
  var numberController = TextEditingController();
  var nameController = TextEditingController();
  var employeeNoController = TextEditingController();
  var departmentController = TextEditingController();
  var jobTitleController = TextEditingController();
  var infractionController = TextEditingController();
  var directManagerDescisionController = TextEditingController();
  var generalManagerController = TextEditingController();
  var procedureController = TextEditingController();


  List<MainInfractionFormModel> from() =>
      [

        MainInfractionFormModel(arabicTitle: "رقم الموظف",
            englishTitle: "Employee No:",
            controller: employeeNoController),
        MainInfractionFormModel(arabicTitle: "الادارة",
            englishTitle: "Department",
            controller: departmentController),
        MainInfractionFormModel(arabicTitle: "الوظيفه",
            englishTitle: "Job Title",
            controller: jobTitleController),
        MainInfractionFormModel(arabicTitle: "المخالفه",
            englishTitle: "Infraction",
            controller: infractionController),
      ];

  void getDayDate() {
    dateController.text =
    "${DateTime
        .now()
        .year}-${DateTime
        .now()
        .month}-${DateTime
        .now()
        .day}";
  }

  EmployeeDataModel? employeesData;
  List<String> employees = [];

  Future<void> getEmployees()async{
    employees=[];
    employeesData=null;
    emit(GetEmployeesLoadingState());
    final response=await Mhelper.getData(url:' ApiConstance.getEmployees',
        token:' AppConstance.token');

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

  void changeSelectedEmployee(String value) {
    selectedEmployee = value;
    employeesData!.message!.listemployess!.forEach((element) {
      if (element.employeeName == value) {
        selectedEmployeeId = element.employeeId!;
        jobTitleController.text = element.employeeJob!;
        //employeeNationality.text=element.employeeNationality!;
        employeeNoController.text = element.employeeId.toString();
        departmentController.text = element.employeeDepartmentName!;
        // employeeStartDate.text=element..toString();
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
        url: 'ApiConstance.hasSignature',
    token: 'AppConstance.token');
    if(response.statusCode==200){
      signatureData=PMData.fromJson(response.data);
      numberController.text=signatureData!.data!.id.toString();
      emit(GetSignatureSuccessState());
    }else{
      emit(GetSignatureErrorState(error:response.data['message']));
    }
  }

  void handleClearButtonPressed({required GlobalKey<SfSignaturePadState> key}) {
    key.currentState!.clear();
  }

  //late dynamic image;
  File? imageUploaded;

  void handleSaveButtonPressed(
      {required context, required ui, required GlobalKey<
          SfSignaturePadState> key}) async {
    final image =
    await key.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await image.toByteData(format: ui);

    final myImage = bytes!.buffer.asUint8List();
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
    final fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString() + '.png';

    // Create a File object with the temporary directory and file name.
    final file = File('${directory.path}/$fileName');

    // Write the bytes to the file.
    await file.writeAsBytes(bytes);

    return file;
  }

  // signature bloc


// check box bloc

  bool isDeduction = false;
  bool isNotes = false;
  bool isWarning = false;

  int currentIndex = 0;

  void changePunishmentType(int index) {
    currentIndex = index;
    print("isDeduction:::${isDeduction}");
    if (index == 0) {
      isDeduction = !isDeduction;
      if (isNotes == true) {
        isNotes = false;
      }
      if (isWarning == true) {
        isWarning = false;
      }
    }
    if (index == 1) {
      isNotes = !isNotes;
      if (isDeduction == true) {
        isDeduction = false;
      }
      if (isWarning == true) {
        isWarning = false;
      }
    }
    if (index == 2) {
      isWarning = !isWarning;
      if (isDeduction == true) {
        isDeduction = false;
      }
      if (isNotes == true) {
        isNotes = false;
      }
    }
    emit(ChangePunishmentTypeSuccessState());
  }


// check box bloc

// send form Data

Future<void> sendInfractionData()async {
  emit(SendInfractionFormDataLoadingState());
  final response=await Mhelper.postData(url: 'ApiConstance.sendInfraction',
  token: 'AppConstance.token',
      // data: FormData.fromMap({
      //   "employee_id":selectedEmployeeId,
      //   "resource_id":1,
      //   "date":dateController.text,
      //   "punishment":currentIndex,
      //   "signature":await MultipartFile.fromFile(imageUploaded!.path),
      //   "director_signature":directManagerDescisionController.text,
      //   "general_manager":generalManagerController.text,
      //   "procedure":procedureController.text,
      //   "infraction":infractionController.text
      // })
  );

    if(response.statusCode==200){

      if(response.data["success"]==true){
        ToastConfig.showToast(msg:  'تم اضافة المخالفة بنجاح', toastStates: ToastStates.success);

      }
      if(response.data['success']==false){
        ToastConfig.showToast(msg: response.data['message'], toastStates: ToastStates.success);
      }
      emit(SendInfractionFormDataSuccessState());

    }else{
      emit(SendInfractionFormDataErrorState(error: response.data['message']));
    }
}

//Send form data

//delete All Data
  void deleteAllData() {
    selectedEmployee = null;
    selectedEmployeeId = null;
    isWarning = false;
    isNotes = false;
    isDeduction = false;
    employeeNoController.text = '';
    departmentController.text = '';
    jobTitleController.text = '';
    infractionController.text = '';
    procedureController.text = '';
    imageUploaded = null;
    // handleClearButtonPressed();
    directManagerDescisionController.text = '';
    generalManagerController.text = '';
    emit(ClearAllDataSuccessState());
  }


  InfractionModel? infractionModel;
  Future<void> getAllInfractionsData()async{
    emit(GetInfractionDataLoadingState());
    final response=await Mhelper.getData(url: "/api/pm/view-infraction",
        token: 'AppConstance.token');
    if(response.statusCode==200){
      infractionModel=InfractionModel.fromJson(response.data);
      emit(GetInfractionDataSuccessState());
    }else{
      emit(GetInfractionDataErrorState(error: response.data['message']));
    }
  }


}