//Un client trimite unui server doua numere.Serverul va returna clientului suma celor doua numere.
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <arpa/inet.h>

int main() {
    struct sockaddr_in server;
    int c, slen = sizeof(server), client, port = 1234;
    char buf[512], bufr[512], sir[512];


    c = socket(AF_INET, SOCK_DGRAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    memset((char*)&server, 0, sizeof(server));
    server.sin_port = htons(port);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    printf("Port nou = \n");
    scanf("%s",buf);
    sendto(c, &buf, sizeof(buf), 0, (struct sockaddr*)&server, slen);

    printf("Data 'port' sent\n");
    printf("Sir : \n");
    scanf("%s", sir);
    sendto(c, &sir, sizeof(sir), 0, (struct sockaddr*)&server, slen);

    port = atoi(buf);
    close(c);

    c = socket(AF_INET, SOCK_DGRAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }
    memset((char*)&server, 0, sizeof(server));
    server.sin_port = htons(port);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    strcpy(sir, "OK");
    printf("%s", sir);
    sendto(c, &sir, sizeof(sir), 0, (struct sockaddr*)&server, slen);

    printf("Waiting data from server...\n");
    recvfrom(c, &bufr, sizeof(bufr), 0, (struct sockaddr*)&client, &slen);
    printf("Data received from server: %s \n", bufr);

    close(c);
    return 0;
}