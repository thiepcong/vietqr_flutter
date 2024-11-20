library vietqr;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VietQRItem extends StatefulWidget {
  const VietQRItem({
    super.key,
    this.width,
    this.height,
    this.accountName,
    required this.accountNumber,
    required this.bankCode,
    required this.amount,
    this.content,
    this.templateId = "",
    this.placeholder,
  });

  final double? width;
  final double? height;
  final String? accountName;
  final String accountNumber;
  final String bankCode;
  final String templateId;
  final int amount;
  final String? content;
  final Widget Function(BuildContext, String)? placeholder;

  @override
  State<VietQRItem> createState() => _VietQRItemState();
}

class _VietQRItemState extends State<VietQRItem> {
  final Map<String, dynamic> _queryParameters = {};
  Uri _uri = Uri();

  @override
  void initState() {
    _queryParameters.addAll({
      'accountName': widget.accountName,
      'amount': widget.amount.toString(),
      'addInfo': widget.content,
    });
    String baseUrl =
        "https://api.vietqr.io/image/${widget.bankCode}-${widget.accountNumber}-${widget.templateId}.jpg";
    _uri = Uri.parse(baseUrl).replace(queryParameters: _queryParameters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      imageUrl: _uri.toString(),
      placeholder: widget.placeholder,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
