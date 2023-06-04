#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <arpa/inet.h>

int main(int argc, char* argv[]) {
    int c;
    struct sockaddr_in server;
    char sir[512];

    c = socket(AF_INET, SOCK_DGRAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }

    memset(&server, 0, sizeof(server));
    server.sin_port = htons(atoi(argv[1]));
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr(argv[2]);

    int l = sizeof(server);

    printf("introduceti un sir: ");
    gets(sir);
    sendto(c, sir, sizeof(sir), 0, (struct sockaddr*)&server, sizeof(server));

    int default_port;
    char maxport[10], nrcl[10];
    recvfrom(c, &default_port, sizeof(default_port), 0, (struct sockaddr*)&server, &l);
    printf("am primit noul port %d de la server.\n", default_port);

    server.sin_port = htons(default_port);

    recvfrom(c, &nrcl, sizeof(nrcl), 0, (struct sockaddr*)&server, &l);
    printf("Received number of prior clients: %s\n", nrcl);
    recvfrom(c, &maxport, sizeof(maxport), 0, (struct sockaddr*)&server, &l);
    printf("Received maximum port number: %s\n", maxport);

    close(c);
}


