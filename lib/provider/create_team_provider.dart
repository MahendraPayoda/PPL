import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payoda/model/create_team_response.dart';
import 'package:payoda/model/get_employee_name_response.dart';
import 'package:payoda/router/app_router.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CreateTeamProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  CreateTeamResponse? createTeamResponse;
  GetEmployeeNameResponse? captainName;
  GetEmployeeNameResponse? viceCaptainName;
  GetEmployeeNameResponse? sponsorName;
  int page = 1;
  int pageForViceCaptain = 1;
  int pageForSponsor = 1;
  List<GetEmployeeNameResponse> employeeNameListForCaptain = [];
  List<GetEmployeeNameResponse> employeeNameListForViceCaptain = [];
  List<GetEmployeeNameResponse> tempEmployeeNameListForCaptain = [];
  List<GetEmployeeNameResponse> tempEmployeeNameListForViceCaptain = [];
  List<GetEmployeeNameResponse> tempEmployeeNameListForSponsor = [];
  List<GetEmployeeNameResponse> employeeNameListForSponsor = [];
  final teamNameController = TextEditingController();
  final captainController = TextEditingController();
  final viceCaptainController = TextEditingController();
  final sponsorController = TextEditingController();
  File? pickedImage;
  int selectedCaptainId = 0;
  int selectedViceCaptainId = 0;
  int selectedSponsorId = 0;

  PlatformFile? pickedExcelFile;

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshControllerForViceCaptain = RefreshController(initialRefresh: false);
  final RefreshController refreshControllerForSponsor = RefreshController(initialRefresh: false);
  bool isLoading = false;

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  onLoading() async {
    var newData = await getEmployeeData();
    if (newData.isNotEmpty) {
      employeeNameListForCaptain.addAll(newData);
      tempEmployeeNameListForCaptain.addAll(newData);
      page++;
      notifyListeners();
    }
    refreshController.loadComplete();
  }

  Future<List<GetEmployeeNameResponse>> getEmployeeData() async {
    try {
      final response = await _apiService.getData('${ApiUrls.getEmployeeNameList}page=$page&pageSize=20');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        List<GetEmployeeNameResponse> employeeList =
            responseData.map((data) => GetEmployeeNameResponse.fromJson(data)).toList();
        return employeeList;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error: $error');
      return [];
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final double imageSizeInMB = File(image.path).lengthSync() / (1024 * 1024);
      if (imageSizeInMB <= 1.0 &&
          (image.path.toLowerCase().endsWith('.png') || image.path.toLowerCase().endsWith('.jpg'))) {
        pickedImage = File(image.path);
        notifyListeners();
      } else {
        // Show an error message if the image doesn't meet the requirements
        // (size below 1MB and extension is either PNG or JPG)
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid image. Please select a PNG or JPG image below 1MB.')));
        }
      }
    }
  }

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowMultiple: false, allowedExtensions: ['xlsx', 'xls']);
    if (result != null) {
      pickedExcelFile = result.files.first;
      notifyListeners();
    } else {
      debugPrint('User canceled the file picking.');
    }
  }

  getExtension() {
    final int lastDotIndex = pickedImage!.path.lastIndexOf('.');
    return lastDotIndex != -1 ? pickedImage!.path.substring(lastDotIndex) : '';
  }

  void removeImage() {
    pickedImage = null;
    notifyListeners();
  }

  void removeExcel() {
    pickedExcelFile = null;
    notifyListeners();
  }

  void notify(result) {
    pickedExcelFile = result;
    notifyListeners();
  }

  onLoadingForViceCaptain() async {
    var newData = await getEmployeeData();
    if (newData.isNotEmpty) {
      employeeNameListForViceCaptain.addAll(newData);
      tempEmployeeNameListForViceCaptain.addAll(newData);
      pageForViceCaptain++;
      notifyListeners();
    }
    refreshControllerForViceCaptain.loadComplete();
  }

  Future<List<GetEmployeeNameResponse>> getEmployeeDataForViceCaptain() async {
    try {
      final response =
          await _apiService.getData('${ApiUrls.getEmployeeNameList}page=$pageForViceCaptain&pageSize=20');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        List<GetEmployeeNameResponse> employeeList =
            responseData.map((data) => GetEmployeeNameResponse.fromJson(data)).toList();
        return employeeList;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error: $error');
      return [];
    }
  }

  onLoadingForSponsor() async {
    var newData = await getEmployeeDataForSponsor();
    if (newData.isNotEmpty) {
      employeeNameListForSponsor.addAll(newData);
      pageForSponsor++;
      notifyListeners();
    }
    refreshControllerForSponsor.loadComplete();
  }

  Future<List<GetEmployeeNameResponse>> getEmployeeDataForSponsor() async {
    try {
      final response =
          await _apiService.getData('${ApiUrls.getEmployeeNameList}page=$pageForSponsor&pageSize=20');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        List<GetEmployeeNameResponse> employeeList =
            responseData.map((data) => GetEmployeeNameResponse.fromJson(data)).toList();
        return employeeList;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error: $error');
      return [];
    }
  }

  void updateCaptain() {
    captainController.text = employeeNameListForCaptain[
                employeeNameListForCaptain.indexWhere((element) => element.employeeID == selectedCaptainId)]
            .employeeName ??
        "";
    notifyListeners();
    AppRouter.navigatePop();
  }

  void updateViceCaptain() {
    if (selectedViceCaptainId != 0) {
      viceCaptainController.text = employeeNameListForViceCaptain[employeeNameListForViceCaptain
                  .indexWhere((element) => element.employeeID == selectedViceCaptainId)]
              .employeeName ??
          "";
      notifyListeners();
    }
    AppRouter.navigatePop();
  }

  void updateSponsor() {
    sponsorController.text = employeeNameListForSponsor[
                employeeNameListForSponsor.indexWhere((element) => element.employeeID == selectedSponsorId)]
            .employeeName ??
        "";
    notifyListeners();
    AppRouter.navigatePop();
  }

  Future<void> createTeam() async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> staticData = {
        'TeamName': teamNameController.text,
        'CaptainId': selectedCaptainId,
        'ViceCaptainId': selectedViceCaptainId,
        'SponsorId': selectedSponsorId
      };
      debugPrint("'TeamLogo': ${pickedImage!.path}, 'excelFile': ${pickedExcelFile!.path!}");

      Map<String, String> filesMap = {'TeamLogo': pickedImage!.path, 'excelFile': pickedExcelFile!.path!};
      final response = await _apiService.postMultipartData(ApiUrls.createTeam, staticData, filesMap);
      isLoading = false;
      if (response.statusCode == 200) {
        createTeamResponse = response.data;
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
    }
    notifyListeners();
  }
}
