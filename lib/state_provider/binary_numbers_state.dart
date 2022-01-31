import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinaryNumbersState extends StateNotifier<int> {
  BinaryNumbersState(): super(0);

  void add(int nums) {
    state = nums;
  }

  void changeBinary(int num) {
    // var inputNum = int.parse(decimalNumberController.text);
    var binaryNums = [];
    for (var i = 0; i < num; i++) {
      binaryNums[i] = num % 2;
      num = num ~/ 2;
      print (num);
      if (num == 1) break;
    }
    if (kDebugMode) {
      print (binaryNums);
    }

  }
}