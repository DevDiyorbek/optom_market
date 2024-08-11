class Solution {
  List productExceptSelf(List<int> nums) {
    var answer = [];
    var multiplier = 1;
    var hasZero = false;

    for (var i = 0; i < nums.length; i++) {
      if (nums[i] != 0) {
        multiplier = multiplier * nums[i];
      } else {
        hasZero = true;
      }
    }

    if (!hasZero) {
      for (var n = 0; n < nums.length; n++) {
        answer.add(multiplier ~/ nums[n]);
      }
    } else {
      for (var n = 0; n < nums.length; n++) {
        if (nums[n] == 0) {
          answer.add(multiplier);
        } else {
          answer.add(0);
        }
      }
    }
    return answer;
  }
}

void main() {
  Solution solution = Solution();
  solution.productExceptSelf([-1, 1, 0, -3, 3]);
}
