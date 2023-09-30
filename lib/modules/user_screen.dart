import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../bloc/cubitLayout/layout_cubit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      builder: (context, state) {
        var cubit=context.read<LayoutCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('${cubit.title[cubit.index]}',style: Theme.of(context)
                .textTheme.bodyText2!.copyWith(
              fontSize: 27,
                fontWeight: FontWeight.w600
            ),),
          ),
          body: Center(child: Text('User')),
        );
      },
      listener: (context, state) {

      },

    );
  }
}
