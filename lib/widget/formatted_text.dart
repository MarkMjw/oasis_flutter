import 'package:flutter/widgets.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:oasis_flutter/config/color_config.dart';

class FormattedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;

  final parse = <MatchText>[
    MatchText(
      pattern: r"@([\u4e00-\u9fa5A-Za-z0-9]+)",
      renderWidget: ({required pattern, required text}) => Text(
        text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 16,
          color: ColorConfig.commonColorHighlight,
        ),
      ),
      onTap: (String username) {
        print(username.substring(1));
      },
    ),
    MatchText(
      pattern: r"#([\u4e00-\u9fa5A-Za-z0-9]+)",
      renderWidget: ({required pattern, required text}) => Text(
        text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 16,
          color: ColorConfig.commonColorHighlight,
        ),
      ),
      onTap: (String username) {
        print(username.substring(1));
      },
    ),
  ];

  FormattedText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return ParsedText(
      text: text,
      style: style ?? defaultTextStyle.style,
      alignment: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection ?? Directionality.of(context),
      overflow: TextOverflow.clip,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      parse: parse,
      regexOptions: RegexOptions(caseSensitive: false),
    );
  }
}
