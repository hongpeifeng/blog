
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      key: const ValueKey('ReplyExit'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: '关键字搜索',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _SearchHistoryTile(
                        search: '逆向总纲',
                        address: 'xxxxxxxxxxxxxxxx',
                      ),
                      _SearchHistoryTile(
                        search: '逆向总纲',
                        address: 'xxxxxxxxxxxxxxxx',
                      ),
                      _SearchHistoryTile(
                        search: '逆向总纲',
                        address: 'xxxxxxxxxxxxxxxx',
                      ),
                      _SearchHistoryTile(
                        search: '逆向总纲',
                        address: 'xxxxxxxxxxxxxxxx',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    @required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        top: 16,
        bottom: 16,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

class _SearchHistoryTile extends StatelessWidget {
  const _SearchHistoryTile({
    this.icon = Icons.access_time,
    @required this.search,
    @required this.address,
  });

  final IconData icon;
  final String search;
  final String address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(search),
      subtitle: Text(address),
      onTap: () {},
    );
  }
}
