

import 'package:dentiq/features/scan/presentation/widgets/scan_view_body.dart';
import 'package:flutter/material.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return 

      Scaffold(body: SafeArea(child: SingleChildScrollView(child: ScanViewBody()),));
    
    

  }

  // Widget _buildAppBar() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Row(
  //       children: const [
  //         CircleAvatar(
  //           backgroundColor: Colors.white,
  //           child: Icon(Icons.arrow_back),
  //         ),
  //         SizedBox(width: 12),
  //         Text(
  //           'Teeth Scan',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
