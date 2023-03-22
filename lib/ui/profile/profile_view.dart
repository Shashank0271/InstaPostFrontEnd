import 'package:flutter/material.dart';
import 'package:insta_post/ui/profile/profile_viewmodel.dart';
import 'package:insta_post/ui/shared/ui_helper.dart';
import 'package:insta_post/ui/widgets/dumb/profileinforbar.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Center(
          child: model.isBusy
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      ProfileInfoBar(
                          data: 'username : ${model.currentUser.username}'),
                      verticalSpaceMedium,
                      ProfileInfoBar(
                          data: 'email : ${model.currentUser.email}'),
                      verticalSpaceMedium,
                      ProfileInfoBar(
                          data:
                              'followers : ${model.currentUser.followers.length}'),
                      verticalSpaceMedium,
                      ProfileInfoBar(
                          data:
                              'following : ${model.currentUser.following.length}'),
                      verticalSpaceMedium,
                      ProfileInfoBar(
                          data: 'my posts : ${model.currentUser.postCount}'),
                    ]),
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
