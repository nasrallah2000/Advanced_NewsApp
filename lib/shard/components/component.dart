import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/webView/webViewScreen.dart';
import 'package:newsapp/shard/Cubit/cubit.dart';


Widget defaulteFormFelid({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  bool isClikable = true,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  required Function validate,
  required String lable,
  required IconData preIcon,
  IconData? suffix,
  Function? suffixPressed,
  context,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClikable,
  onChanged: (s){
    onChange!(s);
  },
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  validator: (s){
    validate(s);
  },
  onTap: (){
    onTap!();
  },
  style: TextStyle(
    color: NewsCubit.get(context).isDark? Colors.white:  Colors.black,
  ),
  decoration: InputDecoration(
    label: Text(lable),
    labelStyle: TextStyle(
      color:NewsCubit.get(context).isDark? Colors.white: Colors.black,
    ),
    prefixIcon: Icon(preIcon,color:NewsCubit.get(context).isDark? Colors.white: Colors.black),
    suffixIcon: suffix !=null ?IconButton(onPressed: (){suffixPressed!();}, icon: Icon(suffix,color:Colors.black,)):null,
    border:OutlineInputBorder(
      borderSide: BorderSide(
        color: NewsCubit.get(context).isDark? Colors.white: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color:NewsCubit.get(context).isDark? Colors.white:  Colors.black,
      ),
    ),

  ),
);

Widget bulidArticalItem(artical,context) =>
    InkWell(
      onTap: (){
        NavigateTo(context, webViewScreen(artical['url']));
      },
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: artical['urlToImage']== null ? const AssetImage('assets/images/news.jpg') as ImageProvider<Object> :  NetworkImage('${artical['urlToImage']}') ,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${artical['title']}",
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${artical['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
  ),
),
    );

Widget articalBulider (list,context,{isSearch=false}) =>
    ConditionalBuilder(
  condition: list.length >0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=> bulidArticalItem(list[index],context),
    separatorBuilder:(context,index)=> Padding(padding: const EdgeInsets.all(15.0),
      child: const Divider(),
    ),
    itemCount: list.length,
  ),
  fallback: (context) =>  isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

void NavigateTo(context ,widget) =>
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> widget)
        );