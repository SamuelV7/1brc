
dev:
   clang -Wall -Werror -fsanitize=address main.c -o main

dev-no-asan:
   clang -S -O0 -Wall -Werror main.c -o main.asm

dev-asm:
   clang -S -Wall -Werror -fsanitize=address main.c -o main.asm

# no sanitize
prod-asm:
   clang -S -O2 -Wall -Werror main.c -o main-release.asm
