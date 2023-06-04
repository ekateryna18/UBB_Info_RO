//Un client trimite unui server doua numere.Serverul va returna clientului suma celor doua numere.
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <arpa/inet.h>
#include <string.h>

int main() {
    int s;
    struct sockaddr_in server, client;
    int c, l, buf_len, port = 1234;
    char buf[512],sir[512], bufr[512];

    s = socket(AF_INET, SOCK_DGRAM, 0);
    if (s < 0) {
        printf("Eroare la crearea socketului server\n");
        return 1;
    }

    memset((char*)&server, 0, sizeof(server));
    server.sin_port = htons(port);
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
        memset((char*)&buf, 0, sizeof(buf));
        recvfrom(s, &buf, sizeof(buf), 0, (struct sockaddr*)&client, &l);
        printf("Received packet from %s:%d\n", inet_ntoa(client.sin_addr), ntohs(client.sin_port));
        printf("Data: %s\n", buf);
        port = atoi(buf);
        memset((char*)&sir, 0, sizeof(sir));
        recvfrom(s, &sir, sizeof(sir), 0, (struct sockaddr*)&client, &l);
        printf("Received 'sir' %s\n", sir);

        for (int i = 0; i < strlen(sir); i++)
        {
            sir[i] = 'z' - (sir[i] - 'a');
        }

        close(s);

        s = socket(AF_INET, SOCK_DGRAM, 0);
        if (s < 0) {
            printf("Eroare la crearea socketului server\n");
            return 1;
        }

        memset((char*)&server, 0, sizeof(server));
        server.sin_port = htons(port);
        server.sin_family = AF_INET;
        server.sin_addr.s_addr = INADDR_ANY;

        if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
            printf("Eroare la bind\n");
            return 1;
        }
        memset(&client, 0, sizeof(client));

        printf("Waiting request from client to send on diff port\n");
        recvfrom(s, &bufr, sizeof(bufr), 0, (struct sockaddr*)&client, &l);
        printf("%s", bufr);

        printf("Sending data: %s\n", sir);
        sendto(s, &sir, sizeof(sir), 0, (struct sockaddr*)&client, l);
    }


    close(s);
    return 0;
}