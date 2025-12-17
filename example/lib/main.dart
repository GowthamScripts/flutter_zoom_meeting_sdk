import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _meetingStatus = 'Not initialized';
  bool _isInitialized = false;
  final _zoomPlugin = FlutterZoomMeetingSdk();

  final _meetingIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _listenToMeetingStatus();
  }

  void _listenToMeetingStatus() {
    _zoomPlugin.onMeetingStateChanged.listen((status) {
      if (!mounted) return;
      setState(() {
        _meetingStatus = status.toString();
      });
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await _zoomPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _initZoomSDK() async {
    try {
      final result = await _zoomPlugin.init(ZoomOptions(
        domain: 'zoom.us',
        jwtToken: 'YOUR_JWT_TOKEN_HERE', // Replace with your JWT token
      ));

      if (!mounted) return;

      setState(() {
        _isInitialized = result.isNotEmpty && result[0] == 0;
        _meetingStatus = _isInitialized ? 'SDK Initialized' : 'Failed to initialize SDK';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _meetingStatus = 'Error: $e';
      });
    }
  }

  Future<void> _joinMeeting() async {
    if (!_isInitialized) {
      _showSnackBar('Please initialize SDK first');
      return;
    }

    if (_meetingIdController.text.isEmpty) {
      _showSnackBar('Please enter meeting ID');
      return;
    }

    if (_displayNameController.text.isEmpty) {
      _showSnackBar('Please enter display name');
      return;
    }

    try {
      final result = await _zoomPlugin.joinMeeting(ZoomMeetingOptions(
        userId: _displayNameController.text,
        meetingId: _meetingIdController.text,
        meetingPassword: _passwordController.text,
        disableDialIn: 'false',
        disableDrive: 'false',
        disableInvite: 'false',
        disableShare: 'false',
        noDisconnectAudio: 'false',
        noAudio: 'false',
      ));

      if (result) {
        _showSnackBar('Joining meeting...');
      } else {
        _showSnackBar('Failed to join meeting');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _startMeeting() async {
    if (!_isInitialized) {
      _showSnackBar('Please initialize SDK first');
      return;
    }

    if (_meetingIdController.text.isEmpty) {
      _showSnackBar('Please enter meeting ID');
      return;
    }

    try {
      final result = await _zoomPlugin.startMeeting(ZoomMeetingOptions(
        userId: 'host',
        displayName: _displayNameController.text,
        meetingId: _meetingIdController.text,
        meetingPassword: _passwordController.text,
        zoomAccessToken: 'YOUR_ZAK_TOKEN_HERE', // Replace with your ZAK token
        disableDialIn: 'false',
        disableDrive: 'false',
        disableInvite: 'false',
        disableShare: 'false',
        noDisconnectAudio: 'false',
        noAudio: 'false',
      ));

      if (result) {
        _showSnackBar('Starting meeting...');
      } else {
        _showSnackBar('Failed to start meeting');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zoom Meeting SDK Example'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Platform: $_platformVersion'),
                      const SizedBox(height: 8),
                      Text('Status: $_meetingStatus'),
                      const SizedBox(height: 8),
                      Text('Initialized: ${_isInitialized ? "Yes" : "No"}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _initZoomSDK,
                child: const Text('Initialize SDK'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _meetingIdController,
                decoration: const InputDecoration(
                  labelText: 'Meeting ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.meeting_room),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password (optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isInitialized ? _joinMeeting : null,
                      icon: const Icon(Icons.login),
                      label: const Text('Join Meeting'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isInitialized ? _startMeeting : null,
                      icon: const Icon(Icons.video_call),
                      label: const Text('Start Meeting'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _meetingIdController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }
}
