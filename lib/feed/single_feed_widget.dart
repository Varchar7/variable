import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:variable/bloc/post/post_bloc.dart';
import 'package:variable/widget/alert_dailog.dart';
import 'package:variable/widget/style.dart';
import '../model/post.dart';
import 'feed_descrption.dart';

class IndividualFeed extends StatefulWidget {
  final Post post;
  final bool deleteOption;
  const IndividualFeed(
      {Key? key, required this.post, required this.deleteOption})
      : super(key: key);

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
            builder: (context) => DescriptiveFeed(
              post: widget.post,
            ),
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
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Hero(
                      tag: widget.post.title,
                      child: Container(
                        color: widget.post.images.isEmpty
                            ? Colors.greenAccent
                            : null,
                        decoration: widget.post.images.isEmpty
                            ? null
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.post.images,
                                      scale: 1),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.deleteOption
                            ? CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    showMyDailog(
                                      context,
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                      onSubmit: () {
                                        BlocProvider.of<PostBloc>(context).add(
                                          DeletePostEvent(
                                            postID: widget.post.id,
                                            haveImage:
                                                widget.post.images.isNotEmpty,
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      title: "Are you sure to remove this post",
                                    );
                                  },
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Chip(
                            avatar: const Icon(
                              Icons.light_mode,
                            ),
                            label: Text(
                              "${widget.post.importance}",
                              style: style(),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        textScaleFactor: 1.25,
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.post.body,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.25,
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          getMessageTime(widget.post.time.toDate()),
                          textAlign: TextAlign.end,
                          textScaleFactor: 0.75,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                          ),
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

  String getMessageTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MMM-yyyy h:m');
    return formatter.format(dateTime);
  }
}
