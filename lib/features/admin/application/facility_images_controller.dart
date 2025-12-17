import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/application/admin_controller.dart'
    hide adminApiProvider;
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';

import '../data/admin_providers.dart';
import '../data/facility_images_repository.dart';
import '../domain/facility_image.dart';

final facilityImagesRepoProvider = Provider<FacilityImagesRepository>((ref) {
  final api = ref.read(adminApiProvider);
  return FacilityImagesRepository(api);
});

final facilityImagesProvider =
    AsyncNotifierProvider<FacilityImagesController, List<FacilityImage>>(
      FacilityImagesController.new,
    );

class FacilityImagesController extends AsyncNotifier<List<FacilityImage>> {
  @override
  Future<List<FacilityImage>> build() async {
    // 1. AdminBasicState(기본 정보)를 구독합니다.
    final basicState = ref.watch(adminBasicProvider);

    // 2. 데이터가 로딩 중이거나 에러라면 빈 리스트 반환 (혹은 로딩 처리)
    if (!basicState.hasValue) {
      return <FacilityImage>[];
    }

    // 3. AdminBasicState 안에 있는 imageUrls(문자열 리스트)를 가져옵니다.
    final urls = basicState.value!.imageUrls;

    // 4. 문자열 URL을 FacilityImage 객체로 변환하여 반환합니다.
    // (현재 id나 다른 필드 정보가 없다면 임시 값이나 url을 활용해 객체 생성)
    return urls.map((url) {
      return FacilityImage(
        id: 0, // 기존 이미지는 ID를 알 수 없다면 0 또는 임시값
        url: url,
        sortOrder: 0,
        isPrimary: false,
      );
    }).toList();
  }

  Future<void> uploadMany({
    required List<File> files,
    bool makeFirstPrimary = false,
    String? caption,
  }) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    final fid = user?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    final prev = state.valueOrNull ?? <FacilityImage>[];

    // UI 안 끊기게 optimistic
    state = AsyncData(prev);

    state = await AsyncValue.guard(() async {
      final repo = ref.read(facilityImagesRepoProvider);

      final uploaded = <FacilityImage>[];

      for (var i = 0; i < files.length; i++) {
        final img = await repo.upload(
          facilityId: fid,
          file: files[i],
          isPrimary: makeFirstPrimary && i == 0,
          caption: caption,
        );
        uploaded.add(img);
      }

      final merged = [...prev, ...uploaded]
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return merged;
    });
  }
}
