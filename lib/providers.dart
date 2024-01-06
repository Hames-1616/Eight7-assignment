import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Eight7/db.dart';

final getproductsFutureProvider =
    FutureProvider.family((ref, int index) => getProducts(index));
final number = StateProvider((ref) => 0);
