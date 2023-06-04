/*Un client trimite unui server un sir de caractere si doua numere(fie acestea s, i, l).
Serverul va returna clientului subsirul de lungime l a lui s care incepe la pozitia i.*/
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
//#include <time.h>
//#include <stdlib.h>

void deservire_client(int c) {
    uint16_t a, b, suma;
    char sir[100], subsir[100];
    
    printf("S-a conectat un client.\n");
    // deservirea clientului
    recv(c, sir, sizeof(sir), MSG_WAITALL);
    recv(c, &a, sizeof(a), MSG_WAITALL);
    recv(c, &b, sizeof(b), MSG_WAITALL);
    a = ntohs(a);
    b = ntohs(b);
    printf("a= %hu, b= %hu\n", a, b);
    strcpy(sir, sir + a);
    strncpy(subsir, sir, b);
    printf("Trimit la client %s\n", subsir);
    int len = strlen(subsir);
    len = htonl(len);
    send(c, &len, sizeof(len), 0);
    send(c, subsir, strlen(subsir), 0);

    close(c);
}

int main() {
    int s,c;
    struct sockaddr_in server, client;
    char buffer[1024];
    int l;
    
    s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) {
        printf("Eroare la crearea socketului server\n");
        return 1;
    }

    memset(&server, 0, sizeof(server));
    server.sin_port = htons(1234);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;

    if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
        printf("Eroare la bind\n");
        return 1;
    }

    listen(s, 5);
    //srand(time(0));
    //x= (rand() % 6);// de la 0 la 5
    //x= (rand() % 6)+1;// de la 1 la 6

    l = sizeof(client);
   // uint l = sizeof(struct sockaddr_in);

    memset(&client, 0, sizeof(client));
//ignora exit statusul proceserol copil
    while (1) {
        //signal(SIGCHLD, SIG_IGN);
        c = accept(s, (struct sockaddr*)&client, &l);

        if (fork() == 0) {
            deservire_client(c);
	        return 0;
        }
        
    }
	//close(s);

    //return 0;
}
