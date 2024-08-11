class PostModels {
  final String name;
  final String desc;
  final String fundType;
  final String amount;
  final String endDate;
  final String photoUrl;
  final String date;
  final String priority;
  final Map creatorInfo;
  final List upvote;
  final String id;
  const PostModels({
    required this.amount,
    required this.creatorInfo,
    required this.date,
    required this.desc,
    required this.endDate,
    required this.fundType,
    required this.name,
    required this.photoUrl,
    required this.priority,
    required this.upvote,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "fundName": name,
        "description": desc,
        "type": fundType,
        "date": date,
        "endDate": endDate,
        "priority": priority,
        "creatorInfo": creatorInfo,
        "upvote": upvote,
        "photoUrl": photoUrl,
        "amount": amount,
        "fundId": id,
      };
}
