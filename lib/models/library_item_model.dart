class LibraryItem {
  final String id;
  final String title;
  final String type; // 'Lesson', '3D', 'Video'
  final DateTime dateSaved;

  LibraryItem(this.id, this.title, this.type, this.dateSaved);
}