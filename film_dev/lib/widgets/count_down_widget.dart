import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  ProgressPainter({
    @required this.animation,
    @required this.backgroundColor,
    @required this.color,
  }) : super(repaint: animation);

  /// Animation representing what we are painting
  final Animation<double> animation;

  /// The color in the background of the circle
  final Color backgroundColor;

  /// The foreground color used to indicate progress
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);
    paint.color = color;
    canvas.drawRect(Rect.fromLTRB(0, 0, animation.value*size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(ProgressPainter other) {
    return animation.value != other.animation.value ||
        color != other.color ||
        backgroundColor != other.backgroundColor;
  }
}

class CountDownWidget extends StatefulWidget {
   final int countDownSeconds;
   final String label;

  CountDownWidget({Key key,this.countDownSeconds,this.label}):super(key: key);
  _CountDownWidgetState createState() => new _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  bool isPlaying;
  String get timeRemaining {
    Duration duration = _controller.duration * _controller.value;
    return '${duration.inMinutes} : ${(duration.inSeconds % 60)
        .toString()
        .padLeft(2, '0')}';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.countDownSeconds),
    )..reverse(from: 1.0);
    _controller.stop();
  }

  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return  new InkWell(
        onLongPress: (){
          _controller.stop();
          _controller.reverse(
            from: 1.0,
          );
          _controller.stop();
          setState(() {
            isPlaying = false;
          });
        },
        onTap: (){
          if (_controller.isAnimating){
            _controller.stop(canceled: false);
            setState(() {
              isPlaying = false;
            });}
          else {
            _controller.reverse(
              from: _controller.value == 0.0 ? 1.0 : _controller
                  .value,
            );
            setState(() {
             isPlaying = true;
            });
          }
        },
        child: new Align(
          alignment: FractionalOffset.center,
          child: new Stack(
            children: <Widget>[
              new Positioned.fill(
                child: new AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget child) {
                      return new CustomPaint(
                        painter: new ProgressPainter(
                          animation: _controller,
                          color: themeData.cardColor,
                          backgroundColor: themeData.accentColor,
                        ),
                      );
                    }
                ),
              ),
              new Align(
                alignment: FractionalOffset.center,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    new AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget child) {
                          return new Text(
                            timeRemaining,
                            style: themeData.textTheme.title,
                          );
                        }
                    ),],
                ),
              ),
            ],
          ),
        ),
      );
  }
}