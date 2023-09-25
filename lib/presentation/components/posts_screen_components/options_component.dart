import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'interaction_button_component.dart';

class OptionsComponent extends StatelessWidget {
  const OptionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 0.06.sh,
        child: const ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionsButtonComponent(
              icon: Icons.thumb_up_outlined,
              text: 'Like',
            ),
            OptionsButtonComponent(
              icon: Icons.comment_outlined,
              text: 'Comment',
            ),
            OptionsButtonComponent(
              icon: Icons.send,
              text: 'Send',
            )
          ],
        ));
  }
}
