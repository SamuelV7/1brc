// #include <cstring>
#include <stddef.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

// writing my own arena alloc
typedef struct {
    uint8_t *data;
    size_t cap; // max capacity index
    size_t cursor; // index of curr pos
} Arena;

void *arena_malloc_init(Arena *a, const size_t size) {
    // use malloc but can switch
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

// void *arena_init(Arena *a, const size_t length) {
//     a->data = mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_PRIVATE, -1, 0);
//     if (a->data)
// }

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
    // add some correction if arena is null and cap is null
    char *ptr = (char *) alloc_arena(a, cap, 1);
    ptr[0] = '\0';
    return (StringArray){
        .cap = cap,
        .len = 0,
        .ptr = ptr,
        .arena = a,
    };
}

typedef struct {
    char *start_ptr;
    size_t len;
} StringSlice;

StringSlice new_slice() {
    StringSlice ss = {
        .start_ptr = NULL,
        .len = 0,
    };
    return ss;
}

bool make_slice(const StringArray str_arr, const size_t start, StringSlice *out) {
    // if slice is null
    if (out == NULL) return false;
    // check bounds
    if (start > str_arr.cap) return false;
    *out = (StringSlice){
        .start_ptr = str_arr.ptr + start,
        .len = str_arr.len - start,
    };
    return true;
}
// not copied (gives pointer)
char *get_char(const StringSlice *str_slice) {
    if (str_slice == NULL) return NULL;
    return str_slice->start_ptr;
}

char *get_char_cp(const StringSlice *slice, Arena *a) {
    char *result = alloc_arena(a, slice->len +1, 1);
    // error with alloc arena (alignment issues or something)
    if (result == NULL) return NULL;
    memcpy(result, slice->start_ptr, slice->len);
    result[slice->len] = '\0';
    return result;
}

void print_string(StringArray s_arr) {
    // start is ptr, end is len
    printf("(%s)",s_arr.ptr);
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

    // checking string slices
    StringSlice ss = new_slice();
    StringSlice *ss_ptr = &ss;

    bool slice_res = make_slice(s_arr, 7, ss_ptr);
    if (!slice_res) {
        printf("\n failed to create string");
        return 1;
    }
    char *res = get_char_cp(ss_ptr, &arena);
    printf("\n Res: %s", res);
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
