// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sumari_locker_app/models/shipping_box.dart';
// import 'package:sumari_locker_app/util/printer_service.dart';
// import 'package:sumari_locker_app/view_models/permission_controller.dart';
// import 'package:sumari_locker_app/views/common/simple_indicator.dart';
// import 'package:sumari_locker_app/views/common/custom_scaffold.dart';
// import 'package:sumari_locker_app/views/common/custom_snackbar.dart';
// import 'package:sumari_locker_app/views/common/custom_theme.dart';
// import 'package:sumari_locker_app/view_models/auth_controller.dart';
// import 'package:sumari_locker_app/view_models/logibase_notifier.dart';
//
// import '../common/logibase_selector.dart';
// import 'package:sumari_locker_app/konst.dart';
//
// final _loginIdControllerProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });
//
// final _loginIdProvider = StateProvider.autoDispose<String>((ref) => "");
// final _isLoggingProvider = StateProvider.autoDispose<bool>((ref) => false);
//
// final _canPushButtonProvider = Provider.autoDispose<bool>((ref) {
//   final loginIdValue = ref.watch(_loginIdProvider);
//   final selectedLogibase = ref.watch(selectedLogibaseProvider);
//   return loginIdValue.isNotEmpty && selectedLogibase != null;
// });
//
// class LoginPage extends ConsumerWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final loginIdController = ref.watch(_loginIdControllerProvider);
//     final loginIdValueNotifier = ref.watch(_loginIdProvider.notifier);
//     final canPushButton = ref.watch(_canPushButtonProvider);
//     final selectedLogibase = ref.watch(selectedLogibaseProvider);
//     final auth = ref.watch(authProvider.notifier);
//     final isLoggingNotifier = ref.watch(_isLoggingProvider.notifier);
//     final isLogging = ref.watch(_isLoggingProvider);
//     final _ = ref.watch(permissionProvider);
//
//     //TextFormFieldが変更されても、rebuildが起きないので、リスナーを加え、変更を検知する。
//     loginIdController.removeListener(() {});
//     loginIdController.addListener(() {
//       loginIdValueNotifier.state = loginIdController.text;
//     });
//
//     if (isLogging) {
//       return const SimpleIndicator();
//     }
//
//     return CustomScaffold(
//         body: Container(
//           margin: const EdgeInsets.only(top: 100),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const SizedBox(
//                     child: Text('ログインID'),
//                     width: 100.0,
//                   ),
//                   const SizedBox(
//                     width: 20.0,
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       controller: loginIdController,
//                       keyboardType: TextInputType.number,
//                       enabled: true,
//                       style: const TextStyle(color: Colors.black),
//                       obscureText: false,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: const [
//                   SizedBox(
//                     child: Text('配送拠点'),
//                     width: 100.0,
//                   ),
//                   SizedBox(
//                     width: 20.0,
//                   ),
//                   Expanded(child: LogibaseSelector()),
//                 ],
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ElevatedButton(
//                   onPressed: !canPushButton
//                       ? null
//                       : () async {
//                     isLoggingNotifier.state = true;
//                     final code = loginIdController.text;
//                     if (selectedLogibase == null) {
//                       return;
//                     }
//                     try {
//                       await auth.login(code, selectedLogibase);
//                       loginIdController.text = '';
//                       Navigator.of(context).pushNamed("/menu");
//                     } on DioError {
//                       CustomSnackBar.showError(context, "ログインに失敗しました");
//                     } catch (e) {
//                       CustomSnackBar.showError(context, "通信に失敗しました");
//                     } finally {
//                       isLoggingNotifier.state = false;
//                     }
//                   },
//                   style: CustomTheme.elevatedButtonStyle,
//                   child: const Text('スタート')),
//               const SizedBox(
//                 height: 20,
//               ),
//               Visibility(
//                   visible: devMode,
//                   child: TextButton(
//                       onPressed: () async {
//                         var box = ShippingBox(
//                             checkedReturnBoxId: 1,
//                             returnBoxId: 1,
//                             statusId: 1,
//                             no: "SM123455600000000",
//                             serviceTrcNo: "00000000000001",
//                             optionalServiceNo: "9840989189419840",
//                             storeName: "テスト店舗",
//                             nbCopies: 0,
//                             storedAt: DateTime.now(),
//                             storePrefecture: "東京都",
//                             storeCity: "大田区",
//                             storeAddress: "北千束",
//                             storeAddressExt: "ヒルサイドテラス",
//                             storeAddressNo: "1111-111",
//                             serviceName: "エアークローゼット",
//                             storeLockerCode: "BSM-001-001-1344",
//                             storeLockerName: "A-11",
//                             lockerKey: "1111");
//                         await PrinterService().printLabels([
//                           box,
//                           box.copyWith(
//                               no: "1230340",
//                               serviceName: "ロコンド",
//                               optionalServiceNo: null)
//                         ]);
//                       },
//                       child: const Text(
//                         'テストプリント',
//                         style: TextStyle(
//                             color: Colors.blueGrey,
//                             fontSize: 10,
//                             fontWeight: FontWeight.normal),
//                       )))
//             ],
//           ),
//         ));
//   }
// }