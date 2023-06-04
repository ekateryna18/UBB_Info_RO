//Un client trimite unui server doua numere.Serverul va returna clientului suma celor doua numere.
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <arpa/inet.h>

int main() {
    int s;
    struct sockaddr_in server, client;
    int c, l, a,b,suma;
    char buf1[512], buf2[512], buf3[512];

    s = socket(AF_INET, SOCK_DGRAM, 0);
    if (s < 0) {
        printf("Eroare la crearea socketului server\n");
        return 1;
    }

    memset((char *) & server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;

    if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
        printf("Eroare la bind\n");
        return 1;
    }

    l = sizeof(client);
    memset(&client, 0, sizeof(client));

    while (1) {
        printf("Waiting for data...\n");
        memset((char*)&buf1, 0, sizeof(buf1));
        recvfrom(s, &buf1, sizeof(buf1), 0, (struct sockaddr*)&client, &l);
        printf("Received packet from %s :%d\n", inet_ntoa(client.sin_addr), ntohs(client.sin_port));

        memset((char*)&buf2, 0, sizeof(buf2));
        recvfrom(s, &buf2, sizeof(buf2), 0, (struct sockaddr*)&client, &l);
        printf("Received packet from %s :%d\n", inet_ntoa(client.sin_addr), ntohs(client.sin_port));

        a = atoi(buf1);
        b = atoi(buf2);
        printf("Data: a= %d b= %d\n", a, b);
        suma = a + b;
        memset((char*)&buf3, 0, sizeof(buf3));
        sprintf(buf3, "%d", suma);
        printf("Sending sum: %s\n", buf3);
        sendto(s, &buf3, sizeof(buf3), 0, (struct sockaddr*)&client, l);
    }
    

    close(s);
    return 0;
}