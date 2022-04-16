import 'package:flutter/material.dart';

import '../model/post.dart';
import 'descrption.dart';

class IndividualFeed extends StatefulWidget {
  final Post post;
  const IndividualFeed({Key? key, required this.post}) : super(key: key);

  @override
  State<IndividualFeed> createState() => _IndividualFeedState();
}

class _IndividualFeedState extends State<IndividualFeed> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DescriptiveFeed(post: widget.post),
          ),
        );
      },
      onDoubleTap: () {
        setState(() {
          isFavourite = !isFavourite;
        });
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        elevation: 5,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      color: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            avatar: Hero(
                              tag: widget.post.id,
                              child: const CircleAvatar(),
                            ),
                            label: Text(
                              widget.post.uid,
                            ),
                            labelStyle: const TextStyle(
                              fontFamily: 'Ubuntu',
                            ),
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                          ),
                          Chip(
                            avatar: const Icon(
                              Icons.visibility,
                            ),
                            label: Text(
                              '${widget.post.views}',
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                            },
                            color: isFavourite ? Colors.red : Colors.grey,
                            icon: const Icon(
                              Icons.favorite,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.post.title,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
