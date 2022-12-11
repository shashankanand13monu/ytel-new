import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? height;
  final String? labelName;
  final String? hintName;
  final TextEditingController? fieldController;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final EdgeInsets? margin;
  final Function(String)? onChange;
  final bool readOnly;
  final Color? color;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Widget? suffix;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final bool? showPassword;

  const CustomTextField(
      {Key? key,
        this.fieldController,
        this.prefix,
        this.prefixIcon,
        this.hintName,
        this.margin,
        this.maxLength,
        this.maxLines,
        this.minLines,
        this.height,
        this.labelName,
        this.textInputFormatter,
        this.keyboardType,
        required this.readOnly,
        this.validator,
        this.onTap,
        this.onChange,
        this.color,
        this.onSaved,
        this.onFieldSubmitted,
        this.onEditingComplete,
        this.suffix,
        this.suffixIcon,
        this.focusNode,
        this.textStyle,
        this.showPassword,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      // padding: EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: ColorHelper.primaryTextColor),
        color: color,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Colors.black45.withOpacity(0.1),
          ),
        ],
      ),

      child: TextFormField(
        focusNode: focusNode,
        maxLength: maxLength,
        maxLines: maxLines,
        onTap: onTap,
        validator: validator,
        readOnly: readOnly,
        keyboardType: keyboardType,
        inputFormatters: textInputFormatter,
        controller: fieldController,
        onChanged: onChange,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        obscureText: showPassword == null ? false : !showPassword!,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffix,
          suffixIcon: suffixIcon,
          hintText: hintName,
          labelText: labelName,
          labelStyle: const TextStyle(
            letterSpacing: -0.32,
            fontSize: 18,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
          hintStyle: const TextStyle(
            letterSpacing: -0.32,
            fontSize: 18,
            fontStyle: FontStyle.normal,
            // fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          contentPadding: prefixIcon != null ? const EdgeInsets.only(top: 3, right: 15,) : const EdgeInsets.only(left: 15, right: 15, bottom: 7),
        ),
        style: textStyle ?? const TextStyle(
          // letterSpacing: -0.32,
          fontSize: 18,
          // fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        autocorrect: true,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {

  final String name;
  final double height;
  final double width;
  final Color color;
  final Function() onTap;

  const CustomButton({Key? key,
    required this.name,
    required this.height,
    required this.width,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPageButton extends StatelessWidget {

  final Function() onTap;
  final IconData icon;

  const CustomPageButton({Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: FaIcon(
          icon,
          color: Colors.black.withOpacity(.7),
          size: 20,
        ),
      ),
    );
  }
}
