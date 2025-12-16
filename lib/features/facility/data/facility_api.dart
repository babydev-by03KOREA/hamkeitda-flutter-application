import 'package:dio/dio.dart';
import 'package:hamkeitda_flutter/core/lib.dart';

class FacilityApi {
  final Dio _dio;
  FacilityApi({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: API_BASE_URL));

  // ─────────────────────────────────────────────
  // 근처 시설
  Future<List<Map<String, dynamic>>> fetchNearby({
    required double lat,
    required double lng,
    double radiusKm = 3,
  }) async {

    try {
      final res = await _dio.get('/api/facility/nearby', queryParameters: {
        'lat': lat,
        'lng': lng,
        'radius_km': radiusKm,
      });
      return (res.data as List).cast<Map<String, dynamic>>();
    } catch (_) {
      // 네트워크 실패 시에도 화면 점검 가능하도록 더미 리턴
      return _mockNearby(lat, lng);
    }
  }

  // ─────────────────────────────────────────────
  // 상세
  Future<Map<String, dynamic>> fetchDetail(String id) async {
    try {
      final res = await _dio.get('/api/facility/$id');
      return (res.data as Map<String, dynamic>);
    } catch (_) {
      return _mockDetail(id);
    }
  }

  // ─────────────────────────────────────────────
  // 상담 신청
  Future<void> submitConsult(
      String id, {
        required String name,
        required String phone,
        required String message,
      }) async {

    await _dio.post('/api/facility/$id/consult', data: {
      'name': name,
      'phone': phone,
      'message': message,
    });
  }

  // ───── MOCK DATA ─────
  List<Map<String, dynamic>> _mockNearby(double lat, double lng) => [
    {
      'id': 'f1',
      'name': '우리복지시설',
      'phone': '02-1234-5678',
      'openHours': '09:00 - 18:00',
      'lat': lat + 0.002,
      'lng': lng + 0.001,
      'description': '우리복지시설 설명'
    },
    {
      'id': 'f2',
      'name': '장애인복지센터',
      'phone': '02-4567-8901',
      'openHours': '09:00 - 20:00',
      'lat': lat - 0.001,
      'lng': lng + 0.002,
      'description': '장애인복지센터 설명'
    },
    {
      'id': 'f3',
      'name': '행복한 노인 복지센터',
      'phone': '02-2345-6789',
      'openHours': '09:00 - 17:00',
      'lat': lat + 0.001,
      'lng': lng - 0.002,
      'description': '행복한 노인 복지센터 설명'
    },
  ];

  Map<String, dynamic> _mockDetail(String id) => {
    'id': id,
    'name': '장애인복지센터',
    'description': '사람과 보통의 일상을 지역사회에서 온전한 삶으로 잇다.',
    'phone': '02-4567-8901',
    'openHours': '09:00 - 20:00',
    'address': '울산 남구 어딘가로3',
    'imageUrl': null, // 캐러셀은 에셋 이미지 사용
    'requiredDocs': [
      {'title': '보호자신분증', 'note': '보호자 신분증 실물을 들고오시면 됩니다.'},
      {'title': '장애인복지카드'}
    ],
    'programs': [
      {'title': '낮 프로그램', 'summary': '기초 학습 및 공예'},
      {'title': '자립훈련', 'summary': '생활훈련, 사회성 개발'}
    ],
    'fees': [
      {'item': '기본 이용료', 'price': '월 30,000원', 'note': '재료비 별도'},
      {'item': '상담비', 'price': '무료'}
    ],
    'posts': [
      {'id': 'p1', 'title': '6월 프로그램 안내', 'preview': '이번 달 일정 공지합니다.'}
    ],
  };
}