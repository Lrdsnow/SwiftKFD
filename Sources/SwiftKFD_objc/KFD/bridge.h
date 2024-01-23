//
//  bridge.h
//  
//
//  Created by Lrdsnow on 1/22/24.
//

#include <Foundation/Foundation.h>
#include "fun/mdc/helpers.h"

void xpc_crash(NSString *task);
void overwriteFile2(NSString *from, NSString *to);
void overwriteFileVar(NSString *from, NSString *to);

uint64_t do_kopen(uint64_t puaf_pages, uint64_t puaf_method, uint64_t kread_method, uint64_t kwrite_method, size_t headroom);

void backboard_respring(void) {
    xpc_crasher("com.apple.cfprefsd.daemon");
    xpc_crasher("com.apple.backboard.TouchDeliveryPolicyServer");
}

void respring(void) {
    xpc_crasher("com.apple.frontboard.systemappservices");
}
