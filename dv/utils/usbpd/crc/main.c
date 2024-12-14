#include <stdio.h>

int crc;

void crcBits(int x, int len) {

    const int poly = 0x04C11DB6;
    
    int newbit, newword, r1_crc;

    for(int i = 0; i < len; i++) {
        newbit = ((crc >> 31) ^ ((x >> i) & 1)) & 1;
        if(newbit) newword=poly; else newword=0;
        r1_crc
}
