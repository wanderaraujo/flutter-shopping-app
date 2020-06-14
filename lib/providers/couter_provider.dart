import 'package:flutter/material.dart';

class CounterState {
  int _value = 1;

  void inc() => _value++;
  void dec() => _value--;

  int get value => _value;

  bool diff(CounterState old) {
    return old == null || old._value != _value;
  }
}

class CouterProvider extends InheritedWidget {

  final CounterState state = CounterState();

  CouterProvider({Widget child}) : super(child: child);

  static CouterProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<CouterProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
