// import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final bool? obscureText;
//   final TextInputType keyboardType;
//   final Widget icon;
//   final String lableText;
//   final FormFieldValidator? validator;
//   final Function onChanged;

//   const CustomTextField(
//       {Key? key,
//       required this.keyboardType,
//       required this.icon,
//       required this.lableText,
//       this.validator,
//       required this.onChanged, 
//       this.obscureText,})
//       : super(key: key);

//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//                         // style: const TextStyle(
//                         //   fontSize: 20,
//                         // ),
//                         obscureText: widget.obscureText,
//                         keyboardType: TextInputType.visiblePassword,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(10),
//                           suffixIcon: suffixIcon,
//                           icon: icon,,
//                           labelText: labelText,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         validator: widget.validator,
//                         onChanged: widget.onChanged,
//                       );
//   }
// }
