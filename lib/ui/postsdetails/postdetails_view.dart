import 'package:flutter/material.dart';
import 'package:insta_post/ui/postsdetails/postdetails_viewmodel.dart';
import 'package:insta_post/ui/shared/ui_helper.dart';
import 'package:stacked/stacked.dart';

import '../../models/Post.dart';

class PostDetailsView extends StatelessWidget {
  final Post currentPost;

  const PostDetailsView(this.currentPost);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.network(
                  currentPost.imageUrl,
                ),
              ),
              verticalSpaceMedium,
              const Divider(
                color: Colors.grey,
              ),
              verticalSpaceMedium,
              Text(currentPost.body),
            ]),
          ),
        ),
      ),
      viewModelBuilder: () => PostDetailsViewModel(),
    );
  }
}
