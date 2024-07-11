import 'package:creama/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  bool _hasPermission = false;
  bool _isLibraryLoading = false;
  late CameraController _cameraController = CameraController(
      const CameraDescription(
          name: "",
          lensDirection: CameraLensDirection.front,
          sensorOrientation: 0),
      ResolutionPreset.ultraHigh);

  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    await _cameraController.initialize();
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();

    final cameraGranted =
        !cameraPermission.isDenied && !cameraPermission.isPermanentlyDenied;

    if (cameraGranted) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _onPhotoShootTap() async {
    if (_cameraController.value.isTakingPicture) return;

    final file = await _cameraController.takePicture();
    await GallerySaver.saveImage(file.path);

    final List<XFile> selectedFile = [file];

    if (!mounted) return;
    Navigator.pop(context, selectedFile);
  }

  Future<void> _onLibraryTap() async {
    setState(() {
      _isLibraryLoading = true;
    });
    final List<XFile> files = await ImagePicker().pickMultiImage();

    if (files.isEmpty) return;
    if (!mounted) return;

    Navigator.pop(context, files);
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('카메라 동의를 구하는중'),
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(Sizes.size18),
                                ),
                              ),
                              child: CameraPreview(_cameraController),
                            ),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              bottom: Sizes.size32,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTapUp: (details) => _onPhotoShootTap(),
                                    child: Container(
                                      width: 76,
                                      height: 76,
                                      padding: const EdgeInsets.all(
                                        Sizes.size4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: Sizes.size3,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black,
                          child: Center(
                            child: _isLibraryLoading
                                ? const CircularProgressIndicator.adaptive()
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: const EdgeInsets.only(bottom: 4),
                    controller: _tabController,
                    // isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.white,
                    tabs: [
                      const Tab(
                        text: "Camera",
                      ),
                      GestureDetector(
                        onTap: _onLibraryTap,
                        child: const Tab(
                          text: "Library",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
