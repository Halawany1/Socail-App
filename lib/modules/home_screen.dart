import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';

import '../shared/component/constants.dart';
import '../shared/component/shared_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
            appBar: AppBar(
              title: Text('${cubit.title[cubit.index]}', style: Theme
                  .of(context)
                  .
              textTheme
                  .bodyText2!
                  .copyWith(
                  fontSize: 27,
                  fontWeight: FontWeight.w600
              )),
              actions: [
                Icon(IconlyBroken.notification),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child:
                  IconButton(onPressed: () {
                    cubit.ChangeMode();
                  },
                      icon: Icon(
                    cubit.mode?Icons.light_mode:Icons.dark_mode,
                    color: Theme.of(context).iconTheme.color,)),
                )
              ],
            ),
            body: ConditionalBuilder(
              builder: (context) {
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Image.network(
                                    height: 220,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    'https://img.freepik.com/free-photo/pretty-young-afro-american-girl-looks-aside-with-toothy-smile-notices-pleasant-thing-has-carefree-expression-dressed-casual-jumper-poses-indoor-against-vivid-orange-wall_273609-47744.jpg?w=1060&t=st=1695299228~exp=1695299828~hmac=6cc24cb4da903a4dac2db6dd31e252b48cf94aacc19fe1f050dd78d67e263959'),
                                Positioned(
                                    bottom: 10,
                                    right: 5,
                                    child: Text(
                                      'Communicate with friends',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                    ))
                              ],
                            )),
                        ListView.builder(itemBuilder: (context, index) =>
                            buildCardPost(context, cubit, index),
                          itemCount: cubit.posts.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )
                      ],
                    )
                );
              },
              condition: cubit.posts.length > 0 && cubit.model != null,

              fallback: (context) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: SkeletonItem(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            shape: BoxShape.circle, width: 50,
                                            height: 50),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: SkeletonParagraph(
                                          style: SkeletonParagraphStyle(
                                              lines: 3,
                                              spacing: 6,
                                              lineStyle: SkeletonLineStyle(
                                                randomLength: true,
                                                height: 10,
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                                minLength: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 6,
                                                maxLength: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 3,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  SkeletonParagraph(
                                    style: SkeletonParagraphStyle(
                                        lines: 3,
                                        spacing: 6,
                                        lineStyle: SkeletonLineStyle(
                                          randomLength: true,
                                          height: 10,
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          minLength: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 2,
                                        )),
                                  ),
                                  SizedBox(height: 12),
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: double.infinity,
                                      minHeight: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 8,
                                      maxHeight: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 3,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                  width: 20,
                                                  height: 20)),
                                          SizedBox(width: 8),
                                          SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                  width: 20, height: 20)),
                                          SizedBox(width: 8),
                                          SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                  width: 20, height: 20)),
                                        ],
                                      ),
                                      SkeletonLine(
                                        style: SkeletonLineStyle(
                                            height: 16,
                                            width: 64,
                                            borderRadius: BorderRadius.circular(
                                                8)),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),
                );
              },
            ));
      },
    );
  }
}
