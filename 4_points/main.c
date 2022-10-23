#include <stdio.h>
int main() {
  int n = 0;
  while (n <= 0 || n >= 10000) {
    printf("Введите число обьектов в массиве (от 1 до 10000): ");
    scanf("%d", &n);
  }
  int A[n];
  int B[n-1];
  for(int i = 0; i < n; ++i) {
      printf("Введите A[%d]: ", i);
      scanf("%d", &A[i]);
  }
  printf("Ответ:\n");
  for (int i = 0; i < n-1; ++i) {
    B[i] = A[i] + A[i+1];
  }
  printf("A[%d] = ", n);
  for(int i = 0; i < n; ++i) {
    printf("%d ", A[i]);
  }
  printf("\nB[%d] = ", n-1);
  for(int i = 0; i < n-1; ++i) {
    printf("%d ", B[i]);
  }
  return 0;
}
