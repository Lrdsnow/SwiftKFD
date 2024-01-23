//
//  lrdsnow.m
//  PureKFD
//
//  Created by Lrdsnow on 8/25/23.
//

#import <Foundation/Foundation.h>
#import "vnode.h"
#import "krw.h"
#import "mdc/helpers.h"
#import "thanks_opa334dev_htrowii.h"

// Ez functions:
void removeFileName(char* path) {
    char* lastSlash = strrchr(path, '/'); // Find the last slash in the path

    if (lastSlash != NULL) {
        *lastSlash = '\0'; // Replace the last slash with null terminator
    }
}

const char* getFilename(const char* path) {
    const char* lastSlash = strrchr(path, '/'); // Find the last slash in the path
    
    if (lastSlash != NULL) {
        return lastSlash + 1; // Return the string after the last slash
    }
    
    return path; // If no slash found, return the whole path as the filename
}

char* getPathWithoutFilename(const char* path) {
    char* newPath = strdup(path); // Create a copy of the original path
    removeFileName(newPath);
    return newPath;
}

void xpc_crash(NSString *task) {
    xpc_crasher(task.UTF8String);
}

void overwriteFile2(NSString *from, NSString *to) {
    funVnodeOverwrite2(to.UTF8String, from.UTF8String);
}
