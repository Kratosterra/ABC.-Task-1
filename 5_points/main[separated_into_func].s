	.file	"main_f.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \321\207\320\270\321\201\320\273\320\276 \320\276\320\261\321\214\320\265\320\272\321\202\320\276\320\262 \320\262 \320\274\320\260\321\201\321\201\320\270\320\262\320\265 (\320\276\321\202 1 \320\264\320\276 10000): "
.LC1:
	.string	"%d"
	.text
	.globl	get_number_of_elements
	.type	get_number_of_elements, @function
# Функция get_number_of_elements возвращает значение n в С.
get_number_of_elements:
	# get_number_of_elements()
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	# А это локальная n, будем хранить ее в -12 по стеку;
	# int n = 0;
	mov	DWORD PTR -12[rbp], 0
	# while
	jmp	.L2
.L3:
    # Печатаем запрос на ввод n.
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# Получаем n.
	lea	rax, -12[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
.L2:
    # Пока в n не будет подходящее значение будем запрашивать его снова и снова.
	mov	eax, DWORD PTR -12[rbp]
	test	eax, eax
	jle	.L3
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, 9999
	jg	.L3
	# Возвращаем значение n в регистре eax.
	mov	eax, DWORD PTR -12[rbp]
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L5
	call	__stack_chk_fail@PLT
# OK.
.L5:
	leave
	ret
	.size	get_number_of_elements, .-get_number_of_elements
	.section	.rodata
.LC2:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 A[%d]: "
	.text
	.globl	get_elements_A
	.type	get_elements_A, @function

# Функция get_elements_A заполняет значениями массив A, получая ссылку на A(rdi) и размер n (esi).
get_elements_A:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	# Ссылка на массив A теперь будет хранится в -24 по стеку.
	mov	QWORD PTR -24[rbp], rdi
	# А n по ссылке из esi будет хранится в -28 по стеку.
	mov	DWORD PTR -28[rbp], esi
	# Звнуляем i в -4 по стеку, int i = 0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L7
.L8:
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	# Печатаем запрос на ввод элемента массива A
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# &A[i]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	# Получаем элемент A[i]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	# i++
	add	DWORD PTR -4[rbp], 1
.L7:
	# Засовываем i в eax и сравниваем с n в -28 по стеку
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L8
    # OK.
	nop
	nop
	leave
	ret
	.size	get_elements_A, .-get_elements_A
	.globl	fill_elements_B
	.type	fill_elements_B, @function
# Функция fill_elements_B заполняет значениями массив B, получая ссылку на A (rdi) и B (rsi) и размер n (edx).
fill_elements_B:
	endbr64
	push	rbp
	mov	rbp, rsp
	# Получаем ссылку на A в -24 по стеку.
	mov	QWORD PTR -24[rbp], rdi
	# Получаем ссылку на B в -32 по стеку.
	mov	QWORD PTR -32[rbp], rsi
    # n помещаем в -36 по стеку
	mov	DWORD PTR -36[rbp], edx
	# int i = 0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L10
.L11:
    # A[i]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	ecx, DWORD PTR [rax]
	# A[i+1]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	# B[i]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rsi, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rsi
	# A[i] + A[i+1]
	add	edx, ecx
	# B[i] = A[i] + A[i+1]
	mov	DWORD PTR [rax], edx
	# i++
	add	DWORD PTR -4[rbp], 1
.L10:
    # Засовываем i в eax и сравниваем с n в -28 по стеку (вычитаем 1)
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -4[rbp], eax
	jl	.L11
    # OK.
	nop
	nop
	pop	rbp
	ret
	.size	fill_elements_B, .-fill_elements_B
	.section	.rodata
.LC3:
	.string	"%d "
	.text
	.globl	print_elements
	.type	print_elements, @function
# Функция print_elements печатает массив, получая ссылку на него (rdi) и размер n (esi).
print_elements:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	# Получаем ссылку на A в -24 по стеку.
	mov	QWORD PTR -24[rbp], rdi
	# n помещаем в -28 по стеку
	mov	DWORD PTR -28[rbp], esi
	# int i = 0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L13
.L14:
    # A[i]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	# Печатаем эллемент.
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L13:
    # Засовываем i в eax и сравниваем с n в -28 по стеку
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L14
    # OK.
	nop
	nop
	leave
	ret
	.size	print_elements, .-print_elements
	.section	.rodata
.LC4:
	.string	"\320\236\321\202\320\262\320\265\321\202:"
.LC5:
	.string	"A[%d] = "
.LC6:
	.string	"\nB[%d] = "
	.text
	.globl	main
	.type	main, @function
# start. Возвращает 0 в статусе при системном вызове.
main:
    mov %rbp, %rsp #for correct debugging
	endbr64
	# Оформляем подготовку запуска main()
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 88
	# OK
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	mov	rax, rsp
	mov	rbx, rax
	mov	eax, 0
    # Получаем размер массива A в n, будем использовать это значения и для массива B, с уменьшением на 1. 
	call	get_number_of_elements
	# n сейчас хранится в eax, поэтому поместим n в -92 по стеку
	mov	DWORD PTR -92[rbp], eax
	mov	eax, DWORD PTR -92[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	# Начинаем создание массива A
	mov	QWORD PTR -88[rbp], rdx
	movsx	rdx, eax
	mov	QWORD PTR -112[rbp], rdx
	mov	QWORD PTR -104[rbp], 0
	movsx	rdx, eax
	mov	QWORD PTR -128[rbp], rdx
	mov	QWORD PTR -120[rbp], 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L16:
	cmp	rsp, rdx
	je	.L17
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L16
.L17:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L18
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L18:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	# Сохраняем ссылку на массив на стеке.
	mov	QWORD PTR -80[rbp], rax
	# n-1
	mov	eax, DWORD PTR -92[rbp]
	sub	eax, 1
	# Создаем массив B
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -72[rbp], rdx
	movsx	rdx, eax
	mov	r14, rdx
	mov	r15d, 0
	movsx	rdx, eax
	mov	r12, rdx
	mov	r13d, 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	edi, 16
	mov	edx, 0
	div	rdi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L19:
	cmp	rsp, rdx
	je	.L20
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L19
.L20:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L21
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L21:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	# Сохраняем ссылку на массив на стеке.
	mov	QWORD PTR -64[rbp], rax
	# Получим элементы массива A с помощью n (eax)
	mov	edx, DWORD PTR -92[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	get_elements_A
	# Печатаем "Ответ"
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT
	# Начинаем получение эллементов B
	mov	edx, DWORD PTR -92[rbp]
	mov	rcx, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	rsi, rcx
	mov	rdi, rax
    # Получим элементы массива B с помощью n-1 (eax) и регистра (eax) (-92 по стеку)
	call	fill_elements_B
	# Засовываем n из -92 по стеку в eax для печати A[n] =
	mov	eax, DWORD PTR -92[rbp]
	mov	esi, eax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	edx, DWORD PTR -92[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	esi, edx
	mov	rdi, rax
    # Печатаем массив A.
	call	print_elements
	# Засовываем n из -92 по стеку в eax для печати B[n-1] =
	mov	eax, DWORD PTR -92[rbp]
	# n-1
	sub	eax, 1
	mov	esi, eax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	# Печатаем B[n-1] = .
	call	printf@PLT
	# Готовимся к печати эллементов массива B.
	mov	eax, DWORD PTR -92[rbp]
	lea	edx, -1[rax]
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, edx
	mov	rdi, rax
    # Печатаем массив B.
	call	print_elements
	# return 0;
	mov	eax, 0
	mov	rsp, rbx
	mov	rdx, QWORD PTR -56[rbp]
	sub	rdx, QWORD PTR fs:40
    # OK.
	je	.L23
	call	__stack_chk_fail@PLT
.L23:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
