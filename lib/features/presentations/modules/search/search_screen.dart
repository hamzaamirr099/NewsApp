import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/bloc/cubit.dart';
import '../../../../core/util/bloc/states.dart';
import '../../../../core/util/widgets/article_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        leading: IconButton(
          onPressed: () {
            cubit.searchData = [];
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
              onPressed: () {
                cubit.changeBrightnessMode(fromClick: true);
              },
              icon: cubit.currentBrightnessMode
                  ? const Icon(Icons.brightness_2_outlined)
                  : const Icon(Icons.wb_sunny_outlined)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              onFieldSubmitted: (String value) {
                print(value);
                cubit.getSearchData(value);
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),),
                filled: true,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: cubit.currentBrightnessMode ? Colors.green : Colors.white,
            height: 1.0,
          ),
          BlocConsumer<AppCubit, CubitStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: cubit.searchData.isNotEmpty,
                builder: (context) => Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ArticleItem(
                          articleData: cubit.searchData[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        color: cubit.currentBrightnessMode
                            ? Colors.green
                            : Colors.white,
                        height: 1.0,
                      );
                    },
                    itemCount: cubit.searchData.length,
                  ),
                ),
                fallback: (context) => const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(),
                    ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
