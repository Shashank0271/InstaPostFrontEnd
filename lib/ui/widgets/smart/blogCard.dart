import 'package:flutter/material.dart';

import '../../../models/Post.dart';
import '../../shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'blogCardmodel.dart';

class BlogCard extends StatelessWidget {
  final Post currentPost;
  const BlogCard(this.currentPost);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BlogCardModel>.reactive(
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          model.navigateToDetailsPage(currentPost);
        },
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: screenHeightPercentage(context, percentage: 0.2),
                width: screenWidth(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(currentPost.imageUrl)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      verticalSpaceSmall,
                      Text(currentPost.title),
                      verticalSpaceTiny,
                      Text(currentPost.userName),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        model.sharePost(currentPost.id);
                      },
                      icon: const Icon(Icons.share))
                ],
              )
            ]),
          ),
        ),
      ),
      viewModelBuilder: () => BlogCardModel(),
    );
  }
}
