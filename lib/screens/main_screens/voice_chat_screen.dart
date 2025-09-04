import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:rive/rive.dart' as rive;
import 'package:sysbot3/provider/chatProvider.dart';
import '../../config/colors.dart';
import '../../widgets/custom_switch.dart';
import '../../widgets/dialogs/how_it_works_dialog_chat_screen.dart';
import '../../widgets/dialogs/time_up_dialog.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({
    super.key,
    required this.iconPath,
    required this.quests,
    required this.currentQuest,
    this.iconTopPadding,
  });
  final String iconPath;
  final List<Map<String, dynamic>> quests;
  final String currentQuest;
  final double? iconTopPadding;

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  Timer? _timer;
  int remainingSeconds = 30 * 60; // 30 minutes in seconds
  RxString status = 'stop'.obs;
  bool _timerStarted = false;
  Timer? _mouthTimer;
  // Rive animation controllers
  rive.StateMachineController? _controller;
  rive.SMINumber? _mouthShape;
  final ListController _listController = ListController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateToCurrentQuest();
    });
  }

  String mapQuestToCategory(String questTitle) {
    if (questTitle.contains('Pickup')) return 'Shoot Your Shot';
    if (questTitle.contains('Flex')) return 'Build Confidence';
    if (questTitle.contains('Drip')) return 'Look Good Dress Well';
    if (questTitle.contains('Juice')) return 'Up Your Influence';
    if (questTitle.contains('Goal')) return 'Escape The Matrix';
    return ''; // Hot Topics or general quests map to Ask Me Anything
  }

  void _onRiveInit(rive.Artboard artboard) {
    final controller =
        rive.StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
      _controller = controller;
      final stageInput =
          controller.findInput<double>('stage') as rive.SMINumber?;
      stageInput?.value = 0; // Start with idle
    }
  }

  void updateRiveState(ChatState newState) {
    if (_controller == null) return;

    final stageInput =
        _controller!.findInput<double>('stage') as rive.SMINumber?;

    switch (newState) {
      case ChatState.idle:
        stageInput?.value = 0;
        _stopMouthAnimation();
        break;
      case ChatState.connecting:
        stageInput?.value = 2;
        _stopMouthAnimation();
        break;
      case ChatState.listening:
        stageInput?.value = 1;
        _stopMouthAnimation();

        break;
      case ChatState.processing:
        stageInput?.value = 2;
        _stopMouthAnimation();
        break;
      case ChatState.speaking:
        stageInput?.value = 3;
        _startMouthAnimation();
        break;
    }
  }

  void _startMouthAnimation() {
    _mouthTimer?.cancel();

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final text = chatProvider.lastMessage;

    int index = 0;
    final chars = text.replaceAll(RegExp(r'[^a-zA-Z]'), '').split('');

    _mouthTimer = Timer.periodic(Duration(milliseconds: 120), (timer) {
      if (index >= chars.length) {
        _mouthShape?.value = 0;
        timer.cancel();
        return;
      }

      final char = chars[index];
      final mouthShape = getMouthShapeFromChar(char);
      _mouthShape?.value = mouthShape.toDouble();

      index++;
    });
  }

  void _stopMouthAnimation() {
    _mouthTimer?.cancel();
    _mouthShape?.value = 0; // Reset to idle mouth
  }

  void startTimer() {
    if (_timerStarted) return;
    _timerStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          _timer?.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) => TimeUpDialog(),
          );
        }
      });
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  int getMouthShapeFromChar(String char) {
    switch (char.toLowerCase()) {
      case 'f':
      case 'v':
        return 1;
      case 's':
      case 'c':
      case 'd':
      case 'n':
      case 't':
      case 'x':
      case 'y':
      case 'z':
        return 3;
      case 'b':
      case 'p':
      case 'm':
        return 7;
      case 'e':
        return 4;
      case 'o':
        return 4;
      case 'u':
      case 'q':
      case 'w':
        return 6;
      case 'a':
      case 'i':
      case 'g':
      case 'k':
      case 'r':
        return 8;
      case 'j':
      case 'h':
      case 'l':
      case 'th':
      case 'sh':
      case 'ch':
        return 2;
      default:
        return 1; // idle
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    _scrollController.dispose();
    Provider.of<ChatProvider>(context, listen: false).cancelConversation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Provider.of<ChatProvider>(context, listen: false)
              .cancelConversation();
        }
      },
      child: Scaffold(
        body: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            updateRiveState(chatProvider.state);
            status.value = chatProvider.state == ChatState.idle
                ? 'stop'
                : chatProvider.state.toString().split('.').last;

            // Start timer based on ChatProvider state
            if ((chatProvider.state == ChatState.listening ||
                    chatProvider.state == ChatState.speaking) &&
                !_timerStarted) {
              startTimer();
            }
            if (chatProvider.state == ChatState.idle && _timerStarted) {
              _timer?.cancel();
              _timerStarted = false;
              remainingSeconds = 30 * 60;
            }

            // Disable tone toggle during speaking
            bool isToneToggleEnabled = chatProvider.state != ChatState.speaking;

            return Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/voice-chat-bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              chatProvider.cancelConversation();
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/images/arrow-back-icon.png',
                              width: 18,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 130,
                            height: 48,
                            decoration: BoxDecoration(
                              color:
                                  AppColors.mediumGrey.withValues(alpha: 0.24),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset(
                                  'assets/images/ball-with-gradient-bg.png',
                                  width: 36,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  formatTime(remainingSeconds),
                                  style: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontFamily: 'SFDigital',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 45),
                          Padding(
                            padding: EdgeInsets.only(
                                top: widget.iconTopPadding ?? 0),
                            child: Image.asset(widget.iconPath, width: 25),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => howItWorksDialogChatScreen(context),
                            child: Image.asset(
                              'assets/images/fa-question-circle-icon.png',
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: height * 0.52,
                      child: Stack(
                        children: [
                          Container(
                            height: height * 0.52,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: rive.RiveAnimation.asset(
                              'assets/animations/123roboomouthrig.riv',
                              onInit: _onRiveInit,
                              fit: BoxFit.cover, // Changed from BoxFit.cover
                              stateMachines: const ['State Machine 1'],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: width,
                              height: 45,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black,
                                    spreadRadius: 2,
                                    blurRadius: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              height: 45,
                              child: SuperListView.builder(
                                listController: _listController,
                                controller: _scrollController,
                                padding: const EdgeInsets.only(left: 20),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.quests.length,
                                itemBuilder: (context, index) {
                                  final title = widget.quests[index]['title'];
                                  final isLocked =
                                      widget.quests[index]['isLocked'] ?? false;
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      height: 38,
                                      margin: const EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        color: title == widget.currentQuest
                                            ? AppColors.themeClr
                                            : null,
                                        borderRadius:
                                            BorderRadius.circular(5.57),
                                        border: Border.all(
                                          color: AppColors.black,
                                          width: 2.75,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.white
                                                .withValues(alpha: 0.19),
                                            offset: const Offset(4.18, 4.18),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Visibility(
                                            visible: isLocked,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4, bottom: 2),
                                              child: Image.asset(
                                                'assets/images/lock-icon.png',
                                                width: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            title.split('→').last.trim(),
                                            style: TextStyle(
                                              fontFamily: 'ReservationWide',
                                              color: AppColors.white.withValues(
                                                alpha: isLocked ? 0.7 : 1,
                                              ),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 20,
                            child: Transform.scale(
                              scale: 1.2,
                              child: CustomSwitch(
                                value: chatProvider.tone == ChatTone.genZ,
                                onChanged: (bool newValue) {
                                  chatProvider.toggleTone();
                                },
                                isEnabled: isToneToggleEnabled,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomRow(status: status),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (status.value == 'stop') {
                          chatProvider.startConversation();
                        } else if (status.value == 'speaking') {
                          chatProvider.cancelConversation();
                        } else {
                          chatProvider.cancelConversation();
                        }
                      },
                      child: Obx(() => Image.asset(
                            status.value.toLowerCase() == 'stop'
                                ? 'assets/images/shoot-icon-with-bg.png'
                                : 'assets/images/stop-icon-with-bg.png',
                            width: 105,
                          )),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _animateToCurrentQuest() {
    final index = widget.quests.indexWhere(
      (quest) => quest['title'] == widget.currentQuest,
    );
    if (index != -1) {
      _listController.animateToItem(
        index: index,
        scrollController: _scrollController,
        alignment: 0.5, // Center item in viewport
        duration: (distance) => Duration(milliseconds: 300),
        curve: (distance) => Curves.easeInOut,
      );
    }
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.status});
  final RxString status;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Image.asset(
                status.value == 'connecting'
                    ? 'assets/images/processing-icon.png'
                    : status.value == 'listening'
                        ? 'assets/images/ear-icon.png'
                        : status.value == 'processing'
                            ? 'assets/images/processing-icon.png'
                            : status.value == 'speaking'
                                ? 'assets/images/speaking-icon.png'
                                : 'assets/images/ball.png',
                width: 14,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              status.value == 'connecting'
                  ? 'CONNECTING...'
                  : status.value == 'listening'
                      ? 'LISTENING...'
                      : status.value == 'processing'
                          ? 'PROCESSING...'
                          : status.value == 'speaking'
                              ? 'SPEAKING...'
                              : 'TAP SHOOT TO TALK',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontFamily: 'SFCompactRounded',
              ),
            ),
          ],
        ));
  }
}
