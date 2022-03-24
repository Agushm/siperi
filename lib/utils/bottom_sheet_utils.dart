import 'package:aplikasi_siperi/ui/constants/data.dart';
import 'package:aplikasi_siperi/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

Future showPedoman(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 1,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          Icon(
            Icons.remove,
            color: Colors.grey[600],
          ),
          Expanded(
              child:
                  SingleChildScrollView(child: htmlWidget(pedomanPengkajian))),
        ],
      ),
    ),
  );
}
