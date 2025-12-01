import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/theme/app_theme.dart';
import 'package:tictactoe/theme/theme_switcher.dart';
import 'package:tictactoe/widgets/app_button.dart';
import 'package:tictactoe/widgets/app_scaffold.dart';

class OnlinePseudoScreen extends StatefulWidget {
  const OnlinePseudoScreen({super.key});

  @override
  State<OnlinePseudoScreen> createState() => _OnlinePseudoScreenState();
}

class _OnlinePseudoScreenState extends State<OnlinePseudoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _goToOnlineScreen() {
    if (_formKey.currentState!.validate()) {
      context.push(
        '/online-pseudo/game-selection?playerName=${Uri.encodeComponent(_nameController.text.trim())}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.appTheme.color;
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Online Username'),
        backgroundColor: colorTheme.mainBackground.withValues(alpha: 0.5),
        actions: [ThemeSwitcher()],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name input field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _goToOnlineScreen(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    if (value.trim().length > 20) {
                      return 'Name must be less than 20 characters';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorTheme.onPrimary2,
                  ),
                ),
                const SizedBox(height: 24),

                // Play online button
                AppButton.secondary(
                  context: context,
                  onPressed: _goToOnlineScreen,
                  text: 'Go',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
