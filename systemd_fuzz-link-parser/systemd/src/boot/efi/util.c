/* SPDX-License-Identifier: LGPL-2.1-or-later */

#include <efi.h>
#include <efilib.h>

#include "ticks.h"
#include "util.h"

EFI_STATUS parse_boolean(const CHAR8 *v, BOOLEAN *b) {
        assert(b);

        if (!v)
                return EFI_INVALID_PARAMETER;

        if (streq8((char *) v, "1") || streq8((char *) v, "yes") || streq8((char *) v, "y") ||
            streq8((char *) v, "true") || streq8((char *) v, "t") || streq8((char *) v, "on")) {
                *b = TRUE;
                return EFI_SUCCESS;
        }

        if (streq8((char *) v, "0") || streq8((char *) v, "no") || streq8((char *) v, "n") ||
            streq8((char *) v, "false") || streq8((char *) v, "f") || streq8((char *) v, "off")) {
                *b = FALSE;
                return EFI_SUCCESS;
        }

        return EFI_INVALID_PARAMETER;
}

EFI_STATUS efivar_set_raw(const EFI_GUID *vendor, const CHAR16 *name, const void *buf, UINTN size, UINT32 flags) {
        assert(vendor);
        assert(name);
        assert(buf || size == 0);

        flags |= EFI_VARIABLE_BOOTSERVICE_ACCESS | EFI_VARIABLE_RUNTIME_ACCESS;
        return RT->SetVariable((CHAR16 *) name, (EFI_GUID *) vendor, flags, size, (void *) buf);
}

EFI_STATUS efivar_set(const EFI_GUID *vendor, const CHAR16 *name, const CHAR16 *value, UINT32 flags) {
        assert(vendor);
        assert(name);

        return efivar_set_raw(vendor, name, value, value ? strsize16(value) : 0, flags);
}

EFI_STATUS efivar_set_uint_string(const EFI_GUID *vendor, const CHAR16 *name, UINTN i, UINT32 flags) {
        CHAR16 str[32];

        assert(vendor);
        assert(name);

        /* Note that SPrint has no native sized length specifier and will always use ValueToString()
         * regardless of what sign we tell it to use. Therefore, UINTN_MAX will come out as -1 on
         * 64bit machines. */
        ValueToString(str, FALSE, i);
        return efivar_set(vendor, name, str, flags);
}

EFI_STATUS efivar_set_uint32_le(const EFI_GUID *vendor, const CHAR16 *name, UINT32 value, UINT32 flags) {
        UINT8 buf[4];

        assert(vendor);
        assert(name);

        buf[0] = (UINT8)(value >> 0U & 0xFF);
        buf[1] = (UINT8)(value >> 8U & 0xFF);
        buf[2] = (UINT8)(value >> 16U & 0xFF);
        buf[3] = (UINT8)(value >> 24U & 0xFF);

        return efivar_set_raw(vendor, name, buf, sizeof(buf), flags);
}

EFI_STATUS efivar_set_uint64_le(const EFI_GUID *vendor, const CHAR16 *name, UINT64 value, UINT32 flags) {
        UINT8 buf[8];

        assert(vendor);
        assert(name);

        buf[0] = (UINT8)(value >> 0U & 0xFF);
        buf[1] = (UINT8)(value >> 8U & 0xFF);
        buf[2] = (UINT8)(value >> 16U & 0xFF);
        buf[3] = (UINT8)(value >> 24U & 0xFF);
        buf[4] = (UINT8)(value >> 32U & 0xFF);
        buf[5] = (UINT8)(value >> 40U & 0xFF);
        buf[6] = (UINT8)(value >> 48U & 0xFF);
        buf[7] = (UINT8)(value >> 56U & 0xFF);

        return efivar_set_raw(vendor, name, buf, sizeof(buf), flags);
}

EFI_STATUS efivar_get(const EFI_GUID *vendor, const CHAR16 *name, CHAR16 **value) {
        _cleanup_freepool_ CHAR16 *buf = NULL;
        EFI_STATUS err;
        CHAR16 *val;
        UINTN size;

        assert(vendor);
        assert(name);

        err = efivar_get_raw(vendor, name, (CHAR8**)&buf, &size);
        if (EFI_ERROR(err))
                return err;

        /* Make sure there are no incomplete characters in the buffer */
        if ((size % sizeof(CHAR16)) != 0)
                return EFI_INVALID_PARAMETER;

        if (!value)
                return EFI_SUCCESS;

        /* Return buffer directly if it happens to be NUL terminated already */
        if (size >= sizeof(CHAR16) && buf[size / sizeof(CHAR16) - 1] == 0) {
                *value = TAKE_PTR(buf);
                return EFI_SUCCESS;
        }

        /* Make sure a terminating NUL is available at the end */
        val = xmalloc(size + sizeof(CHAR16));

        memcpy(val, buf, size);
        val[size / sizeof(CHAR16) - 1] = 0; /* NUL terminate */

        *value = val;
        return EFI_SUCCESS;
}

EFI_STATUS efivar_get_uint_string(const EFI_GUID *vendor, const CHAR16 *name, UINTN *i) {
        _cleanup_freepool_ CHAR16 *val = NULL;
        EFI_STATUS err;

        assert(vendor);
        assert(name);
        assert(i);

        err = efivar_get(vendor, name, &val);
        if (!EFI_ERROR(err))
                *i = Atoi(val);

        return err;
}

EFI_STATUS efivar_get_uint32_le(const EFI_GUID *vendor, const CHAR16 *name, UINT32 *ret) {
        _cleanup_freepool_ CHAR8 *buf = NULL;
        UINTN size;
        EFI_STATUS err;

        assert(vendor);
        assert(name);

        err = efivar_get_raw(vendor, name, &buf, &size);
        if (!EFI_ERROR(err) && ret) {
                if (size != sizeof(UINT32))
                        return EFI_BUFFER_TOO_SMALL;

                *ret = (UINT32) buf[0] << 0U | (UINT32) buf[1] << 8U | (UINT32) buf[2] << 16U |
                        (UINT32) buf[3] << 24U;
        }

        return err;
}

EFI_STATUS efivar_get_uint64_le(const EFI_GUID *vendor, const CHAR16 *name, UINT64 *ret) {
        _cleanup_freepool_ CHAR8 *buf = NULL;
        UINTN size;
        EFI_STATUS err;

        assert(vendor);
        assert(name);

        err = efivar_get_raw(vendor, name, &buf, &size);
        if (!EFI_ERROR(err) && ret) {
                if (size != sizeof(UINT64))
                        return EFI_BUFFER_TOO_SMALL;

                *ret = (UINT64) buf[0] << 0U | (UINT64) buf[1] << 8U | (UINT64) buf[2] << 16U |
                        (UINT64) buf[3] << 24U | (UINT64) buf[4] << 32U | (UINT64) buf[5] << 40U |
                        (UINT64) buf[6] << 48U | (UINT64) buf[7] << 56U;
        }

        return err;
}

EFI_STATUS efivar_get_raw(const EFI_GUID *vendor, const CHAR16 *name, CHAR8 **buffer, UINTN *size) {
        _cleanup_freepool_ CHAR8 *buf = NULL;
        UINTN l;
        EFI_STATUS err;

        assert(vendor);
        assert(name);

        l = sizeof(CHAR16 *) * EFI_MAXIMUM_VARIABLE_SIZE;
        buf = xmalloc(l);

        err = RT->GetVariable((CHAR16 *) name, (EFI_GUID *) vendor, NULL, &l, buf);
        if (!EFI_ERROR(err)) {

                if (buffer)
                        *buffer = TAKE_PTR(buf);

                if (size)
                        *size = l;
        }

        return err;
}

EFI_STATUS efivar_get_boolean_u8(const EFI_GUID *vendor, const CHAR16 *name, BOOLEAN *ret) {
        _cleanup_freepool_ CHAR8 *b = NULL;
        UINTN size;
        EFI_STATUS err;

        assert(vendor);
        assert(name);
        assert(ret);

        err = efivar_get_raw(vendor, name, &b, &size);
        if (!EFI_ERROR(err))
                *ret = *b > 0;

        return err;
}

void efivar_set_time_usec(const EFI_GUID *vendor, const CHAR16 *name, UINT64 usec) {
        CHAR16 str[32];

        assert(vendor);
        assert(name);

        if (usec == 0)
                usec = time_usec();
        if (usec == 0)
                return;

        /* See comment on ValueToString in efivar_set_uint_string(). */
        ValueToString(str, FALSE, usec);
        efivar_set(vendor, name, str, 0);
}

static INTN utf8_to_16(const CHAR8 *stra, CHAR16 *c) {
        CHAR16 unichar;
        UINTN len;

        assert(stra);
        assert(c);

        if (!(stra[0] & 0x80))
                len = 1;
        else if ((stra[0] & 0xe0) == 0xc0)
                len = 2;
        else if ((stra[0] & 0xf0) == 0xe0)
                len = 3;
        else if ((stra[0] & 0xf8) == 0xf0)
                len = 4;
        else if ((stra[0] & 0xfc) == 0xf8)
                len = 5;
        else if ((stra[0] & 0xfe) == 0xfc)
                len = 6;
        else
                return -1;

        switch (len) {
        case 1:
                unichar = stra[0];
                break;
        case 2:
                unichar = stra[0] & 0x1f;
                break;
        case 3:
                unichar = stra[0] & 0x0f;
                break;
        case 4:
                unichar = stra[0] & 0x07;
                break;
        case 5:
                unichar = stra[0] & 0x03;
                break;
        case 6:
                unichar = stra[0] & 0x01;
                break;
        }

        for (UINTN i = 1; i < len; i++) {
                if ((stra[i] & 0xc0) != 0x80)
                        return -1;
                unichar <<= 6;
                unichar |= stra[i] & 0x3f;
        }

        *c = unichar;
        return len;
}

CHAR16 *xstra_to_str(const CHAR8 *stra) {
        UINTN strlen;
        UINTN len;
        UINTN i;
        CHAR16 *str;

        assert(stra);

        len = strlen8((const char *) stra);
        str = xnew(CHAR16, len + 1);

        strlen = 0;
        i = 0;
        while (i < len) {
                INTN utf8len;

                utf8len = utf8_to_16(stra + i, str + strlen);
                if (utf8len <= 0) {
                        /* invalid utf8 sequence, skip the garbage */
                        i++;
                        continue;
                }

                strlen++;
                i += utf8len;
        }
        str[strlen] = '\0';
        return str;
}

CHAR16 *xstra_to_path(const CHAR8 *stra) {
        CHAR16 *str;
        UINTN strlen;
        UINTN len;
        UINTN i;

        assert(stra);

        len = strlen8((const char *) stra);
        str = xnew(CHAR16, len + 2);

        str[0] = '\\';
        strlen = 1;
        i = 0;
        while (i < len) {
                INTN utf8len;

                utf8len = utf8_to_16(stra + i, str + strlen);
                if (utf8len <= 0) {
                        /* invalid utf8 sequence, skip the garbage */
                        i++;
                        continue;
                }

                if (str[strlen] == '/')
                        str[strlen] = '\\';
                if (str[strlen] == '\\' && str[strlen-1] == '\\') {
                        /* skip double slashes */
                        i += utf8len;
                        continue;
                }

                strlen++;
                i += utf8len;
        }
        str[strlen] = '\0';
        return str;
}

EFI_STATUS file_read(EFI_FILE *dir, const CHAR16 *name, UINTN off, UINTN size, CHAR8 **ret, UINTN *ret_size) {
        _cleanup_(file_closep) EFI_FILE *handle = NULL;
        _cleanup_freepool_ CHAR8 *buf = NULL;
        EFI_STATUS err;

        assert(dir);
        assert(name);
        assert(ret);

        err = dir->Open(dir, &handle, (CHAR16*) name, EFI_FILE_MODE_READ, 0ULL);
        if (EFI_ERROR(err))
                return err;

        if (size == 0) {
                _cleanup_freepool_ EFI_FILE_INFO *info = NULL;

                err = get_file_info_harder(handle, &info, NULL);
                if (EFI_ERROR(err))
                        return err;

                size = info->FileSize;
        }

        if (off > 0) {
                err = handle->SetPosition(handle, off);
                if (EFI_ERROR(err))
                        return err;
        }

        /* Allocate some extra bytes to guarantee the result is NUL-terminated for CHAR8 and CHAR16 strings. */
        UINTN extra = size % sizeof(CHAR16) + sizeof(CHAR16);

        buf = xmalloc(size + extra);
        err = handle->Read(handle, &size, buf);
        if (EFI_ERROR(err))
                return err;

        /* Note that handle->Read() changes size to reflect the actually bytes read. */
        memset(buf + size, 0, extra);

        *ret = TAKE_PTR(buf);
        if (ret_size)
                *ret_size = size;

        return err;
}

void log_error_stall(const CHAR16 *fmt, ...) {
        va_list args;

        assert(fmt);

        INT32 attr = ST->ConOut->Mode->Attribute;
        ST->ConOut->SetAttribute(ST->ConOut, EFI_LIGHTRED|EFI_BACKGROUND_BLACK);

        if (ST->ConOut->Mode->CursorColumn > 0)
                Print(L"\n");

        va_start(args, fmt);
        VPrint(fmt, args);
        va_end(args);

        Print(L"\n");

        ST->ConOut->SetAttribute(ST->ConOut, attr);

        /* Give the user a chance to see the message. */
        BS->Stall(3 * 1000 * 1000);
}

EFI_STATUS log_oom(void) {
        log_error_stall(L"Out of memory.");
        return EFI_OUT_OF_RESOURCES;
}

void print_at(UINTN x, UINTN y, UINTN attr, const CHAR16 *str) {
        assert(str);
        ST->ConOut->SetCursorPosition(ST->ConOut, x, y);
        ST->ConOut->SetAttribute(ST->ConOut, attr);
        ST->ConOut->OutputString(ST->ConOut, (CHAR16*)str);
}

void clear_screen(UINTN attr) {
        ST->ConOut->SetAttribute(ST->ConOut, attr);
        ST->ConOut->ClearScreen(ST->ConOut);
}

void sort_pointer_array(
                void **array,
                UINTN n_members,
                compare_pointer_func_t compare) {

        assert(array || n_members == 0);
        assert(compare);

        if (n_members <= 1)
                return;

        for (UINTN i = 1; i < n_members; i++) {
                UINTN k;
                void *entry = array[i];

                for (k = i; k > 0; k--) {
                        if (compare(array[k - 1], entry) <= 0)
                                break;

                        array[k] = array[k - 1];
                }

                array[k] = entry;
        }
}

EFI_STATUS get_file_info_harder(
                EFI_FILE *handle,
                EFI_FILE_INFO **ret,
                UINTN *ret_size) {

        UINTN size = offsetof(EFI_FILE_INFO, FileName) + 256;
        _cleanup_freepool_ EFI_FILE_INFO *fi = NULL;
        EFI_STATUS err;

        assert(handle);
        assert(ret);

        /* A lot like LibFileInfo() but with useful error propagation */

        fi = xmalloc(size);
        err = handle->GetInfo(handle, &GenericFileInfo, &size, fi);
        if (err == EFI_BUFFER_TOO_SMALL) {
                free(fi);
                fi = xmalloc(size);  /* GetInfo tells us the required size, let's use that now */
                err = handle->GetInfo(handle, &GenericFileInfo, &size, fi);
        }

        if (EFI_ERROR(err))
                return err;

        *ret = TAKE_PTR(fi);

        if (ret_size)
                *ret_size = size;

        return EFI_SUCCESS;
}

EFI_STATUS readdir_harder(
                EFI_FILE *handle,
                EFI_FILE_INFO **buffer,
                UINTN *buffer_size) {

        EFI_STATUS err;
        UINTN sz;

        assert(handle);
        assert(buffer);
        assert(buffer_size);

        /* buffer/buffer_size are both in and output parameters. Should be zero-initialized initially, and
         * the specified buffer needs to be freed by caller, after final use. */

        if (!*buffer) {
                /* Some broken firmware violates the EFI spec by still advancing the readdir
                 * position when returning EFI_BUFFER_TOO_SMALL, effectively skipping over any files when
                 * the buffer was too small. Therefore, start with a buffer that should handle FAT32 max
                 * file name length.
                 * As a side effect, most readdir_harder() calls will now be slightly faster. */
                sz = sizeof(EFI_FILE_INFO) + 256 * sizeof(CHAR16);
                *buffer = xmalloc(sz);
                *buffer_size = sz;
        } else
                sz = *buffer_size;

        err = handle->Read(handle, &sz, *buffer);
        if (err == EFI_BUFFER_TOO_SMALL) {
                free(*buffer);
                *buffer = xmalloc(sz);
                *buffer_size = sz;
                err = handle->Read(handle, &sz, *buffer);
        }
        if (EFI_ERROR(err))
                return err;

        if (sz == 0) {
                /* End of directory */
                free(*buffer);
                *buffer = NULL;
                *buffer_size = 0;
        }

        return EFI_SUCCESS;
}

BOOLEAN is_ascii(const CHAR16 *f) {
        if (!f)
                return FALSE;

        for (; *f != 0; f++)
                if (*f > 127)
                        return FALSE;

        return TRUE;
}

CHAR16 **strv_free(CHAR16 **v) {
        if (!v)
                return NULL;

        for (CHAR16 **i = v; *i; i++)
                free(*i);

        free(v);
        return NULL;
}

EFI_STATUS open_directory(
                EFI_FILE *root,
                const CHAR16 *path,
                EFI_FILE **ret) {

        _cleanup_(file_closep) EFI_FILE *dir = NULL;
        _cleanup_freepool_ EFI_FILE_INFO *file_info = NULL;
        EFI_STATUS err;

        assert(root);

        /* Opens a file, and then verifies it is actually a directory */

        err = root->Open(root, &dir, (CHAR16*) path, EFI_FILE_MODE_READ, 0ULL);
        if (EFI_ERROR(err))
                return err;

        err = get_file_info_harder(dir, &file_info, NULL);
        if (EFI_ERROR(err))
                return err;
        if (!FLAGS_SET(file_info->Attribute, EFI_FILE_DIRECTORY))
                return EFI_LOAD_ERROR;

        *ret = TAKE_PTR(dir);
        return EFI_SUCCESS;
}

UINT64 get_os_indications_supported(void) {
        UINT64 osind;
        EFI_STATUS err;

        /* Returns the supported OS indications. If we can't acquire it, returns a zeroed out mask, i.e. no
         * supported features. */

        err = efivar_get_uint64_le(EFI_GLOBAL_GUID, L"OsIndicationsSupported", &osind);
        if (EFI_ERROR(err))
                return 0;

        return osind;
}

#ifdef EFI_DEBUG
__attribute__((noinline)) void debug_break(void) {
        /* This is a poor programmer's breakpoint to wait until a debugger
         * has attached to us. Just "set variable wait = 0" or "return" to continue. */
        volatile BOOLEAN wait = TRUE;
        while (wait)
                /* Prefer asm based stalling so that gdb has a source location to present. */
#if defined(__i386__) || defined(__x86_64__)
                asm volatile("pause");
#elif defined(__aarch64__)
                asm volatile("wfi");
#else
                BS->Stall(5000);
#endif
}
#endif

#if defined(__i386__) || defined(__x86_64__)
static inline UINT8 inb(UINT16 port) {
        UINT8 value;
        asm volatile("inb %1, %0" : "=a"(value) : "Nd"(port));
        return value;
}

static inline void outb(UINT16 port, UINT8 value) {
        asm volatile("outb %0, %1" : : "a"(value), "Nd"(port));
}

void beep(UINTN beep_count) {
        enum {
                PITCH                = 500,
                BEEP_DURATION_USEC   = 100 * 1000,
                WAIT_DURATION_USEC   = 400 * 1000,

                PIT_FREQUENCY        = 0x1234dd,
                SPEAKER_CONTROL_PORT = 0x61,
                SPEAKER_ON_MASK      = 0x03,
                TIMER_PORT_MAGIC     = 0xB6,
                TIMER_CONTROL_PORT   = 0x43,
                TIMER_CONTROL2_PORT  = 0x42,
        };

        /* Set frequency. */
        UINT32 counter = PIT_FREQUENCY / PITCH;
        outb(TIMER_CONTROL_PORT, TIMER_PORT_MAGIC);
        outb(TIMER_CONTROL2_PORT, counter & 0xFF);
        outb(TIMER_CONTROL2_PORT, (counter >> 8) & 0xFF);

        UINT8 value = inb(SPEAKER_CONTROL_PORT);

        while (beep_count > 0) {
                /* Turn speaker on. */
                value |= SPEAKER_ON_MASK;
                outb(SPEAKER_CONTROL_PORT, value);

                BS->Stall(BEEP_DURATION_USEC);

                /* Turn speaker off. */
                value &= ~SPEAKER_ON_MASK;
                outb(SPEAKER_CONTROL_PORT, value);

                beep_count--;
                if (beep_count > 0)
                        BS->Stall(WAIT_DURATION_USEC);
        }
}
#endif

EFI_STATUS open_volume(EFI_HANDLE device, EFI_FILE **ret_file) {
        EFI_STATUS err;
        EFI_FILE *file;
        EFI_SIMPLE_FILE_SYSTEM_PROTOCOL *volume;

        assert(ret_file);

        err = BS->HandleProtocol(device, &FileSystemProtocol, (void **) &volume);
        if (err != EFI_SUCCESS)
                return err;

        err = volume->OpenVolume(volume, &file);
        if (err != EFI_SUCCESS)
                return err;

        *ret_file = file;
        return EFI_SUCCESS;
}

EFI_STATUS make_file_device_path(EFI_HANDLE device, const char16_t *file, EFI_DEVICE_PATH **ret_dp) {
        EFI_STATUS err;
        EFI_DEVICE_PATH *dp;

        assert(file);
        assert(ret_dp);

        err = BS->HandleProtocol(device, &DevicePathProtocol, (void **) &dp);
        if (err != EFI_SUCCESS)
                return err;

        EFI_DEVICE_PATH *end_node = dp;
        while (!IsDevicePathEnd(end_node))
                end_node = NextDevicePathNode(end_node);

        size_t file_size = strsize16(file);
        size_t dp_size = ((uint8_t *) end_node - (uint8_t *) dp) + END_DEVICE_PATH_LENGTH;

        /* Make a copy that can also hold a file media device path. */
        *ret_dp = xmalloc(dp_size + file_size + SIZE_OF_FILEPATH_DEVICE_PATH);
        memcpy(*ret_dp, dp, dp_size);

        /* Point dp to the end node of the copied device path. */
        dp = (EFI_DEVICE_PATH *) ((uint8_t *) *ret_dp + dp_size - END_DEVICE_PATH_LENGTH);

        /* Replace end node with file media device path. */
        FILEPATH_DEVICE_PATH *file_dp = (FILEPATH_DEVICE_PATH *) dp;
        file_dp->Header.Type = MEDIA_DEVICE_PATH;
        file_dp->Header.SubType = MEDIA_FILEPATH_DP;
        memcpy(&file_dp->PathName, file, file_size);
        SetDevicePathNodeLength(&file_dp->Header, SIZE_OF_FILEPATH_DEVICE_PATH + file_size);

        dp = NextDevicePathNode(dp);
        SetDevicePathEndNode(dp);
        return EFI_SUCCESS;
}
