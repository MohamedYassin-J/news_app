import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
                centerTitle: true,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: defaultFormField(
                    context,
                    textEditingController: searchController,
                    textInputType: TextInputType.text,
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Search must not be empty!';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search_rounded,
                  ),
                ),
                Expanded(child: articleBuilder(list, isSearch: true)),
              ],
            ),
          );
        });
  }
}
