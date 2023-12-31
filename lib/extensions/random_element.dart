import 'dart:math' as math;

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length),);

  T getRandomColor() => elementAt(math.Random().nextInt(length),);
}