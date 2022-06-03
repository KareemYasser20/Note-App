class Note{
  final int id;
  final String title;
  final String body;
  final String creationDate;

  Note({this.id , this.title , this.body , this.creationDate});


  Map<String , dynamic> toMap(){
    return {
      'id': id,
      'title': title, 
      'body' : body,
      'creationDate' : creationDate,

    };
  }

}