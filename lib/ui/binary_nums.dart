import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _decimalNumberControllerProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final _decimalNumberProvider = StateProvider.autoDispose<String>((ref) => "0");
final _binaryNumberProvider = StateProvider.autoDispose<String>((ref) => "0");

final _isLoggingProvider = StateProvider.autoDispose<bool>((ref) => false);
final _binaryNumbersState = StateProvider.autoDispose<bool>((ref) => false);

final _canPushButtonProvider = Provider.autoDispose<bool>((ref) {
  final decimalNumberValue = ref.watch(_decimalNumberProvider);
  return decimalNumberValue.isNotEmpty;
});

class BinaryNums extends ConsumerWidget {
  const BinaryNums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decimalNumberController = ref.watch(_decimalNumberControllerProvider);
    final decimalNumberProvider = ref.watch(_decimalNumberProvider.notifier);
    final binaryNumberProvider = ref.watch(_binaryNumberProvider.notifier);
    final canPushButton = ref.watch(_canPushButtonProvider);
    final isLoggingNotifier = ref.watch(_isLoggingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('binary nums app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              child: Text('仮置き'),
            ),
            TextFormField(
              controller: decimalNumberController,
              keyboardType: TextInputType.number,
              enabled: true,
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              onChanged: (v) {
                if (decimalNumberController.text == '') return;
                try {
                  var inputNum = int.parse(decimalNumberController.text);
                  List<int?> binaryNums = [];

                  while (inputNum ~/ 2 != 0) {
                    binaryNums.add(inputNum % 2);
                    inputNum = inputNum ~/ 2;
                  }
                  binaryNums.add(1);
                  print(binaryNums);
                  var reversedList = List.from(binaryNums.reversed);
                  String binaryNumText = '';
                  for (var v in reversedList) {
                    binaryNumText = "$binaryNumText$v";
                  }
                  binaryNumberProvider.state = binaryNumText;
                } catch (e) {
                  print(e);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              // child: Text(binaryNumberProvider.state),
              // child: Text(ref.watch(_binaryNumberProvider)),
              child: Text(binaryNumberProvider.state),
            )
          ],
        ),
      ),
    );
  }
}
