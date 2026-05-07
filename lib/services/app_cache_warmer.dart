import '../data/subject_library.dart';

class AppCacheWarmer {
  static void execute() {
    SubjectLibrary.getCategories(); // Forces static data into memory
    print("UI Cache Warmed Up.");
  }
}