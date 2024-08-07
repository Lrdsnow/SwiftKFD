//
//  proc.h
//  kfd
//
//  Created by Seo Hyun-gyu on 2023/07/29.
//

#include <stdio.h>
#include <_types/_uint64_t.h>
#include <sys/_types/_pid_t.h>

uint64_t getProc(pid_t pid);
uint64_t getProcByName(char* nm);
int getPidByName(char* nm);

int funProc(uint64_t proc);
