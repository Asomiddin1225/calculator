

// import 'dart:io';
// import 'package:expressions/expressions.dart';

// void main() {
//   // Foydalanuvchidan matematik ifoda kiritishni so'raymiz
//   stdout.write("Misol kirting: ");
//   String? misol = stdin.readLineSync();

//   if (misol != null) {
//     try {
//       // Kirish ifodasini Expression formatiga aylantirish
//       final expression = Expression.parse(misol);
//       final evaluator = const ExpressionEvaluator();

//       // Ifodani hisoblash
//       var result = evaluator.eval(expression, {});
//       // Hisoblangan natijani chiqarish
//       print("Natija: $result");
//     } catch (e) {
//       // Agar xato bo'lsa, xato haqida xabar berish
//       print("Xato: $e");
//     }
//   } else {
//     // Agar foydalanuvchi hech narsa kiritmasa, xabar berish
//     print("Iltimos, biror matematik ifoda kiriting.");
//   }
// }





//=================================================




// import 'dart:io';

// void main() {
//   // Foydalanuvchidan matematik ifoda kiritishni so'raymiz
//   stdout.write("Misol kiriting (Masalan: 2 + 3): ");
//   String? misol = stdin.readLineSync();

//   if (misol != null) {
//     try {
//       // Kiritilgan ifodani ajratish
//       List<String> parts = misol.split(' '); // Bo'sh joy orqali ajratamiz
//       if (parts.length != 3) {
//         throw FormatException("Noto'g'ri format. Iltimos, 2 + 2 kabi kiriting.");
//       }

//       // Sonlarni ajratamiz va operatorni olamiz
//       double num1 = double.parse(parts[0]);
//       String operator = parts[1];
//       double num2 = double.parse(parts[2]);

//       // Hisoblashni amalga oshiramiz
//       double result;
//       switch (operator) {
//         case '+':
//           result = num1 + num2;
//           break;
//         case '-':
//           result = num1 - num2;
//           break;
//         case '*':
//           result = num1 * num2;
//           break;
//         case '/':
//           if (num2 == 0) throw Exception("Bo'lish nolga bo'linmaydi.");
//           result = num1 / num2;
//           break;
//         default:
//           throw Exception("Noto'g'ri operator. Faqat +, -, *, / ishlatishingiz mumkin.");
//       }

//       // Natijani chiqaramiz
//       print("Natija: $result");
//     } catch (e) {
//       print("Xato: $e");
//     }
//   } else {
//     print("Iltimos, biror matematik ifoda kiriting.");
//   }
// }








//=====================================================






import 'dart:io';

void main() {
  stdout.write("Matematik ifodani kiriting (masalan: 2+2*(20/5)-2): ");
  String? misol = stdin.readLineSync();

  if (misol != null) {
    try {
      // Kiruvchi ifodani tozalash va hisoblash
      double result = eval(misol.replaceAll(' ', ''));
      print("Natija: $result");
    } catch (e) {
      print("Xato: $e");
    }
  } else {
    print("Iltimos, matematik ifoda kiriting.");
  }
}

// Hisoblash funktsiyasi
double eval(String expression) {
  // Qavs ichidagi ifodalarni hal qilish
  while (expression.contains('(')) {
    int startIndex = expression.lastIndexOf('(');
    int endIndex = expression.indexOf(')', startIndex);
    if (endIndex == -1) throw FormatException("Noto'g'ri qavslar.");

    // Qavs ichidagi ifodani hisoblaymiz
    String subExpression = expression.substring(startIndex + 1, endIndex);
    double subResult = eval(subExpression);

    // Qavslarni almashtiramiz
    expression = expression.replaceRange(startIndex, endIndex + 1, subResult.toString());
  }

  // Hisoblash jarayoni
  return calculate(expression);
}



// Oddiy matematik amal hisoblash
double calculate(String expression) {
  // * va / amallari ustuvorligini bajaramiz
  List<String> parts = splitByOperators(expression, ['*', '/']);
  double result = double.parse(parts[0]);

  for (int i = 1; i < parts.length; i += 2) {
    String operator = parts[i];
    double value = double.parse(parts[i + 1]);

    if (operator == '*') {
      result *= value;
    } else if (operator == '/') {
      if (value == 0) throw Exception("Nolga bo'lish mumkin emas.");
      result /= value;
    }
  }

  // + va - amallarini bajaramiz
  parts = splitByOperators(result.toString(), ['+', '-']);
  result = double.parse(parts[0]);

  for (int i = 1; i < parts.length; i += 2) {
    String operator = parts[i];
    double value = double.parse(parts[i + 1]);

    if (operator == '+') {
      result += value;
    } else if (operator == '-') {
      result -= value;
    }
  }

  return result;
}

// Ifodani operatorlar bo'yicha ajratish
List<String> splitByOperators(String expression, List<String> operators) {
  List<String> parts = [];
  String currentPart = '';
  for (int i = 0; i < expression.length; i++) {
    String char = expression[i];
    if (operators.contains(char)) {
      parts.add(currentPart);
      parts.add(char);
      currentPart = '';
    } else {
      currentPart += char;
    }
  }
  parts.add(currentPart);
  return parts;
}
