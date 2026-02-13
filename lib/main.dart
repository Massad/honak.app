import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/app.dart';
import 'package:honak/bootstrap.dart';

void main() async {
  await bootstrap();
  runApp(const ProviderScope(child: HonakApp()));
}
