import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';
import 'package:social_app/shared/component/shared_component.dart';

import '../shared/component/constants.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        nameController.text = cubit.model!.name!;
        bioController.text = cubit.model!.bio!;
        phoneController.text = cubit.model!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconlyBroken.arrow_left_2),
              onPressed: () {
                cubit.coverImage=null;
                cubit.profileImage=null;
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Edit Profile',
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 22,fontWeight: FontWeight.w600),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: state is! LoadingUpdateUserDataState?TextButton(
                    onPressed: () {
                      cubit.UpdateUserData(name: nameController.text,
                          bio: bioController.text,
                          cover: cubit.model!.cover!,
                          image: cubit.model!.image!,
                          phone: phoneController.text);
                      cubit.coverImage=null;
                      cubit.profileImage=null;
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 19, color: Theme.of(context).primaryColor),
                    )):Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: LoadingAnimationWidget.fourRotatingDots(
                  color: color,
                  size: 30,
                ),
                    ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            cubit.coverImage == null
                                ? Image.network(
                                    height: 220,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    '${cubit.model!.cover}')
                                : Image.file(
                                    cubit.coverImage!,
                                    height: 220,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                width: 40,
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDDDDDD),
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                    onPressed: () {
                                      cubit.GetCoverImage();
                                    },
                                    icon: Icon(
                                      IconlyBold.camera,
                                      color: Colors.black,
                                      size: 25,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: cubit.profileImage == null
                                    ? Image.network(
                                        width: 160,
                                        height: 160,
                                        fit: BoxFit.cover,
                                        '${cubit.model!.image}')
                                    : Image.file(
                                        width: 160,
                                        height: 160,
                                        fit: BoxFit.cover,
                                        cubit.profileImage!),
                              ),
                              Positioned(
                                bottom: 12,
                                right: 12,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Color(0xFFDDDDDD),
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.GetProfileImage();
                                    },
                                    icon: Icon(
                                      IconlyBold.camera,
                                      color: Colors.black,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row
                    (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Column(
                      children: [
                        if(cubit.profileImage!=null)
                          BuildButtom(text: 'Upload Profile',
                          onpress: (){
                            cubit.UploadProfileImage(
                                name: nameController.text,
                                bio: bioController.text,
                                phone: phoneController.text);
                            cubit.profileImage=null;
                          }, width:cubit.coverImage==null?380:180, textcolor: Colors.white,
                          height: 45,
                      elevation: 4),
                          SizedBox(height: 5,),

                        if(state is LoadingUploadProfileImageState)
                          Container(
                              width: cubit.coverImage==null?380:170,
                              child: LinearProgressIndicator(color: color))
                    ],),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        if(cubit.coverImage!=null)
                          BuildButtom(text: 'Upload Cover',
                            onpress: (){
                              cubit.UploadCoverImage(name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text);
                              cubit.coverImage=null;
                            }, width:cubit.profileImage==null?380:180, textcolor: Colors.white,
                            height: 45,
                            elevation: 4),
                          SizedBox(height: 5,),

                        if(state is LoadingUploadCoverImageState)
                          Container(
                              width: cubit.profileImage==null?380:170,
                              child: LinearProgressIndicator(color: color))
                      ],)
                  ],),
                  SizedBox(
                    height: 20,
                  ),
                  BuildTextFormField(
                    hintText: 'Name',
                    controller: nameController,
                    prefixIcon: IconlyBroken.user_2,
                    boarder: true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name must be found';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BuildTextFormField(
                    hintText: 'bio',
                    controller: bioController,
                    boarder: true,
                    prefixIcon: IconlyBold.info_circle,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name must be found';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BuildTextFormField(
                    hintText: 'phone',
                    controller: phoneController,
                    boarder: true,
                    prefixIcon: IconlyBold.call,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name must be found';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
