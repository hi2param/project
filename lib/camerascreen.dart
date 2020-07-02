import 'package:camera/camera.dart';
import 'package:firstproject/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  @override
  // this is the life cycle method of statefulwidget
  void initState(){
    super.initState();
    // available camera is part of camera plugin which will return a list of available cameras on the device
     availableCameras().then((availableCameras){
       cameras = availableCameras;
       if(cameras.length > 0){
         setState(() {
           selectedCameraIdx = 0;
         });
           _initCameraController(cameras[selectedCameraIdx]).then((void v) {});  // select camera id will be 0 in which select the camera 0 is back and 1 is front camera.
     }else{
         print("no camera available");
       }
     }).catchError((err){                  // this method for when somthing goeg wrong
       print('Error: $err.code\nError Message: $err.message');
     });
  }
// future is the return type method and
  //_initCameraController method responsible for initialize the camera controller
  Future _initCameraController(CameraDescription cameraDescription) async {
    if(controller != null){
      await controller.dispose();
    }

    //cameraDescription will hold the type of camera(front or back) you want to use.
    // and object which takes two arguments
    //first a cameraDescription and second a resolutionPreset with which the picture should be captured. ResolutionPreset can have only 3 values i.e high, mediumand low.
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller.addListener((){           //addlistener  this closure will be called when you switch between the front and back camera.
      if(mounted){           // mounted is a geetter method which will return a boolean value
        setState(() {

        });
      }
      //While initializing the controller object if something goes wrong you will catch the error in a try/catch block.
      if(controller.value.hasError){
        print('Camera error ${controller.value.errorDescription}');
      }
    });
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Camera'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:  _cameraPreviewWidget(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  _cameraTogglesRowWidget(),
                  _captureControlRowWidget(context),
                  Spacer()

                ],
              ),
              SizedBox(height: 20.0,)
            ],
          ),
        ),
      ),
    );
  }
  /// Display Camera preview.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }
/// Display the control bar with buttons to take pictures
Widget _captureControlRowWidget(context){
    return Expanded(
      child: Align(
        alignment:Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton(
              child: Icon(Icons.camera),
              backgroundColor: Colors.blueGrey,
              onPressed: (){
                _onCapturePressed(context);
              })
          ],
        ),
      ),
    );
}
/// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: _onSwitchCamera,
            icon: Icon(_getCameraLensIcon(lensDirection)),
            label: Text(
                "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
      ),
    );
  }




  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
    selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  void _onCapturePressed(context) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Attempt to take a picture and log where it's been saved
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      print(path);
      await controller.takePicture(path);

     // If the picture was taken, display it on a new screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewImageScreen(imagePath: path),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }
}