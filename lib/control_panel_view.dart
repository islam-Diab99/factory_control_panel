
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:segment_display/segment_display.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ControlPanelView extends StatefulWidget {
  const ControlPanelView({Key? key}) : super(key: key);

  @override
  State<ControlPanelView> createState() => _ControlPanelViewState();
}

class _ControlPanelViewState extends State<ControlPanelView> with SingleTickerProviderStateMixin {
   double? pressureValue=0;
   bool isPressureControlOpen=true;
   double? levelValue=0;
   bool isLevelControlOpen=true;
   late AnimationController controller;
   Animation? animation;

   @override
  void initState() {
     super.initState();
     controller =AnimationController(
       duration: Duration(seconds: 2),

       vsync: this,

     );
     animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();

    animation?.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        controller.reverse(from: 1.0);
      }
      else if (status==AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller?.addListener(() {

      setState((){
        print(animation?.value);
      });
    });

  }


   @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [

              Column(
                children: [
                  const Text('Pressure',style: TextStyle(fontSize: 20),),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,

                        width: 3.0,
                      ), ),

                    child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(minimum: 0, maximum: 150,
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                                GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
                                GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: pressureValue!)],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(widget: Container(child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${pressureValue?.floor()}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                                    Text(' Psi',style: TextStyle(color: Colors.grey),)
                                  ],
                                )),
                                    angle: 90, positionFactor: 0.5
                                )]
                          )]


                    ),
                  ),
                  Row(
                    children: [
                      Container(

                        color: isPressureControlOpen?Colors.white:Colors.grey,
                        padding: EdgeInsets.all(25),

                        height: 250,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: SfSlider(
                            min: 0.0,
                            max: 140.0,
                            value: pressureValue,
                            interval: 20,

                            showTicks: true,
                            showLabels: true,
                            enableTooltip: true,
                            // minorTicksPerInterval: 1,
                            // showDividers: true,
                            activeColor: Colors.black,





                            onChanged:(value){
                              if(isPressureControlOpen) {
                                setState(() {
                                  pressureValue = value;
                                });
                              }
                              else {
                                setState(() {

                                });
                              }
                            },



                          ),
                        ),
                      ),
                      Container(
                        color:  isLevelControlOpen?Colors.white:Colors.grey,
                        padding: EdgeInsets.all(20),

                        height: 250,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: SfSlider(
                            min: 0.0,
                            max: 140.0,
                            value: levelValue,
                            interval: 20,
                            showTicks: true,
                            showLabels: true,
                            enableTooltip: true,
                            // minorTicksPerInterval: 1,
                            // showDividers: true,
                            activeColor: Colors.black,





                            onChanged:(value){
                              if(isLevelControlOpen) {
                                setState(() {
                                  levelValue = value;
                                });
                              }
                              else {
                                setState(() {

                                });
                              }
                            },



                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ToggleSwitch(
                        minWidth: 50.0,
                        minHeight: 40.0,
                        initialLabelIndex: isPressureControlOpen?1:0,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,


                        icons: [
                          Icons.lock,
                          Icons.lock_open_sharp,

                        ],
                        iconSize: 30.0,

                        activeBgColors: [[Colors.black45, Colors.black26], [Colors.yellow, Colors.orange]],
                         // with just animate set to true, default curve = Curves.easeIn
                        curve: Curves.bounceInOut, // animate must be set to true when using custom curve
                        onToggle: (index) {
                         if (index==0){
                           setState((){
                             isPressureControlOpen=false;
                           });
                         }
                         else if (index==1){
                           setState((){
                             isPressureControlOpen=true;
                           });
                         }
                        },
                      ),
                      ToggleSwitch(
                        minWidth: 50.0,
                        minHeight: 40.0,
                        initialLabelIndex: isLevelControlOpen?1:0,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        icons: [
                          Icons.lock,
                          Icons.lock_open_sharp,

                        ],
                        iconSize: 30.0,
                        activeBgColors: [[Colors.black45, Colors.black26], [Colors.yellow, Colors.orange]],
                        // with just animate set to true, default curve = Curves.easeIn
                        curve: Curves.bounceInOut, // animate must be set to true when using custom curve
                        onToggle: (index) {
                          if (index==0){
                            setState((){
                              isLevelControlOpen=false;
                            });
                          }
                          else if (index==1) {
                            setState((){
                              isLevelControlOpen=true;
                            });
                          }
                        },
                      ),
                    ],
                  ),



                ],
              ),
              Column(
                children: [
                  const Text('Level',style: TextStyle(fontSize: 20),),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,

                        width: 3.0,
                      ), ),
                    child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(minimum: 0, maximum: 150,
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                                GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
                                GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: levelValue!)],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(widget: Container(child:
                                Row(

                                  children: [
                                    Text('${levelValue?.floor()} ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                                    Text('M',style: TextStyle(color: Colors.grey),)
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                                    angle: 90, positionFactor: 0.5
                                )]
                          )]


                    ),
                  ),


                ],
              ),
              Column(
                children: [
                  const Text('Temperature',style: TextStyle(fontSize: 20),),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,

                        width: 3.0,
                      ), ),
                    child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(minimum: 0, maximum: 150,
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                                GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
                                GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: (animation?.value*100)!)],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(widget: Container(child:
                                Row(

                                  children: [
                                    Text('${(animation?.value*100).toStringAsFixed(2)} ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                                    Text('M',style: TextStyle(color: Colors.grey),)
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                                    angle: 90, positionFactor: 0.5
                                )]
                          )]


                    ),
                  ),
                  SevenSegmentDisplay(
                    value: "${(animation?.value*100).toStringAsFixed(2)}",
                    size: 12.0,
                    segmentStyle: HexSegmentStyle(
                      enabledColor:  Colors.amber,
                      disabledColor: const Color(0xFF00FF00).withOpacity(0.15),
                      segmentBaseSize: const Size(1.0, 1.2),
                    ),
                  )


                ],
              ),
              Column(
                children: [
                  const Text('Humidity',style: TextStyle(fontSize: 20),),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,

                        width: 3.0,
                      ), ),
                    child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(minimum: 0, maximum: 150,
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                                GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
                                GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
                              pointers: <GaugePointer>[
                                NeedlePointer(value:(animation?.value*55) )],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(widget: Container(child:
                                Row(

                                  children: [
                                    Text('${(animation?.value*55).toStringAsFixed(2)} ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                                    Text('M',style: TextStyle(color: Colors.grey),)
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                                    angle: 90, positionFactor: 0.5
                                )]
                          )]


                    ),
                  ),
                  SevenSegmentDisplay(
                    value: "${(animation?.value*50).toStringAsFixed(2)} ",
                    size:
                    12.0,
                    segmentStyle: HexSegmentStyle(
                      enabledColor:  Colors.amber,
                      disabledColor: const Color(0xFF00FF00).withOpacity(0.15),
                      segmentBaseSize: const Size(1.0, 1.2),
                    ),
                  )


                ],
              ),





            ],
          ),
        ),
      ),
    );
  }
}

