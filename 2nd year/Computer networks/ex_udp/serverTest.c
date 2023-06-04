#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <arpa/inet.h>

int nr_cl = 0, max_port = 0;

int main(int argc, char* argv[]) {
    int s, s2;
    struct sockaddr_in server, client;
    int l, port_nr = atoi(argv[1]);
    char sir[512], charnrC[10], charmaxP[10];


    s = socket(AF_INET, SOCK_DGRAM, 0);
    if (s < 0) {
        printf("Eroare la crearea socketului server\n");
        return 1;
    }

    memset(&server, 0, sizeof(server));
    server.sin_port = htons(atoi(argv[1]));
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;

    if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
        printf("Eroare la bind\n");
        return 1;
    }

    l = sizeof(client);
    memset(&client, 0, sizeof(client));


    while (1) {
        memset((char*)&sir, 0, sizeof(sir));
        recvfrom(s, sir, sizeof(sir), 0, (struct sockaddr*)&client, &l);
        printf("am primit sirul %s\n", sir);
        char* p;
        int sum = 0, nr;
        p = strtok(sir, " ");
        while (p != NULL) {
            nr = atoi(p);
            //printf("%d\n", nr);
            if (nr % 2 == 1) {
                sum = sum + nr;
            }
            p = strtok(NULL, " ");
        }
        
        printf("Suma nr impare este: %d\n", sum);
        int default_port = port_nr + sum;
        if (default_port > max_port)
            max_port = default_port;
        printf("noul port este: %d. Se trimite clientului...\n", default_port);
        sendto(s, &default_port, sizeof(default_port), 0, (struct sockaddr*)&client, sizeof(client));

        //close(s);

        s2 = socket(AF_INET, SOCK_DGRAM, 0);
        if (s2 < 0) {
            printf("Eroare la crearea socketului server\n");
            return 1;
        }

        memset(&server, 0, sizeof(server));
        server.sin_port = htons(default_port);
        server.sin_family = AF_INET;
        server.sin_addr.s_addr = INADDR_ANY;

        if (bind(s2, (struct sockaddr*)&server, sizeof(server)) < 0) {
            printf("Eroare la bind\n");
            return 1;
        }

        sprintf(charnrC, "%d", nr_cl);
        sprintf(charmaxP, "%d", max_port);

        printf("Sending number of prior clients...\n");
        sendto(s2, charnrC, sizeof(charnrC), 0, (struct sockaddr*)&client, sizeof(client));
        nr_cl++;
        printf("Sending maximum number ever sent...\n");
        sendto(s2, charmaxP, sizeof(charmaxP), 0, (struct sockaddr*)&client, sizeof(client));

        close(s2);

        //memset(&server, 0, sizeof(server));
        //server.sin_port = htons(port_nr);
        //server.sin_family = AF_INET;
        //server.sin_addr.s_addr = INADDR_ANY;

    }

    close(s);
}



