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
    int c, slen = sizeof(server), client;
    char buf[512], bufr[512];


    c = socket(AF_INET, SOCK_DGRAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    memset((char *) & server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");
    //l = sizeof(server);
    printf("a = \n");
    scanf("%s", &buf);
    sendto(c, &buf, sizeof(buf), 0, (struct sockaddr*)&server, slen);
    printf("Data 'a' sent\nb = \n");
    scanf("%s", buf);
    sendto(c, &buf, sizeof(buf), 0, (struct sockaddr*)&server, slen);

    printf("Waiting sum from server...\n");
    recvfrom(c, &bufr, sizeof(bufr), 0, (struct sockaddr*)&client, &slen);
    printf("Data received from server: %s \n", bufr);

    close(c);
    return 0;
}