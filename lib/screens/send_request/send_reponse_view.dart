import 'package:ctware/model/user_requests.dart';
import 'package:ctware/model/user_responses.dart';
import 'package:ctware/provider/send_response_provider.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendReponseView extends StatefulWidget {
  const SendReponseView({super.key, required this.userRequests});

  final UserRequests userRequests;

  @override
  State<SendReponseView> createState() => _SendReponseViewState();
}

class _SendReponseViewState extends State<SendReponseView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String resContentValue = '';
  late SendResponseProvider sendResponseProvider;
  late Future<List<UserResponses>> futureUserResponses;

  @override
  void initState() {
    super.initState();
    sendResponseProvider =
        Provider.of<SendResponseProvider>(context, listen: false);
    futureUserResponses = sendResponseProvider.futureUserResponses(
        context, widget.userRequests.ReqId);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    sendResponseProvider.userResponsesList = [];
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  onSendMessage() async {
    final formState = _formKey.currentState;
    if (formState != null) {
      formState.save();
    }
    await sendResponseProvider.futureSendResponses(context,
        reqID: widget.userRequests.ReqId, resContent: resContentValue);
    resContentValue = '';
    _textEditingController.clear();
    _scrollToBottom();
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }

  Widget messageInfo(
    BuildContext context, {
    bool right = true,
    required String resDate,
    required String resContent,
  }) {
    return Container(
      alignment: right ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(5),
      child: Column(
          crossAxisAlignment:
              right ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(resDate,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Container(
              decoration: BoxDecoration(
                  color: right
                      ? const Color.fromARGB(255, 39, 135, 214)
                      : Colors.red,
                  borderRadius: BorderRadius.circular(5)),
              width: Responsive.width(80, context),
              padding: const EdgeInsets.all(10),
              alignment: right ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(resContent,
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ]),
    );
  }

  Widget listMessage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: Consumer<SendResponseProvider>(builder: (BuildContext context,
            SendResponseProvider sendResponseProvider, Widget? child) {
          final listMessageItem = <Widget>[
            messageInfo(context,
                resDate: widget.userRequests.getReqDate(),
                resContent: widget.userRequests.ReqContent ?? ''),
          ];
          listMessageItem.addAll(sendResponseProvider.userResponsesList
              .map((item) => messageInfo(context,
                  resDate: item.getResDate(),
                  resContent: item.ResContent ?? ''))
              .toList());
          return Column(children: listMessageItem);
        }),
      ),
    );
  }

  Widget sendMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    labelText: 'Nội dung phản hồi',
                    border: OutlineInputBorder()),
                onSaved: (value) => resContentValue = value ?? '',
              ),
            ),
            InkWell(
                onTap: () {
                  onSendMessage();
                },
                child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: const Icon(Icons.send, size: 30)))
          ],
        ),
      ),
    );
  }

  Widget onInitView(BuildContext context) {
    if (sendResponseProvider.userResponsesList.isEmpty) {
      return FutureBuilder(
          future: futureUserResponses,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return listMessage(context);
            }
            return BaseLayout.loadingView(context);
          });
    }
    return listMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: '',
        body: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: Column(
            children: [
              Expanded(child: onInitView(context)),
              widget.userRequests.CanSendRequest
                  ? sendMessage(context)
                  : const SizedBox(),
            ],
          ),
        ));
  }
}
