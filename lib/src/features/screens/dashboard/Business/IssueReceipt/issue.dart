import 'package:erisiti/src/features/screens/dashboard/Business/IssueReceipt/components/issue_page.dart';
import 'package:flutter/material.dart';

import '../RegisterBusiness/components/top_bar.dart';

class IssueReceiptPage extends StatefulWidget {
  const IssueReceiptPage({super.key});

  @override
  State<IssueReceiptPage> createState() => _IssueReceiptPageState();
}

class _IssueReceiptPageState extends State<IssueReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BusinessTopBar(
              image: "assets/images/issue.png",
              title: "Issue receipt",
            ),
            IssueBody()
          ],
        ),
      ),
    );
  }
}
