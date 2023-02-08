import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: _Header()),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          Container(margin: const EdgeInsets.all(20), child: _Body()),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
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
                '设置',
                style: TextStyle(fontSize: 24),
              ),
            )),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {},
              child: const Text('重置'),
            ),
          ),
        )
      ],
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  var isPobProxySupported = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "基本",
          style: TextStyle(fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Flexible(
              flex: 1,
              child: SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    label: Text(
                      "POESESSID",
                      style: TextStyle(fontSize: 12),
                    ),
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('保存'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Flexible(
              flex: 1,
              child: SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    label: Text(
                      "POB路径",
                      style: TextStyle(fontSize: 12),
                    ),
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('选择'),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Patch",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Flexible(
              flex: 1,
              child: Text("清除Patch"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('重置'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Flexible(flex: 1, child: Text("POB代理支持")),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Checkbox(
                value: isPobProxySupported,
                onChanged: (bool? value) {
                  setState(() {
                    isPobProxySupported = !isPobProxySupported;
                  });
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
