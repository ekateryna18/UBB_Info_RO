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
    int c, slen = sizeof(server), client, nr;
    char buf[512], bufr[512], nrcl[512];


    c = socket(AF_INET, SOCK_DGRAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    memset((char*)&server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    sendto(c, &buf, sizeof(buf), 0, (struct sockaddr*)&server, slen);

    recvfrom(c, &nrcl, sizeof(nrcl), 0, (struct sockaddr*)&client, &slen);
    nr = atoi(nrcl);
    printf("Nr: %s %d", nrcl, nr);

    if (nr % 2 == 1) {
        printf("Sir = \n");
        gets(buf);
        sendto(c, &buf, sizeof(buf), 0, (struct sockaddr*)&server, slen);

        printf("Waiting data from server...\n");
        recvfrom(c, &bufr, sizeof(bufr), 0, (struct sockaddr*)&client, &slen);
        printf("Port received: %s \n", bufr);
    }
    else if (nr % 2 == 0) {

    }
    close(c);
    return 0;
}