#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

// writing my own arena alloc
typedef struct {
    uint8_t *data;
    size_t cap; // max capacity index
    size_t cursor; // index of curr pos
} Arena;

void *arena_malloc_init(Arena *a, const size_t size) {
    // use malloc
    a->data = malloc(size);
    if (a->data == NULL) {
        a->cap = 0;
        a->cursor = 0;
        return NULL;
    }
    a->cap = size;
    a->cursor = 0;
    return a->data;
}

// maybe make a stack allocated arena malloc

void *alloc_arena(Arena *a, const size_t size, const size_t alignment) {
    if (alignment == 0) {
        return NULL;
    }
    // current address pointer
    const uintptr_t base = (uintptr_t)a->data;
    const uintptr_t curr_addr = base + a->cursor;
    // padding calculation, gives how many bytes to pad index tho
    const size_t padding = (alignment - (curr_addr % alignment)) % alignment;
    const size_t aligned = a->cursor + padding;

    if (aligned > a->cap) {
        return NULL;
    }
    if (size > a->cap - aligned) {
        return NULL;
    }
    // update arenas cursor
    a->cursor = aligned + size;
    void *ptr = (void*) (padding+curr_addr);
    return ptr;
}

typedef struct {
    char *ptr;
    size_t len;
    size_t cap;
    Arena *arena;
} StringArray;

StringArray string_init(Arena *a, const size_t cap) {
    return (StringArray){
        .cap = cap,
        .len = 0,
        .ptr = (char *) alloc_arena(a, cap, 1),
        .arena = a,
    };
}

void print_string(StringArray s_arr) {
    // start is ptr, end is len
    printf("(%s)",s_arr.ptr);
}

bool push(const char c, const StringArray *arr) {
    *(arr->ptr + arr->len) = c;
    return true;
}

bool append(StringArray *arr, char *c) {
    char *curr = c;
    uint16_t temp_len = 0;
    // next pointer
    char *next = curr + 1;
    while (*curr != '\0') {
        // if it was too big it would fail this doesn't address the fact that string
        // may not have been null terminated so gotta deal with that,
        // but it should return NULL cause of the len being higher than String Array length.
        if (arr->len + temp_len > arr-> cap) {
            return false;
        }
        temp_len += 1;
        curr = next;
        next = curr + 1;
    }
    if (*next == '\0') {
        temp_len += 1;
    }
    // now add the last pointer into the string
    char *added = arr->ptr + arr->len;
    memcpy(added, c, temp_len);
    return true;
}

bool append_string_arr(StringArray *arr, const char *c) {
    // get length safe function
    const size_t length = strnlen(c, arr->cap);
    if (arr->len >= arr->cap) {
        return false;
    }
    if (length > (arr->cap - arr->len)-1) {
        return false;
    }
    memmove(arr->ptr+arr->len, c, length+1);
    arr->len += length;
    return true;
}

int main(){
    //char buffer[100];
    // get_file(&buffer);
    // printf("%s", buffer);
    Arena arena = {0};
    arena_malloc_init(&arena, 700);
    alloc_arena(&arena, 200, 1);
    StringArray s_arr = string_init(&arena, 75);
    bool append_success = append_string_arr(&s_arr, "when the music fades\0");
    if (!append_success) {
        printf("\n failed to add string");
        return 1;
    }
    print_string(s_arr);
    printf("\n soli deo gloria, string & arena alloc");
}

void get_file(char(*buffer)[100]) {
    FILE *fptr = fopen("./upstream-1brc/measurements.txt", "r");
    if (fptr == NULL) {
        printf("Error opening file\n");
    }
    const size_t ret = fread(*buffer, 1, sizeof(*buffer) - 1, fptr);
    if (ret < 1) {
        printf("Error reading file\n");
    }
    (*buffer)[ret] = '\0';
}
