import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user.dart';

final currentUserProvider = StateProvider<AppUser?>((_) => null);
// 로그인 성공 시 set: ref.read(currentUserProvider.notifier).state = user;