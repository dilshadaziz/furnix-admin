import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:furnix_admin/utils/validator/form_validator.dart';

// ignore: must_be_immutable
class FormContainerWidget extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  bool isPassword = false;
  bool fetchLocation = false;
  TextEditingController? passwordController;

  FormContainerWidget({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.inputType,
    required this.isPassword,
    this.fetchLocation = false,
    this.passwordController,
  });

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.hintText == 'Full name'
          ? [FilteringTextInputFormatter.deny(RegExp(r'[a-z]'))]
          : widget.hintText == 'Email address' || widget.isPassword
              ? [FilteringTextInputFormatter.deny(RegExp(r' '))]
              : null,
      textCapitalization: widget.hintText == 'Full name'
          ? TextCapitalization.characters
          : TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.inputType == TextInputType.phone
          ? 10
          : widget.inputType == TextInputType.streetAddress
              ? 33
              : widget.inputType == TextInputType.number ? 6 : null,
      buildCounter: widget.inputType == TextInputType.phone
          ? (context,
              {required currentLength,
              required isFocused,
              required maxLength}) {
              return Text("$currentLength/$maxLength");
            }
          : null,
      validator: (value) {
        if (widget.hintText == 'Confirm Password') {
          return formValidator(
              value: value,
              hintText: widget.hintText,
              passwordController: widget.passwordController!.text);
        }
        return formValidator(value: value, hintText: widget.hintText);
      },
      keyboardType: widget.inputType,
      controller: widget.controller,
      obscureText: widget.isPassword ? isObscureText : false,
      decoration: InputDecoration(
          suffix: widget.fetchLocation
              ? GestureDetector(
                  child: const Icon(Icons.my_location_rounded),
                  onTap: () {},
                )
              : null,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(widget.icon),
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(isObscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                )
              : null),
    );
  }
}
