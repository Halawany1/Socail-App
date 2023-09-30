import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';

import '../shared/component/constants.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textController=TextEditingController();
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if(state is SuccessCreatePostDataState){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        String name = '';
        for (int i = 0; i < cubit.model!.name!.length; i++) {
          if (cubit.model!.name![i] != ' ') {
            name += cubit.model!.name![i];
          } else {
            break;
          }
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                            '${cubit.model!.image}'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cubit.model!.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Public',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 500,
                  child: TextFormField(
                    maxLines: null,
                    maxLength: 600,
                    controller: textController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is in your mind, ${name}?',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14)),
                  ),
                ),

                if(cubit.postImage!=null)
                  Stack(
                  children: [
                    Image.file(
                      cubit.postImage!,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          cubit.RemovePostImage();
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xFFDDDDDD),
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 20,
                          )
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cubit.GetPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconlyBroken.image,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'add photo',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '# tags',
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconlyBroken.arrow_left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Create Post',
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 22,
                      fontWeight: FontWeight.w600),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: state is! LoadingCreatePostDataState
                    ? TextButton(
                        onPressed: () {
                          var date = DateTime.now();
                          if(cubit.postImage==null) {
                            cubit.CreatePost(text: textController.text,
                                dateTime: date.toString());

                          }else{
                            cubit.CreatePostImage(text: textController.text,
                                dateTime: date.toString());
                          }
                          cubit.RemovePostImage();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(fontSize: 19, color: Theme.of(context).primaryColor),
                        ))
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
