import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

import '../cubit/cubit.dart';

Widget mySeparator() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(context, article) {
  if(article['urlToImage']== null) {
    return const SizedBox();
  }else{
    return InkWell(
      onTap: (){
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 200.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(article['urlToImage']),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: SizedBox(
                height: 110.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article['title'],
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        article['publishedAt'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13.5,
                        ),
                      )
                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget articleBuilder(list,{isSearch = false}) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(context, list[index]),
    separatorBuilder: (context, index) => mySeparator(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch ? Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(
        Icons.search_rounded,
        size: 160.0,
        color: Colors.grey,
      ),
      Text(
        'Search for News',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      )
    ],
  ) :
  const Center(
    child: CircularProgressIndicator(),
  ),
);

Widget defaultSettingsButton(context,{
  required Function() function,
  required String buttonText,
  required displayWidth,
}) => Container(
  height: displayWidth  * .155,
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.blueAccent.withOpacity(.7),
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.1),
        blurRadius: 30,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: MaterialButton(
    onPressed: function,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.button,
            ),
          ),
          Icon(
            Icons.navigate_next_rounded,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          )
        ],
      ),
    ),
  ),
);

Widget defaultButton(context,{
  buttonWidth = double.infinity,
  buttonHeight = 40.0,
  buttonColor = Colors.blueAccent,
  bool isUpperCase= false,
  double radius = 10.0,
  required Function() function,
  required String buttonText,

}) => Container(
  width: buttonWidth,
  height: buttonHeight,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.1),
        blurRadius: 30,
        offset: const Offset(0, 10),
      ),
    ],
    color: buttonColor,
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
        isUpperCase ? buttonText.toUpperCase() : buttonText,
        style: Theme.of(context).textTheme.bodyText1
    ),
  ),
);

Widget defaultFormField(context,{
  required TextEditingController textEditingController,
  required TextInputType textInputType,
  required String? Function(String?) validate,
  bool isPassword = false,
  required String label,
  Function(String)? onChange,
  Function(String)? onSubmit,
  required IconData prefix,
  IconData? suffix,
  Function()? showPassword,
  Function()? onTap,
  bool isClickable= true,
})=> TextFormField(
  controller: textEditingController,
  keyboardType: textInputType,
  obscureText: isPassword,
  onChanged: onChange,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
  enabled: isClickable,
  validator: validate,
  style: TextStyle(
    color: AppCubit
        .get(context)
        .isDark ? Colors.white : Colors.black,
  ),
  decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: AppCubit
          .get(context)
          .isDark ? Colors.grey : Colors.black45,
    ),
    prefixIcon: Icon(
      prefix,
      color: AppCubit
          .get(context)
          .isDark ? Colors.grey : Colors.black45,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: showPassword,
      icon: Icon(
        suffix,
      ),
    ): null,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppCubit
            .get(context)
            .isDark ? Colors.white : Colors.black45,
      ),
    ),
    border: const OutlineInputBorder(),
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);