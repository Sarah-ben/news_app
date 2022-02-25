import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view/webview_screen.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
Widget defaultButton({
 double width=double.infinity,
 Color background=Colors.blue,
 @required  function,
  @required  text,
  bool iconText=false,
 required IconData icon,
})=> Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed:function,
  child:iconText==false? Text(text):Icon(icon),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  obsText=false,
  required TextInputType inputType,
  onSubmit,
  onChange,
  required  validator,
  required String label,
  required IconData icon,
  suffix,
  bool isClickable=true,
  onTap
})=>TextFormField(
  controller:controller ,
    keyboardType: inputType,
    obscureText:obsText ,
    onFieldSubmitted: onSubmit,
    onChanged:onChange ,
    onTap: onTap,
    validator:(val){
      if (val!.isEmpty) return 'field empty';
      return null;
    },
  decoration:  InputDecoration(
    filled: true,
    labelText:label ,
    prefixIcon: Icon(icon),
    suffix: suffix!=null?Icon(suffix):null,
    border:const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    )
  ),
  enabled: isClickable,
    );

 Widget defaultItem(Map task){
   return Row(
     children: [
       Padding(
         padding: const EdgeInsets.all(2.0),
         child: CircleAvatar(
           radius: 40.0,
           child: Text('${task['TIME']}'),
         ),
       ),
       const SizedBox(width: 5.0,),
       Expanded(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Text('${task['DATE']}'),
             SizedBox(height: 5.0,),
             Text('${task['TITLE']}')
           ],
         ),
       ),
       const SizedBox(width: 5.0,),
       IconButton(onPressed: (){}, icon:const Icon(Icons.check_box)),
       const SizedBox(width: 5.0,),
       IconButton(onPressed: (){}, icon:const Icon(Icons.archive)),
   const SizedBox(width: 5.0,),
   IconButton(onPressed: (){}, icon:const Icon(Icons.delete)),

     ],
   );
 }

 Widget buildArticleItem(dynamic article,BuildContext context)=>InkWell(
   onTap: (){
     navigateTo(context, WebViewScreen(article['url']));
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
                 image: NetworkImage('${article['urlToImage']}'),
                 fit: BoxFit.cover
             ),
           ),
         ),
         const SizedBox(width: 20.0,),
         Expanded(child:Container(
           height: 120.0,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: Text('${article['title']}',style:NewsCubit.get(context).isDark?const TextStyle(
                     fontSize: 18.0,
                     fontWeight: FontWeight.w600,
                     color: Colors.white
                 ):const TextStyle(
                     fontSize: 18.0,
                     fontWeight: FontWeight.w600,
                     color: Colors.black
                 ),maxLines: 4,overflow: TextOverflow.ellipsis,),
               ),
               Text('${article['publishedAt']}',style:const TextStyle(
                   color: Colors.grey),),
             ],
           ),
         ))
       ],
     ),
   ),
 );

void navigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));


