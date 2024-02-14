// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:final_proj/aut_states.dart';
// import 'package:final_proj/auth_cubit.dart';

// class ForgetPasswordPage extends StatelessWidget {
//   final TextEditingController _emailController;

//   const ForgetPasswordPage(this._emailController, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is AuthSuccess) {
//           // Show a success message
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Password reset email sent'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         } else if (state is AuthFailure) {
//           // Show an error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: state is AuthLoading
//                       ? null
//                       : () {
//                           // Send a password reset email to the user
//                           context
//                               .read<AuthCubit>()
//                               .resetPassword(_emailController.text);
//                         },
//                   child: const Text('Send Email'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }