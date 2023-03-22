// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/Post.dart';
import '../shared/ui_helper.dart';
import 'editpost_viewmodel.dart';

class EditPostView extends StatelessWidget {
  Post post;
  EditPostView(this.post, {super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditPostViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: model.updatePost,
            child: model.isBusy
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.black))
                : const Icon(Icons.done_outline_outlined),
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
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(post.imageUrl)),
                            ),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: model.takePicture,
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
                  initialValue: model.selectedCategory,
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
      onViewModelReady: (viewModel) => {viewModel.initValues(post)},
      viewModelBuilder: () => EditPostViewModel(),
    );
  }
}
