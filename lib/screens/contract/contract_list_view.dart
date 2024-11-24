import 'package:ctware/model/contract.dart';
import 'package:ctware/provider/contract_provider.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContractListView extends StatefulWidget {
  const ContractListView({super.key});

  @override
  State<ContractListView> createState() => _ContractListViewState();
}

class _ContractListViewState extends State<ContractListView> {
  late ContractProvider contractProvider;
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    contractProvider = Provider.of<ContractProvider>(context, listen: false);
  }

  Widget loadWidget(BuildContext context) {
    if (contractProvider.listContract.isEmpty) {
      if(firstLoad) {
        firstLoad = false;
        return FutureBuilder(
            future: contractProvider.futureContracts(context),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return contractItems(context, contractProvider.listContract);
              }
              return BaseLayout.loadingView(context);
            });
      }
    }
    return contractItems(context, contractProvider.listContract);
  }

  Widget contractItems(BuildContext context, List<Contract> listContract) {
    return RefreshIndicator(
      onRefresh: () async {
        contractProvider.futureContracts(context);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: listContract
                .map(
                  (contract) => Container(
                    margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
                    decoration: BoxStyle.fromBoxDecoration(radius: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Responsive.width(100, context),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 27, 149, 31),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Số hợp đồng: ${contract.SOHOPDONG ?? ''}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hợp đồng: ${contract.TENHOPDONG ?? ''}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Ngày ký: ${contract.NGAYKY_KHACHHANG ?? ''}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Số điện thoại: ${contract.DIENTHOAI ?? ''}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'IDKH: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 168, 166, 166),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    contract.IDKH.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Họ tên: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 168, 166, 166),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    contract.HOTEN ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Địa chỉ: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 168, 166, 166),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    contract.DIACHI ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Color.fromARGB(255, 237, 236, 236)),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.file_present,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Xem hợp đồng',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Danh sách Hợp đồng',
        body: Consumer<ContractProvider>(builder: (context, value, child) => loadWidget(context)));
  }
}
