import 'package:ctware/model/bank_location.dart';
import 'package:ctware/screens/bank_location/bl_map_view.dart';
import 'package:ctware/services/common_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BankLocationListView extends StatefulWidget {
  const BankLocationListView({super.key});

  @override
  State<BankLocationListView> createState() => _BankLocationListViewState();
}

class _BankLocationListViewState extends State<BankLocationListView> {
  late Future<List<BankLocation>> futureBankLocation;
  late List<BankLocation> bankLocationData;

  @override
  void initState() {
    super.initState();
    final commonService = CommonService(context: context);
    futureBankLocation = commonService.getBankLocation();
  }

  Widget bankLocationListView(BuildContext context) {
    final listView = <Widget>[];
    for (var bankLocation in bankLocationData) {
      listView.add(InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BankLocationMapView(bankLocation: bankLocation),
                ));
        },
        child: Container(
          decoration: BoxStyle.fromBoxDecoration(radius: 5),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Row(
            children: [
              bankLocation.MANH == BankLocation.MAIN_BRANCH
                  ? const Icon(Icons.home, size: 30, color: Colors.red)
                  : const Icon(Iconsax.bank, size: 30, color: Colors.blue),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(bankLocation.TENNH, style: const TextStyle(fontSize: 16)),
                ),
              ),
              const Icon(Icons.keyboard_arrow_right_rounded, size: 20)
            ],
          ),
        ),
      ));
    }
    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(marginLayoutBase),
      child: Column(children: listView),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Địa điểm thanh toán',
      body: FutureBuilder(
        future: futureBankLocation,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            bankLocationData = snapshot.data ?? [];
            return bankLocationListView(context);
          }
          return const SizedBox(
              height: 100,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 3,
              )));
        },
      )
    );
  }
}
