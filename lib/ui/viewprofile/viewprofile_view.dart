import 'package:flutter/material.dart';
import 'package:insta_post/ui/viewprofile/viewprofile_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../shared/ui_helper.dart';
import '../widgets/dumb/profileinforbar.dart';

// ignore: must_be_immutable
class ViewProfileView extends StatelessWidget {
  Map<String, dynamic> userInfo;
  ViewProfileView(this.userInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewProfileViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
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
                            data: 'username : ${userInfo['username']}'),
                        verticalSpaceMedium,
                        ProfileInfoBar(data: 'email : ${userInfo['email']}'),
                        verticalSpaceMedium,
                        ProfileInfoBar(
                            data:
                                'followers : ${userInfo['followers'].length}'),
                        verticalSpaceMedium,
                        ProfileInfoBar(
                            data:
                                'following : ${userInfo['following'].length}'),
                        verticalSpaceMedium,
                        ProfileInfoBar(
                            data: 'posts : ${userInfo['postCount']}'),
                        verticalSpaceMassive,
                        SizedBox(
                            width:
                                screenWidthPercentage(context, percentage: 0.5),
                            child: ElevatedButton(
                                onPressed: () {
                                  model.followUser(
                                      followedUserFid: userInfo['firebaseUid'],
                                      userName: userInfo['username']);
                                },
                                child: const Text('Follow')))
                      ]),
          ),
        ),
      ),
      viewModelBuilder: () => ViewProfileViewModel(),
    );
  }
}
