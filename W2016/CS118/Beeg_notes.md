# Beej Guide to Socket Programming

### 2.1 What is a Socket?
* a way to speak to other programs using standard Unix file descriptors
* call to socket()
    - returns socket descriptor
    - using send() and recv() socket calls

### 2.2 Two types of Internet Sockets
* Stream sockets `SOCK_STREAM`
    - reliable 2-way connected communication streams
* Datagram sockets `SOCK_DGRAM`
    - connectionless - arrive out of order
    - reasons for using this: speed

### 2.3 Data Encapsulation
1. Application Layer (telnet, ftp)
2. Host-to-Host Transport Layer (TCP, UDP)
3. Internet Layer (IP and routing)
4. Network Access Layer (Ethernet, WiFi)

### 3.1 IP Addresses, ver 4 and 6
* IPv4 (address made of 4 bytes): `192.0.2.111`
* IPv6 (address made of 8 bytes): `::ffff:192.0.2.33`
* Think of IP address as street address of hotel, and port number as room number
* Examples of Port Numbers:
```
HTTP: 80
telnet: 23
SMTP: 25
DOOM (the game): 666
```
* ports from 0 - 1024 are considered special

### Useful functions in C for I/O
1. `snprintf`
 * write formatted output to sized buffer
 * `int sborubtf (char* s, size_t n, const char* format, ...);`
 * Parameters:
     - `s`: pointer to buffer where C-string is stored
     - `n`: max. number of bytes to be used in the buffer
     - `format`: C-string that contains the format string that follows the samespec as format in printf
     - `...(additional args)`: as needed
 * Example:
```
char buffer[100];
int cx;
cx = snprintf(buffer, 100, "The half of %d is %d", 60, 60/2);
if (cx >= 0 && cx < 100)
    snprintf (buffer+cx, 100-cx, ", and the half of that is %d.", 60/2/2);
puts(buffer);
return 0;
```
2. `strcasecmp`
 * `int strcasecmp(const char* f1, const char *f2);`
 * returns an integer `i`:
     - `i > 0`: if lowercase(f1) is greater than lowercase(f2)
     - `i < 0`: if lowercase(f1) is less than lowercase(f2)
     - `i = 0`: if lowercase(f1) is equal to lowercase(f2)
3. `strrchr`
 * return a pointer to th last occurence of _character_ in C-string _str_
 * `const char* strrchr (const char* str, int character);`
 * Parameters:
     - `str`: C-string
     - `character`: Character to be located.
4. `sscanf`
 * read formatted data from string
 * `int sscanf (const char* s, const char* format, ...);`
 * Paramters:
     - `s`: C-string that function processes as its source to retrieve the data
     - `format`: C-string that contains a format string that follows the same spec as format in scanf
     - `...(additional arguments)`: as needed
 * Example:
```
char sentence [] = "Rudolph is 12 years old";
char str [20];
int i;

sscanf(sentence, "%s %*s %d", str, &i);
printf("%s -> %d\n", str, i);
return 0;
```