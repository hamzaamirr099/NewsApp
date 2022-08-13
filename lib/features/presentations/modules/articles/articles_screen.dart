import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/bloc/cubit.dart';
import 'package:news_app/core/util/bloc/states.dart';
import 'package:news_app/core/util/widgets/article_item.dart';

class ArticlesScreen extends StatelessWidget {

  final List<dynamic> articlesType;
  const ArticlesScreen({Key? key, required this.articlesType}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: articlesType.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ArticleItem(articleData: articlesType[index]);
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                color: cubit.currentBrightnessMode ? Colors.green : Colors.white,
                height: 1.0,
              );
            },
            itemCount: articlesType.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
