import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast.dart';
import 'package:safsofa/screens/new/personel_page/help/toast/toast_states.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key, required this.url});

  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            ToastConfig.showToast(msg: 'تعذر تحميل الملف', toastStates: ToastStates.success);
          }, icon: Icon(Icons.download))
        ],
      ),
        body:url.contains('.pdf')? PDF(
          autoSpacing: true,

        ).fromUrl(
          url,
          placeholder: (double progress) => Center(child: Text('$progress %')),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ):Container(height:MediaQuery.of(context).size.height,child: Image.network(url,fit: BoxFit.fill,)));
  }
}

