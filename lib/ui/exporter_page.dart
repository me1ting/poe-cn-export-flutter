import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExporterPage extends StatelessWidget {
  const ExporterPage({super.key});

  void placeHolder() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 420,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: Column(
                children: [
                  const _StatusHeader(),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const _StatusBody()),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(children: [
                const _EncoderHeader(),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const _EncoderBody()),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  const _StatusHeader();

  void placeHolder() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '状态',
                style: TextStyle(fontSize: 18),
              ),
            )),
        Flexible(
          flex: 1,
          child: IconButton(
            icon: const Icon(Icons.refresh, size: 20, semanticLabel: "刷新"),
            tooltip: '刷新',
            onPressed: placeHolder,
          ),
        )
      ],
    );
  }
}

class _StatusBody extends StatelessWidget {
  const _StatusBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('POESESSID'),
                  )),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Tooltip(
                    message: "session无效",
                    child: Icon(
                      Icons.error_outline,
                      fill: 0,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('POB'),
                  )),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Tooltip(
                    message: "POB无效",
                    child: Icon(
                      Icons.error_outline,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('监听端口'),
                  )),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('0000'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _EncoderHeader extends StatelessWidget {
  const _EncoderHeader();

  void placeHolder() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'URI编码',
                style: TextStyle(fontSize: 18),
              ),
            )),
      ],
    );
  }
}

class _EncoderBody extends StatefulWidget {
  const _EncoderBody();

  @override
  State<_EncoderBody> createState() => _EncoderBodyState();
}

class _EncoderBodyState extends State<_EncoderBody> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      label: const Text(
                        "论坛账户名",
                        style: TextStyle(fontSize: 12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor)),
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 12),
                    controller: _controller,
                    /*onChanged: (value){
                      setState(() {
                        _forumUserNameInput = value;
                      });
                    },*/
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: Uri.encodeComponent(_controller.text)));
                },
                child: const Text('编码并复制'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
