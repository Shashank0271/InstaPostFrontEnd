import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../shared/ui_helper.dart';
import 'createpost_viewmodel.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({Key? key}) : super(key: key);
//TODO : complete adding posts functionality

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: model.savePost,
            child: model.isBusy
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.black))
                : const Icon(Icons.post_add),
          ),
          appBar: AppBar(title: const Text('Create Post')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SingleChildScrollView(
              child: Column(children: [
                Stack(children: [
                  Card(
                    elevation: 9,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.grey,
                      ),
                      height: screenHeightPercentage(context, percentage: 0.25),
                      width: screenWidth(context),
                      child: model.selectedFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(model.selectedFile!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: model.talePicture,
                        child: const CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.camera,
                            size: 35,
                          ),
                        ),
                      ))
                ]),
                verticalSpaceLarge,
                TextField(
                  controller: model.titleController,
                  decoration: const InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      label: Text('Enter Title here')),
                ),
                verticalSpaceMedium,
                DropDownTextField(
                  onChanged: model.onChanged,
                  dropDownList: model.dropDownCategoryList,
                  dropDownItemCount: 3,
                  enableSearch: true,
                  textFieldDecoration: const InputDecoration(
                      hintText: 'Choose category',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                verticalSpaceLarge,
                SizedBox(
                  width: screenWidth(context),
                  child: TextField(
                    controller: model.bodyController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 8, 8, 8),
                      hintText: 'Start writing here.....',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    maxLines: 20,
                  ),
                ),
                verticalSpaceLarge,
              ]),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CreatePostViewModel(),
    );
  }
}
