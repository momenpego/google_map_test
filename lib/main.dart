import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    addMakers();
    super.initState();
  }

  late GoogleMapController mapController;

  static List<String> images1 = [
    'https://5jl.cc/?seraph_accel_gci=wp-content%2Fuploads%2F2021%2F02%2F5267-4.jpg&n=Qm6qC1OWFKmyr9FMMKpUA',
    'https://i.pinimg.com/736x/31/c4/16/31c416ca99a987414065c281fb43af9c.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0LxnWpGIFHfiUu-XKSRMlNvPukMtrxevbKtYH43k2sn9DACMcSe_6zOhS1oaajrL8Xbk&usqp=CAU'
  ];

  static List<String> images2 = [
    'https://img.youm7.com/ArticleImgs/2021/3/3/931454-%D8%B9%D9%85%D8%A7%D8%B1%D8%A7%D8%AA-%D9%88%D8%B3%D8%B7-%D8%A7%D9%84%D8%A8%D9%84%D8%AF.PNG',
    'https://img.innfrad.com/imagecontent/202103030412111211.jpg',
    'https://mantiqti.cairolive.com/wp-content/uploads/2020/05/064B2B84-EFC9-4591-9CCC-ECAF4B3F676F.jpeg'
  ];

  Set<Marker> markers = {};

  void addMakers() {
    markers.addAll([
      Marker(
        onTap: () {
          showPlaceInfoModal(
              const LatLng(31.19894036515012, 29.91003792732954),
              images1,
              'عماره الاجلال',
              'عماره سكنيه مكونه من 12 طابق في منطقه فيكتوريا الاسكندريه بجانب بنك مصر ');
        },
        markerId: const MarkerId('عماره الاجلال'),
        position: const LatLng(31.19894036515012, 29.91003792732954),
        infoWindow: const InfoWindow(
          title: 'عماره الاجلال',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        onTap: () {
          showPlaceInfoModal(
              const LatLng(31.19894036515012, 29.91003792732954),
              images2,
              'عماره الزهور',
              'عماره سكنيه مكونه من 5 طابق في منطقه الشاطبي الاسكندريه بجانب كليه الاداب ');
        },
        markerId: const MarkerId('عماره الزهور'),
        position: const LatLng(31.219987000047116, 29.949264898896217),
        infoWindow: const InfoWindow(
          title: 'عماره الزهور',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    ]);
  }

  void showPlaceInfoModal(
      LatLng tappedPoint, List<String> data, String title, String subTitle) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(subTitle),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(data[index])),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  final LatLng _center = const LatLng(31.2001, 29.9187);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Google Map Demo'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: markers,
              onTap: (argument) {},
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
