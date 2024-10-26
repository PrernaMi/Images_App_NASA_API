import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_images/bloc/mars_bloc.dart';
import 'package:mars_images/bloc/mars_events.dart';
import 'package:mars_images/bloc/mars_states.dart';
import 'package:mars_images/screens/search_flight.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool? isLight;
  bool isFinished = false;
  MediaQueryData? mqData;

  @override
  void initState() {
    context.read<MarsBloc>().add(GetImages());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    mqData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: isLight! ? Colors.white : Colors.black,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: mqData!.size.height * 0.02,
          ),
          Image.asset("assets/icons/space-travel.png",
              height: 50,
              fit: BoxFit.cover,
              color: themeColor(isLight: isLight!)),
          SizedBox(height: 7),
          // SizedBox(height: mqData!.size.height*0.03,),
          /*-------------Space Travel Font-----*/
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Space ",
                  style: TextStyle(
                      fontSize: 25,
                      color: themeColor(isLight: isLight!),
                      fontFamily: 'Light')),
              TextSpan(
                  text: "Travel",
                  style: TextStyle(
                      fontSize: 25,
                      color: themeColor(isLight: isLight!),
                      fontFamily: 'Dark'))
            ]),
          ),
          SizedBox(height: 5),
          Text("Trip To Mars"),
          SizedBox(height: mqData!.size.height * 0.01),
          /*--------Images ListView-----------*/
          SizedBox(
            height: mqData!.size.height * 0.47,
            width: mqData!.size.width,
            child: BlocBuilder<MarsBloc,MarsState>(
              builder: (context,state) {
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                if(state is ErrorState){
                  return Text(state.erroMsg);
                }
                if(state is LoadedState){
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.marsModel.photos!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Container(
                          height: mqData!.size.height * 0.5,
                          width: mqData!.size.width * 0.9,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              state.marsModel.photos![index].imgSrc!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      });
                }
                return Container();
              }
            ),
          ),
          SizedBox(
            height: 5,
          ),
          /*-------------Choose Spacecraft Font-----*/
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Choose ",
                  style: TextStyle(
                      fontSize: 25,
                      color: themeColor(isLight: isLight!),
                      fontFamily: 'Dark')),
              TextSpan(
                  text: "Spacecraft",
                  style: TextStyle(
                      fontSize: 25,
                      color: themeColor(isLight: isLight!),
                      fontFamily: 'Light'))
            ]),
          ),
          SizedBox(
            height: 5,
          ),
          /*-------------Choose Spacecraft Button-----*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              spaceCraftButton(
                  color: Colors.grey.shade900,
                  icon: Icons.rocket_launch,
                  headText: "Orion X",
                  text: "850 Mk/H"),
              spaceCraftButton(
                  color: Colors.green.shade800,
                  icon: Icons.rocket_outlined,
                  headText: "Dragon",
                  text: "900 Mk/H"),
              spaceCraftButton(
                  color: Colors.grey.shade900,
                  icon: Icons.rocket_launch_outlined,
                  headText: "Alkay",
                  text: "450 Mk/H"),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          /*------Swipe Button----------*/
          SizedBox(
            width: mqData!.size.width * 0.6,
            child: SwipeableButtonView(
              onFinish: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchFlight();
                }));
                setState(() {
                  isFinished = false; // Reset for future swipes
                });
              },
              isFinished: isFinished,
              onWaitingProcess: () async {
                await Future.delayed(Duration(milliseconds: 2));
                setState(() {
                  isFinished = true; // Ensure state is updated immediately after
                });
              },
              activeColor: Colors.grey.shade900,
              buttonWidget: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
              ),
              buttonText: "Swipe Right",
            ),
          )
        ],
      ),
    );
  }

  Color themeColor({required bool isLight}) {
    return isLight ? Colors.black : Colors.white;
  }

  Widget spaceCraftButton(
      {required Color color,
      required IconData icon,
      required String headText,
      required String text}) {
    return Container(
      height: mqData!.size.height * 0.17,
      width: mqData!.size.width * 0.26,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: Colors.white),
          Text(
            headText,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
