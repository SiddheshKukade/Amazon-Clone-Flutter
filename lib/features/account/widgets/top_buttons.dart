import 'package:amazon_clone_flutter/features/account/widgets/account_button.dart';
import 'package:flutter/cupertino.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Pending Orders', onTap: () {}),
            AccountButton(text: 'Become a Merchant', onTap: () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(text: 'Log Out', onTap: () {}),
            AccountButton(text: 'Your Wish List', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
