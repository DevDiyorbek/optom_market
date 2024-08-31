// import 'dart:io';
// class Solution {
//   List<List<int>> distinctPairs(List<int> numbers) {
//     final Set<List<int>> uniquePairs = {};
//
//     for (int i = 0; i < numbers.length; i++) {
//       for (int j = i + 1; j < numbers.length; j++) {
//         // Create a pair (numbers[i], numbers[j])
//         final pair = [numbers[i], numbers[j]];
//
//         // Add the pair to the set (automatically handles duplicates)
//         uniquePairs.add(pair);
//       }
//     }
//
//     // Convert the set back to a list
//     return uniquePairs.toList();
//   }
// }
//
// void main() {
//   Solution solution = Solution();
//   final List<int> inputNumbers = [1, 1, 1, 2];
//   final List<List<int>> result = solution.distinctPairs(inputNumbers);
//
//   print('Distinct Pairs:');
//   for (final pair in result) {
//     print(pair);
//   }
// }
