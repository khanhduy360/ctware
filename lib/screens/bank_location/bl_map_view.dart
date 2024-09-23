import 'package:ctware/model/bank_branch.dart';
import 'package:ctware/model/bank_location.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BankLocationMapView extends StatefulWidget {
  const BankLocationMapView({super.key, required this.bankLocation});

  final BankLocation bankLocation;

  @override
  State<BankLocationMapView> createState() => _BankLocationMapViewState();
}

class _BankLocationMapViewState extends State<BankLocationMapView> {
  late LatLng _center;
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    final position = widget.bankLocation.getFirstPosition();
    final brachTe = widget.bankLocation.NganHangDiaDiems[0];
    _center = LatLng(position[0], position[1]);
    _markers[brachTe.Ten] = Marker(
      markerId: MarkerId(brachTe.Ten),
      position: LatLng(double.parse(brachTe.X), double.parse(brachTe.Y)),
      infoWindow: InfoWindow(
        title: brachTe.Ten,
        snippet: brachTe.DiaChi,
      ),
    );
  }

  Widget branchView(BuildContext context, BankBranch bankBranch) {
    if (!bankBranch.TrangThai) {
      return const SizedBox();
    }
    return Container(
      decoration: BoxStyle.fromBoxDecoration(),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      width: Responsive.width(100, context),
      height: 120,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankBranch.Ten ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  bankBranch.DiaChi ?? '',
                  maxLines: 2,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  bankBranch.DienThoai ?? '',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          )),
          ClipOval(
            child: InkWell(
              onTap: () async {
                String phoneNumber = bankBranch.DienThoai ?? '';
                String formattedPhoneNumber =
                    phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
                await launchUrl(Uri.parse('tel:$formattedPhoneNumber'));
              },
              child: const Material(
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.white,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Chi tiết địa điểm',
      body: Column(
        children: [
          Container(
            width: Responsive.width(100, context),
            height: Responsive.height(50, context),
            child: GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: _markers.values.toSet(),
              initialCameraPosition: CameraPosition(zoom: 15, target: _center),
            ),
          ),
          Expanded(
              child: ListView(
            children: widget.bankLocation.NganHangDiaDiems
                .map((value) => branchView(context, value))
                .toList(),
          )),
        ],
      ),
    );
  }
}
