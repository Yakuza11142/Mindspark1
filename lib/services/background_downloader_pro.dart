import 'dart:math';

class CbtShuffleSettings {
  // Global seed for synchronized exams (same seed = same order for all students)
  static int? globalSeed;
  
  static Random get random => globalSeed != null 
      ? Random(globalSeed!) 
      : Random();
}

class CbtShufflerEngine {
  /// Global shuffle: Works for any data type <T> (Strings, Widgets, Models, etc.)
  static List<T> shuffle<T>(List<T> items) {
    List<T> list = List.from(items);
    final _rnd = CbtShuffleSettings.random;

    for (int i = list.length - 1; i > 0; i--) {
      int j = _rnd.nextInt(i + 1);
      T temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
    return list;
  }

  /// Global tracking: Finds the new index of the original item in any list type
  static int locateItem<T>(List<T> shuffledList, T targetItem) {
    return shuffledList.indexOf(targetItem);
  }
}
