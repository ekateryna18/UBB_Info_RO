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
	char cuv[30];
	printf("Introduceti un cuvant: ");
	scanf("%s",&cuv);
	send(c, &cuv, sizeof(cuv), 0);
	printf("Clientul a trimis cuvantul serverului\n");
	//partea de ghicit
	int ghicit;
	char mesaj[100], rasp[5];
	for (int i = 0; i < 5; i++) {
		printf("Ghiciti numarul: ");
		scanf("%d", &ghicit);
		send(c, &ghicit, sizeof(ghicit), 0);
		recv(c, &mesaj, sizeof(mesaj), MSG_WAITALL);
		printf("%s\n", &mesaj);
		if (strcmp(mesaj, "Doriti sa mai incercati?")) {
			return 0;
		}
		else {
			printf("Raspunsul dumneavoastra este (da/nu): \n");
			scanf("%s", &rasp);
			send(c, &rasp, sizeof(rasp), 0);
			if (rasp[0] == 'n') {
				recv(c, &mesaj, sizeof(mesaj), MSG_WAITALL);
				printf("%s\n", &mesaj);
				return 0;
			}
		}
	}
	printf("Ati epuizat toate cele 5 incercari.\n");
	return 0;
}