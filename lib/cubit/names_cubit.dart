import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bloc_practicing/constants/color_palitra.dart';
import 'package:bloc_practicing/constants/people.dart';
import 'package:bloc_practicing/extensions/random_element.dart';
import 'package:flutter/foundation.dart';

class NamesCubit extends Cubit<StateChanger?> {
  NamesCubit() : super(InitializeState());
  String? name = People.names.getRandomElement();
  Color? color = ColorPalitra.colorPalitra.getRandomColor();

  void pickTextAndChangeColor({String? chosenName}) {
    name = People.names.getRandomElement();
    color = ColorPalitra.colorPalitra.getRandomColor();
    if(chosenName != null) {
      name = chosenName;
    }
    emit(UpdatedStateChanger(name!, color!));
  }
}

abstract class StateChanger {}

class InitializeState extends StateChanger {}

class UpdatedStateChanger extends StateChanger {
  final String name;
  final Color newColor;

  UpdatedStateChanger(this.name, this.newColor);
}
