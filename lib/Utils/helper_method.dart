// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:market_place/Themes/app_colors_theme.dart';
// import 'package:market_place/Themes/app_text_theme.dart';
//
//
// void showLoader() {
//   FocusManager.instance.primaryFocus?.unfocus();
//   if (!(Get.isDialogOpen ?? false)) {
//     Get.dialog(
//       const Center(
//         child: CircularProgressIndicator(
//           color: AppColor.primaryColor,
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
// }
//
// void hideLoader({bool hideOverlay = false}) {
//   FocusManager.instance.primaryFocus?.unfocus();
//   if (Get.isDialogOpen ?? false) {
//     Get.back(closeOverlays: hideOverlay);
//   }
// }
//
// showSnackBarSuccess({required String message, double bottom = 90}) {
//   Get.snackbar("", "",
//       titleText: const SizedBox(),
//       messageText: Container(
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.only(bottom: 5),
//           child: Text(
//             message,
//             style: AppTextStyle.mediumText
//                 .copyWith(color: AppColor.whiteColor, fontSize: 14),
//           )),
//       backgroundColor: AppColor.greenColor,
//       snackPosition: SnackPosition.BOTTOM,
//       animationDuration: const Duration(milliseconds: 500),
//       barBlur: 0,
//       colorText: Colors.black,
//       padding: const EdgeInsets.all(10),
//       margin: EdgeInsets.only(bottom: bottom, left: 15, right: 15),
//       snackStyle: SnackStyle.FLOATING);
// }
//
// showSnackBarError({required String message, double bottom = 90}) {
//   Get.snackbar(
//     "",
//     "",
//     titleText: const SizedBox(),
//     messageText: Container(
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.only(bottom: 5),
//         child: Text(
//           message,
//           style: AppTextStyle.mediumText
//               .copyWith(color: AppColor.whiteColor, fontSize: 16),
//         )),
//     backgroundColor: AppColor.redColor,
//     snackPosition: SnackPosition.BOTTOM,
//     animationDuration: const Duration(milliseconds: 400),
//     barBlur: 0,
//     colorText: Colors.black,
//     padding: const EdgeInsets.all(10),
//     margin: EdgeInsets.only(bottom: bottom, left: 15, right: 15),
//   );
// }
//
// showSnackBarInfo({required String message, double bottom = 90}) {
//   Get.snackbar(
//     "",
//     "",
//     titleText: const SizedBox(),
//     messageText: Container(
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.only(bottom: 5),
//         child: Text(
//           message,
//           style: AppTextStyle.mediumText
//               .copyWith(color: AppColor.whiteColor, fontSize: 14),
//         )),
//     backgroundColor: AppColor.primaryColor,
//     snackPosition: SnackPosition.BOTTOM,
//     animationDuration: const Duration(milliseconds: 500),
//     barBlur: 0,
//     colorText: Colors.black,
//     padding: const EdgeInsets.all(10),
//     margin: EdgeInsets.only(bottom: bottom, left: 15, right: 15),
//   );
// }
//
// String parseJwt({required String token}) {
//   final parts = token.split('.');
//   if (parts.length != 3) {
//     throw Exception('invalid token');
//   }
//
//   final payload = _decodeBase64(parts[1]);
//   final payloadMap = json.decode(payload);
//   if (payloadMap is! Map<String, dynamic>) {
//     throw Exception('invalid payload');
//   }
//   String userId = payloadMap["data"]["user"]["id"] ?? "";
//   return userId;
// }
//
// String _decodeBase64(String str) {
//   String output = str.replaceAll('-', '+').replaceAll('_', '/');
//
//   switch (output.length % 4) {
//     case 0:
//       break;
//     case 2:
//       output += '==';
//       break;
//     case 3:
//       output += '=';
//       break;
//     default:
//       throw Exception('Illegal base64url string!"');
//   }
//
//   return utf8.decode(base64Url.decode(output));
// }
//
// String convertTo12HourFormat(String time24Hour) {
//   final time = TimeOfDay(
//     hour: int.parse(time24Hour.split(':')[0]),
//     minute: int.parse(time24Hour.split(':')[1]),
//   );
//
//   final formattedTime = DateFormat.jm().format(
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
//         time.hour, time.minute),
//   );
//
//   return formattedTime;
// }
//
// String changeDateStringFormat({required String date, required String format}) {
//   String dateString = date;
//   DateTime dateTime = DateTime.parse(dateString);
//   String formattedDate = DateFormat(format).format(dateTime);
//   return formattedDate;
// }
