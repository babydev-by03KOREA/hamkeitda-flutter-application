import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/admin_dashboard_screen.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart';
import 'package:hamkeitda_flutter/features/facility/presentation/facility_map_screen.dart';
import '../../auth/application/auth_controller.dart';
import '../../../core/validators.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static const route = '/auth';

  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  int tab = 0; // 0: 로그인, 1: 회원가입

  @override
  void initState() {
    super.initState();

    ref.listenManual<AsyncValue<AppUser?>>(authControllerProvider, (
      prev,
      next,
    ) {
      if (next.isLoading) return;

      // 에러 처리
      if (next.hasError) {
        final msg =
            next.error?.toString().replaceFirst('Exception: ', '') ??
            '오류가 발생했어요.';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
        return;
      }

      // 성공 처리
      final user = next.valueOrNull;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              if (user.role == UserRole.facility) {
                return const AdminDashboardScreen();
              }
              return const FacilityMapScreen();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final title = args?['title'] ?? '로그인';
    final type = args?['type'] ?? 'personal';
    final IconData icon = args?['icon'] ?? Icons.person;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(radius: 32, child: Icon(icon, size: 36)),
                    const SizedBox(height: 16),
                    Text(
                      tab == 0 ? '로그인하여 계속하세요' : '새 계정을 만들어보세요',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                    _Segmented(
                      left: '로그인',
                      right: '회원가입',
                      value: tab,
                      onChanged: (v) => setState(() => tab = v),
                    ),
                    const SizedBox(height: 20),
                    if (tab == 0)
                      _LoginForm(isLoading: auth.isLoading)
                    else
                      _SignupForm(
                        isLoading: auth.isLoading,
                        type: type,
                        goToLoginTab: () => setState(() => tab = 0),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Segmented extends StatelessWidget {
  final String left;
  final String right;
  final int value;
  final ValueChanged<int> onChanged;

  const _Segmented({
    required this.left,
    required this.right,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F4),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [_segBtn(context, left, 0), _segBtn(context, right, 1)],
      ),
    );
  }

  Expanded _segBtn(BuildContext context, String label, int idx) {
    final selected = value == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(idx),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.black : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  final bool isLoading;

  const _LoginForm({required this.isLoading});

  @override
  ConsumerState<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: '이메일을 입력하세요'),
            validator: Validators.email,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              hintText: '비밀번호를 입력하세요',
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            obscureText: _obscure,
            validator: Validators.password,
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: widget.isLoading
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authControllerProvider.notifier)
                          .login(
                            email: _email.text.trim(),
                            password: _password.text,
                          );
                    }
                  },
            child: widget.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('로그인'),
          ),
        ],
      ),
    );
  }
}

class _SignupForm extends ConsumerStatefulWidget {
  final bool isLoading;
  final String type;
  final VoidCallback goToLoginTab;

  const _SignupForm({
    super.key,
    required this.isLoading,
    required this.type,
    required this.goToLoginTab,
  });

  @override
  ConsumerState<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<_SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _password2 = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _password2.dispose();
    super.dispose();
  }

  String _roleFromType(String type) {
    switch (type) {
      case 'facility':
        return 'ROLE_FACILITY';
      case 'personal':
        return 'ROLE_USER';
      case 'guest':
        throw Exception('게스트는 회원가입 없이 이용할 수 있어요.');
      default:
        throw Exception('가입 타입이 올바르지 않아요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(hintText: '이름을 입력하세요'),
            validator: (v) => Validators.required(v, label: '이름'),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: '이메일을 입력하세요'),
            validator: Validators.email,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              hintText: '비밀번호를 입력하세요',
              suffixIcon: IconButton(
                icon: Icon(_obscure1 ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _obscure1 = !_obscure1),
              ),
            ),
            obscureText: _obscure1,
            validator: Validators.password,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _password2,
            decoration: InputDecoration(
              hintText: '비밀번호를 다시 입력하세요',
              suffixIcon: IconButton(
                icon: Icon(_obscure2 ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _obscure2 = !_obscure2),
              ),
            ),
            obscureText: _obscure2,
            validator: (v) {
              final basic = Validators.password(v);
              if (basic != null) return basic;
              if (v != _password.text) return '비밀번호가 일치하지 않아요';
              return null;
            },
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: widget.isLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final res = await ref
                            .read(authRepositoryProvider)
                            .signup(
                              _name.text.trim(),
                              _email.text.trim(),
                              _password.text,
                              _roleFromType(widget.type),
                            );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(res.message)));

                        widget.goToLoginTab();
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().replaceFirst('Exception: ', ''),
                            ),
                          ),
                        );
                      }
                    }
                  },
            child: widget.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('회원가입'),
          ),
        ],
      ),
    );
  }
}
