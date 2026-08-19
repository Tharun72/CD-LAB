/*
 * Experiment 9: Implement simple code optimization techniques
 * (Constant Folding, Strength Reduction, Algebraic Transformation)
 * on a list of three-address-code statements.
 *
 * Author: Abijith U
 * Reg No : 24CS0021
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LINES 100
#define MAX_LEN 100

int is_number(char *s) {
    if (*s == '\0') return 0;
    for (int i = 0; s[i]; i++) {
        if (!isdigit(s[i])) return 0;
    }
    return 1;
}

/* --- Constant Folding: t = 4 + 2  ->  t = 6 --- */
int constant_folding(char *line, char *out) {
    char lhs[MAX_LEN], op1[MAX_LEN], operator[3], op2[MAX_LEN];
    if (sscanf(line, "%[^ ] = %[^ ] %[+*/-] %[^ ;]", lhs, op1, operator, op2) == 4) {
        if (is_number(op1) && is_number(op2)) {
            int a = atoi(op1), b = atoi(op2), result = 0;
            int folded = 1;
            if (strcmp(operator, "+") == 0) result = a + b;
            else if (strcmp(operator, "-") == 0) result = a - b;
            else if (strcmp(operator, "*") == 0) result = a * b;
            else if (strcmp(operator, "/") == 0 && b != 0) result = a / b;
            else folded = 0;

            if (folded) {
                sprintf(out, "%s = %d;", lhs, result);
                return 1;
            }
        }
    }
    return 0;
}

/* --- Strength Reduction: t = x * 2  ->  t = x + x   |   t = x * 2  -> t = x << 1 --- */
int strength_reduction(char *line, char *out) {
    char lhs[MAX_LEN], op1[MAX_LEN], operator[3], op2[MAX_LEN];
    if (sscanf(line, "%[^ ] = %[^ ] %[+*/-] %[^ ;]", lhs, op1, operator, op2) == 4) {
        if (strcmp(operator, "*") == 0) {
            if (strcmp(op2, "2") == 0 && !is_number(op1)) {
                sprintf(out, "%s = %s + %s;   /* strength reduction: x*2 -> x+x */", lhs, op1, op1);
                return 1;
            }
            if (is_number(op2)) {
                int val = atoi(op2);
                /* Check if power of 2 */
                if (val > 0 && (val & (val - 1)) == 0 && val != 2) {
                    int shift = 0, v = val;
                    while (v > 1) { v >>= 1; shift++; }
                    sprintf(out, "%s = %s << %d;   /* strength reduction: x*%d -> x<<%d */", lhs, op1, shift, val, shift);
                    return 1;
                }
            }
        }
        if (strcmp(operator, "/") == 0 && is_number(op2)) {
            int val = atoi(op2);
            if (val > 0 && (val & (val - 1)) == 0 && val != 1) {
                int shift = 0, v = val;
                while (v > 1) { v >>= 1; shift++; }
                sprintf(out, "%s = %s >> %d;   /* strength reduction: x/%d -> x>>%d */", lhs, op1, shift, val, shift);
                return 1;
            }
        }
    }
    return 0;
}

/* --- Algebraic Transformation: t = x + 0 -> t = x ; t = x * 1 -> t = x ; t = x * 0 -> t = 0 --- */
int algebraic_transformation(char *line, char *out) {
    char lhs[MAX_LEN], op1[MAX_LEN], operator[3], op2[MAX_LEN];
    if (sscanf(line, "%[^ ] = %[^ ] %[+*/-] %[^ ;]", lhs, op1, operator, op2) == 4) {
        if (strcmp(operator, "+") == 0 && strcmp(op2, "0") == 0) {
            sprintf(out, "%s = %s;   /* algebraic: x+0 -> x */", lhs, op1);
            return 1;
        }
        if (strcmp(operator, "*") == 0 && strcmp(op2, "1") == 0) {
            sprintf(out, "%s = %s;   /* algebraic: x*1 -> x */", lhs, op1);
            return 1;
        }
        if (strcmp(operator, "*") == 0 && strcmp(op2, "0") == 0) {
            sprintf(out, "%s = 0;   /* algebraic: x*0 -> 0 */", lhs);
            return 1;
        }
        if (strcmp(operator, "-") == 0 && strcmp(op2, "0") == 0) {
            sprintf(out, "%s = %s;   /* algebraic: x-0 -> x */", lhs, op1);
            return 1;
        }
    }
    return 0;
}

char* optimize_line(char *line) {
    static char out[MAX_LEN];
    if (constant_folding(line, out)) return out;
    if (algebraic_transformation(line, out)) return out;
    if (strength_reduction(line, out)) return out;
    strcpy(out, line);  /* no optimization applicable */
    return out;
}

int main() {
    char *code[] = {
        "t1 = 4 + 2;",
        "t2 = a + 0;",
        "t3 = b * 1;",
        "t4 = c * 0;",
        "t5 = x * 2;",
        "t6 = y * 8;",
        "t7 = z / 4;",
        "t8 = d - 0;",
        "t9 = 10 * 5;",
        "t10 = e + f;"
    };
    int n = sizeof(code) / sizeof(code[0]);

    printf("===== Code Optimization: Original vs Optimized =====\n\n");
    printf("%-25s %-40s\n", "Original", "Optimized");
    printf("%-25s %-40s\n", "--------", "---------");
    for (int i = 0; i < n; i++) {
        char *result = optimize_line(code[i]);
        printf("%-25s %-40s\n", code[i], result);
    }

    return 0;
}
