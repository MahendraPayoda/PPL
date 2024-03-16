import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:payoda/model/common_response.dart';
import 'package:payoda/model/engagement_type_response.dart';
import 'package:payoda/model/engagement_upload_response.dart';
import 'package:payoda/service/api_service.dart';
import 'package:payoda/service/api_urls.dart';
import 'package:payoda/utills/snackbar_manager.dart';

class CreateEngagementProvider extends ChangeNotifier {
  final _apiService = ApiService();
  List<EngagementTypeResponse> engagementTypeResponse = [];
  bool sendNotificationCheckValue = false;
  EngagementUploadResponse? engagementUploadResponse;
  bool isLoading = false;
  PlatformFile? pickedExcelFile;
  final engagementTypeController = TextEditingController();
  final engagementNameController = TextEditingController();
  final engagementPplPointController = TextEditingController();
  final engagementEventPointController = TextEditingController();
  final engagementWinnerController = TextEditingController();
  final engagementRunnerController = TextEditingController();
  final engagementParticipantsController = TextEditingController();
  final engagementDateTimeController = TextEditingController();
  final engagementVenueController = TextEditingController();
  final engagementRegistrationCloseOnController = TextEditingController();
  final engagementPresenterController = TextEditingController();

  EngagementTypeResponse? selectedEngagementType;

  updateNotificationCheckValue(bool? val) {
    sendNotificationCheckValue = val!;
    notifyListeners();
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  Future<void> pickExcelFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowMultiple: false, allowedExtensions: ['xlsx', 'xls']);
    if (result != null) {
      pickedExcelFile = result.files.first;
      uploadEngagement(context);
      notifyListeners();
    } else {
      debugPrint('User canceled the file picking.');
    }
  }

  Future<void> getEngagementType() async {
    try {
      final response = await _apiService.getData(ApiUrls.engagementType);
      isLoading = false;
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data; // response.data is a List<dynamic>
        engagementTypeResponse = responseData.map((json) => EngagementTypeResponse.fromJson(json)).toList();
      }
    } catch (e) {
      isLoading = false;
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> createEngagement(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> jsonData = {
        "WinnerPoints": engagementWinnerController.text,
        "ParticipationPoints": engagementParticipantsController.text,
        "EventName": engagementNameController.text,
        "Presenter": engagementPresenterController.text,
        // "QRCodeFile": "", // Assign this value as needed
        "PPLPoints": engagementPplPointController.text,
        "Venue": engagementVenueController.text,
        "RunnerPoints": engagementRunnerController.text,
        "RegistrationClosesOn": engagementRegistrationCloseOnController.text,
        // "UploadEventFile": "", // Assign this value as needed
        "EngagementType": engagementTypeController.text,
        "DateTime": engagementDateTimeController.text,
        "EventPoints": engagementEventPointController.text
      };

      final response = await _apiService.postData(ApiUrls.createEngagement, jsonData);
      isLoading = false;
      if (response.statusCode == 200) {
        final commonResponse = CommonResponse.fromJson(response.data);
      }
    } catch (e) {
      isLoading = false;
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> uploadEngagement(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      var dio = Dio();
      var data = FormData.fromMap({
        'excelFile': [await MultipartFile.fromFile(pickedExcelFile!.path!, filename: pickedExcelFile!.name)]
      });
      var response =
          await dio.request(ApiUrls.engagementUpload, options: Options(method: 'POST'), data: data);
      isLoading = false;
      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        engagementUploadResponse = EngagementUploadResponse.fromJson(response.data);
        debugPrint('engagementUploadResponse --- ${engagementUploadResponse!.toJson()}');

        if (engagementUploadResponse!.success ?? false) {
          final data = engagementUploadResponse!.engagements!.first;
          engagementTypeController.text = data.engagementType ?? '';
          engagementNameController.text = data.eventName ?? '';
          engagementPplPointController.text = (data.pplPoints ?? '').toString();
          engagementWinnerController.text = (data.winnerPoints ?? '').toString();
          engagementRunnerController.text = (data.runnerPoints ?? '').toString();
          engagementParticipantsController.text = (data.participationPoints ?? '').toString();
          engagementDateTimeController.text = (data.dateTime ?? '').toString();
          engagementVenueController.text = data.venue ?? '';
          engagementRegistrationCloseOnController.text = data.registrationClosesOn ?? '';
          engagementPresenterController.text = data.presenter ?? '';
          engagementEventPointController.text = (data.eventPoints ?? '').toString();
        }
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      isLoading = false;
      debugPrint('Error: $e');
      if (e is DioException) {
        if (context.mounted) {
          SnackbarManager.showErrorSnackbar(message: e.response?.data['message'] ?? '', context: context);
        }
      }
    }
    notifyListeners();
  }

  void removeExcel() {
    pickedExcelFile = null;
    engagementTypeController.clear();
    engagementNameController.clear();
    engagementPplPointController.clear();
    engagementWinnerController.clear();
    engagementRunnerController.clear();
    engagementParticipantsController.clear();
    engagementDateTimeController.clear();
    engagementVenueController.clear();
    engagementRegistrationCloseOnController.clear();
    engagementPresenterController.clear();
    engagementEventPointController.clear();
    selectedEngagementType = null;
    notifyListeners();
  }

  String getSizeInKb(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    double kb = sizeInMb * 1024;
    return kb.toStringAsFixed(2);
  }
}
