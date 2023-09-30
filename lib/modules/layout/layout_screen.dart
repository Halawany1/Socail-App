import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';
import 'package:social_app/modules/New_post_screen.dart';
import 'package:social_app/shared/component/shared_component.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      builder: (context, state) {
        var cubit=context.read<LayoutCubit>();
        return Scaffold(
          body: cubit.screen[cubit.index],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cubit.index,
            onTap: (value) {
              cubit.ChangeIndexNavBar(value);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(IconlyBroken.home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(IconlyBroken.chat),label: 'Chat'),
              BottomNavigationBarItem(icon:Icon(Icons.post_add),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(IconlyBroken.user_3),label: 'User'),
              BottomNavigationBarItem(icon:Icon(IconlyBroken.profile),label: 'Profile'),

            ],
          ),
        );
      },
      listener: (context, state) {
        if(state is NewPostState){
          Push(widget: NewPostScreen(), context: context);
        }
      },
    );
  }
}
