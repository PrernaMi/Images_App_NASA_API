import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_images/providers/theme_provider.dart';
import 'package:mars_images/widget_const/app_const.dart';

class SearchFlight extends StatelessWidget {
  bool? isLight;
  MediaQueryData? mqData;

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: (){
              Navigator.pop(context);
            },
            child: CircleAvatar(
              child: Center(child: Icon(Icons.arrow_back_ios_new_outlined)),
            ),
          ),
        ),
        actions: [
          Switch.adaptive(
              value: context.watch<ThemeProvider>().getTheme(),
              onChanged: (value) {
                context.read<ThemeProvider>().changeTheme(isDark: value);
              })
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mqData!.size.height*0.07,),
            Text("Search Flights To Mars",style: TextStyle(
              fontFamily: 'Dark',
              fontSize: 30
            ),),
            SizedBox(height: 20,),
            mRow(mList: ["Origin","Destination"]),
            SizedBox(height: 15,),
            Text("Launch Station",style: AppConst.mTextStyle13(color: Colors.grey),),
            SizedBox(height: 15,),
            Container(
              height: mqData!.size.height*0.07,
              width: mqData!.size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Icon(Icons.rocket_launch_sharp,color: Colors.black,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: Colors.black))
                    ),
                  ),
                  Text("New Jersey, SpaceX Launch Pad",style: AppConst.mTextStyleBold(),)
                ],
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mColumn(text: "Spacecraft Class", iconString: "", iconName: "Vip Clean"),
                mColumn(text: "Departure Date", iconString: "", iconName: "2021/07/26"),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Text("Search Flight"),
              ],
            ))
          ],
        ),
      ),
    );
  }
  
  Widget mColumn({required String text,required String iconString,required String iconName}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: AppConst.mTextStyle13(color: Colors.grey),),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          height: mqData!.size.height*0.07,
          width: mqData!.size.width*0.44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100
          ),
          child: Row(
            children: [
              Icon(Icons.location_on,color: Colors.black),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.black))
                ),
              ),
              SizedBox(width: 3,),
              iconString != "" ? Image.asset(iconString,height: 35,):Text(""),
              SizedBox(width: 5,),
              Flexible(child: Text(iconName,style: AppConst.mTextStyleBold(color: Colors.black),)),
              SizedBox(width: 3,),
              Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
            ],
          ),
        )
      ],
    );
  }

  Widget mRow({required List<String> mList}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        mColumn(text: mList[0],iconString: "assets/icons/earth.png",iconName: "Earth"),
        mColumn(text: mList[1],iconString: "assets/icons/mars.png",iconName: "Mars")
      ],
    );
  }
}
