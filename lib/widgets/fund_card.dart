import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/text_styles.dart';

class FundCard extends StatelessWidget {
  final snap;
  const FundCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryBackgroundW,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12)
                .copyWith(right: 0),
            child: Row(
              children: [
                text(snap['fundName'], Colors.black, 20),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 16),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          text('Details :- ${snap['description']}', Colors.black, 16),
          text('Needed Amount :- ${snap['amount']}', Colors.black, 16),
          text('upi :- ${snap['upi']}', Colors.black, 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              (snap['photoUrl'] == '')
                  ? 'https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg'
                  : snap['photoUrl'],
              fit: BoxFit.cover,
            ),
          ),
          //upvote & comment join section------
          Row(
            children: [
              IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.insert_comment_rounded,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.currency_rupee_rounded),
              ),
              //to join a group or chat
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_outlined),
                  ),
                ),
              )
            ],
          ),

          //descriprion section--------
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w800),
                      child: Text(
                        '${snap['upvote']} votes',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'anshu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' commented hey this is description of fund',
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: const Text(
                          'View all 100 comments',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 119, 117, 117),
                          ),
                        ),
                      ),
                      onTap: () {}),
                  SizedBox(
                    child: Text(
                      '${snap['date']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
