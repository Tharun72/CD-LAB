#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LINE 100

int is_number(char *s) {
    if (*s == '\0') return 0;
    for (int i = 0; s[i]; i++) if (!isdigit(s[i])) return 0;
    return 1;
}

void emit_operand(char *operand) {
    if (is_number(operand)) {
        printf("    MOV AX, %s\n", operand);
    } else {
        printf("    MOV AX, %s\n", operand);
    }
}

void generate_code(char *line) {
    char lhs[50], op1[50], operator[3], op2[50];
    int n = sscanf(line, "%[^ ] = %[^ ] %[+*/-] %[^ ;]", lhs, op1, operator, op2);

    printf("; TAC: %s\n", line);

    if (n == 4) {
        printf("    MOV AX, %s\n", op1);
        if (strcmp(operator, "+") == 0) {
            printf("    MOV BX, %s\n", op2);
            printf("    ADD AX, BX\n");
        } else if (strcmp(operator, "-") == 0) {
            printf("    MOV BX, %s\n", op2);
            printf("    SUB AX, BX\n");
        } else if (strcmp(operator, "*") == 0) {
            printf("    MOV BX, %s\n", op2);
            printf("    MUL BX\n");
        } else if (strcmp(operator, "/") == 0) {
            printf("    MOV BX, %s\n", op2);
            printf("    XOR DX, DX\n");
            printf("    DIV BX\n");
        }
        printf("    MOV %s, AX\n\n", lhs);
    } else {
        /* simple assignment: x = y */
        char lhs2[50], rhs[50];
        if (sscanf(line, "%[^ ] = %[^ ;]", lhs2, rhs) == 2) {
            printf("    MOV AX, %s\n", rhs);
            printf("    MOV %s, AX\n\n", lhs2);
        }
    }
}

int main(int argc, char **argv) {
    FILE *fp = stdin;
    if (argc > 1) {
        fp = fopen(argv[1], "r");
        if (!fp) { printf("Cannot open file\n"); return 1; }
    }

    char line[MAX_LINE];
    printf("===== 8086 Assembly Code Generation from Three Address Code =====\n\n");
    printf(".MODEL SMALL\n.DATA\n");
    printf("    ; declare variables as needed (WORD, 2 bytes each)\n");
    printf(".CODE\nMAIN PROC\n    MOV AX, @DATA\n    MOV DS, AX\n\n");

    while (fgets(line, MAX_LINE, fp)) {
        /* strip newline */
        line[strcspn(line, "\n")] = 0;
        if (strlen(line) == 0) continue;
        generate_code(line);
    }

    printf("    MOV AH, 4CH\n    INT 21H\nMAIN ENDP\nEND MAIN\n");

    if (fp != stdin) fclose(fp);
    return 0;
}
