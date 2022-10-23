#include <stdio.h>
#include <time.h>

int get_number_of_elements() {
  int n = 0;
  while (n <= 0 || n >= 10000) {
    printf("Введите число обьектов в массиве (от 1 до 10000): ");
    scanf("%d", &n);
  }
  return n;
}

void get_elements_A(int A[], int n) {
  for(int i = 0; i < n; ++i) {
      printf("Введите A[%d]: ", i);
      scanf("%d", &A[i]);
  }
}

void fill_elements_B(int A[], int B[], int n) {
  for (int i = 0; i < n-1; ++i) {
    B[i] = A[i] + A[i+1];
  }
}

void print_elements(int A[], int n) {
  for(int i = 0; i < n; ++i) {
    printf("%d ", A[i]);
  }
}

void print_elements_file(int B[], int n, char **argv) {
  printf("Ответ в файле вывода!\n");
  FILE *f = fopen(argv[2],"w+");
  fprintf(f,"B[%d] = ", n-1);
  for(int i = 0; i < n-1; i++){
    fprintf(f,"%d, ", B[i]);
  }
  fclose(f);
}

void get_elements_file_A(int A[], char **argv) {
  int n = 0;
  FILE *f = fopen(argv[1], "r");
  int i = 0;
  int num = 0;
  fscanf(f, "%d : ", &n);
  while(fscanf(f, "%d, ", &num) > 0 && i < n)
  {
      A[i++] = num;
  }
  fclose(f);
}

int get_numbers_of_elements_file(char **argv) {
  int n = 0;
  FILE *f = fopen(argv[1], "r");
  fscanf(f, "%d: ", &n);
  fclose(f);
  return n;
}

int generate_input_n() {
  srand(time(0));
  int n = 1 + rand() % 30;
  return n;
}

void generate_A(int A[], int n) {
  for (size_t i = 0; i < n; i++) {
    A[i] = 1 + rand() % 1000;
  }
  return A;
}

int get_type_of_input() {
  int t = 0;
  while (t <= 0 || t > 2) {
    printf("Введите число (1 или 2): ");
    scanf("%d", &t);
  }
  printf("\n");
  return t;
}


int main(int argc, char **argv) {
  int n = 0;
  int type = 0;
  if (argc != 3 && argc != 1 && argc != 2) {
    puts("Неверное количество параметров, их всегда 1 - [-g] (генерация) или 2 - входной и выходной файл");
    return 1;
  } else if (argc == 3) {
    n = get_numbers_of_elements_file(argv);
  } else if (argc == 2) {
    n = generate_input_n();
  } else {
    printf("Выберете тип ввода.\n-----------\n1) Вручную\n2) Автоматически\n");
    type = get_type_of_input();
    if (type == 1) {
      n = get_number_of_elements();
    } else {
      n = generate_input_n();
    }
  }
  int A[n];
  int B[n-1];
  if (argc == 3) {
    get_elements_file_A(A, argv);
  } else {
    if (argc == 2) {
      generate_A(A, n);
    } else if (type == 2) { 
      generate_A(A, n);
    } else {
      get_elements_A(A, n);
    }
  }
  clock_t begin = clock();
  // Увеличиваем время исполнения!
  for (size_t i = 0; i < 1000; i++)
  {
    fill_elements_B(A, B, n);
  }
  clock_t end = clock();
  double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  printf("Время исполнения программы: %f\n", time_spent);
  printf("Ответ:\n");
  if (argc == 3) {
    print_elements_file(B, n, argv);
  } else {
    printf("A[%d] = ", n);
    print_elements(A, n);
    printf("\nB[%d] = ", n-1);
    print_elements(B, n-1);
  }
  return 0;
}
