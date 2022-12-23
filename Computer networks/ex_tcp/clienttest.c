#include <stdio.h>
#include <sys/types.h>
#include<sys/socket.h>
#include<string.h>
#include<netinet/ip.h>
#include<netinet/in.h>
#include<stdlib.h>
#include<time.h>
#include <unistd.h>
#include <arpa/inet.h>

int main() {
	int c;
	struct sockaddr_in serverAddr;

	c = socket(AF_INET, SOCK_STREAM, 0);
	memset(&serverAddr, 0, sizeof(serverAddr));
	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(8888);
	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

	if (connect(c, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
		printf("Eroare la connect\n");
		return 1;
	}

	uint16_t id, idj;
	char l;
	recv(c, &idj, sizeof(idj), MSG_WAITALL);
	recv(c, &id, sizeof(id), MSG_WAITALL);
	printf("Am primit idjoc  %d \n", idj);
	printf("Am primit id %d \n", id);

	//client 1
	if (id % 2 == 1)
	{
		recv(c, &l, sizeof(l), MSG_WAITALL);
		printf("Am primit litera %c \n", l);
		
		char cuv[100], l_nou;
		printf("introduceti litera noua: \n");
		scanf("%c", &l_nou);
		printf("introduceti cuvant nou: \n");
		scanf("%s", &cuv);
		printf("am citit %s %c \n", cuv, l_nou);
		//trimit la server

		send(c, &l_nou, sizeof(l_nou), 0);
		send(c, &cuv, sizeof(cuv), 0);


	}
	else
	{
		//client 2
		char cuv[100], l_nou;
		recv(c, &l_nou, sizeof(l_nou), 0);
		recv(c, &cuv, sizeof(cuv), 0);
		printf("am primit de la server %s %c \n", cuv, l_nou);

		printf("introduceti litera noua: \n");
		scanf("%c", &l_nou);
		printf("introduceti cuvant nou: \n");
		scanf("%s", &cuv);
		printf("am citit %s %c \n", cuv, l_nou);
		//trimit la server

		send(c, &l_nou, sizeof(l_nou), 0);
		send(c, &cuv, sizeof(cuv), 0);

	}
	return 0;
}