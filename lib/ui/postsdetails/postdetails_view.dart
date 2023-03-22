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
              SizedBox(
                height: screenHeightPercentage(context, percentage: 0.35),
                width: screenWidth(context),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                    currentPost.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              verticalSpaceSmall,
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    //we add this user to the currentPost.users followers
                    //we add the currentPost.user to this users following list
                    //this should happen after viewing the posts authers profile ,
                    //but now done directly for testing purposes
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey),
                    child: TextButton(
                        onPressed: () {
                          model.viewProfile(currentPost.userFirebaseId);
                        },
                        child: Text(currentPost.userName)),
                  ),
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
