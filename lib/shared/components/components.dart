import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget defaultInputField({
  @required context,
  @required String title,
  @required IconData preIcon,
  @required TextEditingController controller,
  @required TextInputType type,
  Function onTap,
  bool readOnly = false,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(10) ),
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          validator: (String value) {
            if (value.isEmpty) return '$title can not be empty';
            return null;
          },
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
          readOnly: readOnly,
          cursorColor:Colors.amber[700],
          cursorHeight: 20,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
            suffixIcon: Icon(preIcon, color: Colors.amber[700]),
            hintText: title,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onTap: onTap,
        ),
      ),
    );

Widget taskItem({
  Map item,
  background,
  context,
  bool inTrash = false,
}) => Dismissible(
  key: Key(item['id'].toString()),
  onDismissed: (direction){
    if(inTrash)
      AppCubit.get(context).updateData(
        status: 'new',
        id: item['id'],
      );
    else
      AppCubit.get(context).updateData(
        status: 'trash',
        id: item['id'],
      );
  },

  background: inTrash
      ? Icon(
          Icons.restore,
          color: Colors.green[700],
          size: 50,
        )
      : Icon(
          Icons.delete_outline,
          color: Colors.red[700],
          size: 50,
        ),
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: HexColor(item['color']),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          child: Row(
            children: [
              Spacer(),
              if(AppCubit.get(context).currentIndex != 1 && !inTrash)
                InkWell(
                  child: Icon(
                    Icons.archive_outlined,
                    size: 20,
                  ),
                  onTap: (){
                    AppCubit.get(context).updateData(
                      status: 'archived',
                      id: item['id'],
                    );
                  },
                ),
              if(AppCubit.get(context).currentIndex != 0 && !inTrash)
                InkWell(
                  child: Icon(Icons.list, size: 20),
                  onTap: (){
                    AppCubit.get(context).updateData(
                      status: 'new',
                      id: item['id'],
                    );
                  },
                ),
              SizedBox(width: 8,),
              InkWell(
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context)=> AlertDialog(
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.grey[800]
                            : Colors.white,
                        title: Text(
                          'Are you sure ?',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        content: Text(
                          'you want to delete this task permanently',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: (){
                              AppCubit.get(context).deleteData(id: item['id']);
                              Navigator.pop(context);
                              },
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontFamily: 'Glory',
                              ),
                            ),
                          ),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                                },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: 'Glory',
                                ),
                              ),
                            ),
                          ],
                        ),
                    );
                  },
              ),
            ],
          ),
        ),
        Text(
            item['title'],
            style: TextStyle(
              fontFamily: 'Glory',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              decoration: inTrash
                  ? TextDecoration.lineThrough
                  : null,
            ),
        ),
        SizedBox(height: 5,),
        Text(
          item['body'],
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Glory'
          ),
        ),
        SizedBox(height: 10,),
        Center(
          child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item['date']}  |  ',),
                Text(
                  item['time'],
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.black),
            ),
          ),
        )
      ],
    ),
  ),
);

Widget taskListBuilder({List<Map> tasks, bool inTrash = false}) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (index)=> StaggeredTile.fit(1),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: BouncingScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index)=> taskItem(
              item: tasks[index],
              context: context,
              inTrash: inTrash,
              ),
        ),
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              inTrash ?
                Icons.delete_outline_rounded : Icons.lightbulb_outline_rounded,
                size: 140,
                color: Colors.amber[700]),
            SizedBox(height: 10,),
            Text(
                inTrash? 'Trash is empty ..':'No tasks yet, add new tasks please ..',
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14)
            ),
          ],
        ),
      ),
    );

Widget homeTaskItem({context, Map item,}) => Container(
  padding: EdgeInsets.all(10),
  width: 290,
  decoration: BoxDecoration(
    color: HexColor(item['color']).withOpacity(.3),
    border: Border(
      left: BorderSide(
        color: HexColor(item['color']),
        width: 5,
      ),
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              item['title'],
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){},
            child: Icon(Icons.more_horiz, size: 22, color: Colors.grey,),
          ),
        ],
      ),
      SizedBox(height: 5,),
      Expanded(
        child: Text(
          item['body'],
          style: TextStyle(
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(height: 8,),
      Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
      SizedBox(height: 8,),
      Row(
        children: [
          Container(
            width: 120,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                'IN PROGRESS',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Spacer(),
          Icon(Icons.access_time, size: 18,),
          SizedBox(width: 5,),
          Text(
            item['time'],
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ],
  ),
);

Widget homeTaskListBuilder({@required List<Map> tasks}) => ListView.separated(
  scrollDirection: Axis.horizontal,
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => homeTaskItem(item: tasks[index]),
  separatorBuilder: (context, index) => SizedBox(width: 10,),
  itemCount: tasks.length,
);

Widget drawerMainItem({
  @required context,
  @required Function onTap,
  @required IconData icon,
  @required String label,
  bool isSelected = false,
}) => InkWell(
  onTap: onTap,
  child: Container(
    margin: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 3,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 7,
    ),
    decoration: BoxDecoration(
      color: isSelected
          ? Colors.blue.withOpacity(.2)
          : Colors.white.withOpacity(0),
      border: Border(
        left: BorderSide(
          color: isSelected
              ? Colors.blue
              : Colors.white.withOpacity(0),
          width: 2,
        ),
      ),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: isSelected
              ? Colors.blue
              : Colors.grey[700],
        ),
        SizedBox(width: 10,),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: AppCubit.get(context).isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    ),
  ),
);

Widget drawerItem({
  @required context,
  @required Function onTap,
  @required IconData icon,
  @required String label,
}) => InkWell(
  onTap: onTap,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    child: Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: Colors.grey[700],
        ),
        SizedBox(width: 10,),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: AppCubit.get(context).isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.only(
    top: 5,
    left: 25,
    bottom: 5,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
);
