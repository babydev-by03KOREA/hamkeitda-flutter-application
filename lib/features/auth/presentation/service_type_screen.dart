import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 선택된 서비스 유형을 보관하는 Provider
enum ServiceType { personal, facility, guest }
final serviceTypeProvider = StateProvider<ServiceType>((ref) => ServiceType.personal);

class ServiceTypeScreen extends ConsumerWidget {
  static const route = '/service-type';

  const ServiceTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goPersonal() {
      ref.read(serviceTypeProvider.notifier).state = ServiceType.personal;
      Navigator.of(context).pushNamed('/auth');
    }

    void goFacility() {
      ref.read(serviceTypeProvider.notifier).state = ServiceType.facility;
      Navigator.of(context).pushNamed('/auth');
    }

    void goGuest() {
      ref.read(serviceTypeProvider.notifier).state = ServiceType.guest;
      Navigator.of(context).pushNamed('/home');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('서비스 유형 선택')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SizedBox(height: 12),
                _Header(),
                SizedBox(height: 20),
                _ChoiceCard(
                  icon: Icons.person,
                  title: '개인회원',
                  subtitle: '복지시설 서비스를 찾고 상담을 신청하세요',
                  routeTap: 'personal',
                ),
                _ChoiceCard(
                  icon: Icons.apartment,
                  title: '복지시설',
                  subtitle: '복지시설을 등록하고 이용자와 상담하세요',
                  routeTap: 'facility',
                ),
                _ChoiceCard(
                  icon: Icons.remove_red_eye,
                  title: '게스트',
                  subtitle: '회원가입 없이 복지시설 정보를 둘러보세요',
                  routeTap: 'guest',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('서비스 유형 선택', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(
          '개인회원, 복지시설 관리자 또는 게스트로 이용하세요',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

class _ChoiceCard extends ConsumerWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String routeTap; // 'personal' | 'facility' | 'guest'
  const _ChoiceCard({super.key, required this.icon, required this.title, required this.subtitle, required this.routeTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          switch (routeTap) {
            case 'personal':
              ref.read(serviceTypeProvider.notifier).state = ServiceType.personal;
              Navigator.of(context).pushNamed('/auth', arguments: {'title': '개인회원', 'type': 'personal', 'icon': Icons.person},);
              break;
            case 'facility':
              ref.read(serviceTypeProvider.notifier).state = ServiceType.facility;
              Navigator.of(context).pushNamed('/auth', arguments: {'title': '복지시설', 'type': 'facility','icon': Icons.apartment},);
              break;
            default:
              ref.read(serviceTypeProvider.notifier).state = ServiceType.guest;
              Navigator.of(context).pushNamed('/facility');
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 18, offset: const Offset(0, 6))],
          ),
          child: Column(
            children: [
              CircleAvatar(radius: 28, backgroundColor: const Color(0xFFF1F1F4), child: Icon(icon, size: 28, color: const Color(0xFF0A0A14))),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF9CA3AF))),
            ],
          ),
        ),
      ),
    );
  }
}