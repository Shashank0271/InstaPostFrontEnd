import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../models/Post.dart';
import '../../../shared/ui_helper.dart';
import 'blogCardmodel.dart';

class BlogCard extends StatelessWidget {
  final Post currentPost;
  final bool canLike;
  const BlogCard(this.currentPost, {super.key, this.canLike = true});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceSmall,
                      Text(currentPost.title),
                      verticalSpaceTiny,
                      Text(currentPost.userName),
                    ],
                  ),
                  Row(
                    children: [
                      if (canLike)
                        IconButton(
                            onPressed: () {
                              model.toggleLikes(postId: currentPost.id);
                            },
                            icon: model.liked
                                ? const Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.red,
                                  )
                                : const Icon(FontAwesomeIcons.heart)),
                      IconButton(
                          onPressed: () {
                            model.sharePost(currentPost.id);
                          },
                          icon: const Icon(Icons.share)),
                    ],
                  )
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
