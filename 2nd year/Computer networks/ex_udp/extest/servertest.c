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
    int c, l,port =1234, nr_cl = 0;
    char buf1[512], buf2[512], nrcl[512];

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
        nr_cl++;
        memset((char*)&buf1, 0, sizeof(buf1));
        recvfrom(s, &buf1, sizeof(buf1), 0, (struct sockaddr*)&client, &l);
        printf("Connected with %s :%d\n", inet_ntoa(client.sin_addr), ntohs(client.sin_port));

        memset((char*)&nrcl, 0, sizeof(nrcl));
        sprintf(nrcl, "%d", nr_cl);
        printf("Nr cl: %s\n", nrcl);
        sendto(s, &nrcl, sizeof(nrcl), 0, (struct sockaddr*)&client, l);

        if (nr_cl % 2 == 1) {

            memset((char*)&buf1, 0, sizeof(buf1));
            recvfrom(s, &buf1, sizeof(buf1), 0, (struct sockaddr*)&client, &l);
            printf("Received packet from %s :%d\n", inet_ntoa(client.sin_addr), ntohs(client.sin_port));
            printf("Data: %s\n", buf1);
            char* p;
            int sum = 0, nr;
            p = strtok(buf1, " ");
            while (p != NULL) {
                nr = atoi(p);
                sum = sum + nr;
                p = strtok(NULL, " ");
            }
            printf("Sum = %d\n", sum);
            memset((char*)&buf2, 0, sizeof(buf2));
            printf("Port nr: \n");
            scanf("%s", &buf2);
            port = atoi(buf2);
            sendto(s, &buf2, sizeof(buf2), 0, (struct sockaddr*)&client, l);
        }
        else if (nr_cl % 2 == 0) {
            printf("Sending port to client: %d\n");
        }
    }


    close(s);
    return 0;
}