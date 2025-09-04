import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isEnabled;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.isEnabled,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.isEnabled
              ? () {
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
                  widget.value == false
                      ? widget.onChanged(true)
                      : widget.onChanged(false);
                }
              : null,
          child: Container(
            width: 77,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: widget.isEnabled
                  ? _circleAnimation.value == Alignment.centerLeft
                      ? Color(0xff1e1e1e)
                      : Color(0xff5221FF)
                  : Colors.grey.withOpacity(0.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Tone\n',
                                  style: TextStyle(
                                    fontFamily: 'SFProCompressed',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'GenZ',
                                  style: TextStyle(
                                    fontFamily: 'SFProCompressed',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _circleAnimation.value == Alignment.centerRight
                            ? Color(0xff1e1e1e)
                            : Color(0xff5221FF),
                      ),
                      child: Center(
                          child: Image.asset(
                              _circleAnimation.value == Alignment.centerRight
                                  ? "assets/images/smiling-face-emoji.png"
                                  : "assets/images/robot.png",
                              width: 18,
                              height: 18)),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9),
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Tone\n',
                                  style: TextStyle(
                                    fontFamily: 'SFProCompressed',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Chill',
                                  style: TextStyle(
                                    fontFamily: 'SFProCompressed',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CustomSwitch2 extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isEnabled;

  const CustomSwitch2({
    super.key,
    required this.value,
    required this.onChanged,
    required this.isEnabled,
  });

  @override
  State<CustomSwitch2> createState() => _CustomSwitch2State();
}

class _CustomSwitch2State extends State<CustomSwitch2>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.isEnabled
              ? () {
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
                  widget.value == false
                      ? widget.onChanged(true)
                      : widget.onChanged(false);
                }
              : null,
          child: Container(
            width: 95,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              // Switch on & off color and gradient.
              color: widget.isEnabled
                  ? _circleAnimation.value == Alignment.centerLeft
                      ? Color(0xff1e1e1e)
                      : Color(0xff5221FF)
                  : Colors.grey.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _circleAnimation.value == Alignment.centerRight
                    ? Padding(
                        padding: EdgeInsets.only(left: 6, top: 6, bottom: 6),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Tone\n',
                                  style: TextStyle(
                                    fontFamily: 'SFProCompressed',
                                    letterSpacing: 1.1,
                                    color: Colors.grey.shade200,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: 'GenZ',
                                  style: TextStyle(
                                    fontFamily: 'SFProCompressed',
                                    color: Colors.white,
                                    height: 0.9,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _circleAnimation.value == Alignment.centerRight
                            ? Color(0xff1e1e1e)
                            : Color(0xff5221FF),
                      ),
                      child: Center(
                          child: Image.asset(
                              _circleAnimation.value == Alignment.centerRight
                                  ? "assets/images/smiling-face-emoji.png"
                                  : "assets/images/robot.png",
                              width: 18,
                              height: 18)),
                    ),
                  ),
                ),
                _circleAnimation.value == Alignment.centerLeft
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tone\n',
                                style: TextStyle(
                                  fontFamily: 'SFProCompressed',
                                  letterSpacing: 1.1,
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                              TextSpan(
                                text: 'Chill',
                                style: TextStyle(
                                  fontFamily: 'SFProCompressed',
                                  color: Colors.white,
                                  height: 0.9,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
