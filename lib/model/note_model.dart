class NoteModel{
  final String id;
  final String note;
  final String title;

  NoteModel({
    this.id,
    this.note,
    this.title,
  });

  Map<String, dynamic> toMap() => {
      "id":id ,
      "note":note,
      "title": title,
  };
}