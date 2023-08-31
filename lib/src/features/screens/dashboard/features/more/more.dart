import 'package:erisiti/src/features/screens/dashboard/features/more/components/body.dart';
import 'package:erisiti/src/features/screens/dashboard/features/more/components/topbar.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [MoreTopBar(), MoreBody()],
        ),
      ),
    );
  }
}
