
import 'dart:math';
import 'package:flutter/material.dart';

class Functionality {

  Functionality({@required this.height, @required this.weight});

  final int height;
  final int weight;

  double _ans=0;

  String getbmi() {
    _ans = weight / pow(height / 100, 2);

    return _ans.toStringAsFixed(1);
  }

  String getstatus() {
    if (_ans >= 25.0)
      return 'OVERWEIGHT';
    else if (_ans > 18.5)
      return 'NORMAL';
    else if (_ans > 0.0)
      return 'UNDERWEIGHT';
    else {
      return 'INVALID INPUT';
    }
  }

  String getstatement() {
    if (_ans >= 25.0)
      return 'EXERCISE SHURU KARDO BHAI, BEFORE ITS TOO LATE';
    else if (_ans > 18.5)
      return 'BADHAI HO!!! NORMAL WEIGHT HAI AAPKA LOCKDOWN KE BAAD BHI';
    else if (_ans > 0.0)
      return 'ITNI BHI EXERCISE YA DEITING NHI KRNI THI, SOOKH RAHE HAI AAP';
    else {
      return 'GAANDU, SAHI VALUES DAAL';
    }
  }


}


