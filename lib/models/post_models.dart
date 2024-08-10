class PostModels {
  final String name;
  final String desc;
  final String fundType;
  final String amount;
  final String upi;
  final String endDate;
  final String photoUrl;
  final List details;
  final String date;
  final String priority;
  final List creatorInfo;
  final int upvote;
  final String id;
  const PostModels({
    required this.amount,
    required this.creatorInfo,
    required this.date,
    required this.desc,
    required this.details,
    required this.endDate,
    required this.fundType,
    required this.name,
    required this.photoUrl,
    required this.priority,
    required this.upi,
    required this.upvote,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "fundName": name,
        "description": desc,
        "type": fundType,
        "date": date,
        "details": details,
        "endDate": endDate,
        "priority": priority,
        "creatorInfo": creatorInfo,
        "upvote": upvote,
        "photoUrl": photoUrl,
        "upi": upi,
        "amount": amount,
        "fundId": id,
      };
}
