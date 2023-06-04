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

void deservire_client(int c) {
	char cuv[30];
	recv(c, &cuv, sizeof(cuv), 0);
	printf("Serverul a primit cuvantul %s\n", &cuv);
	int poz[3];
	printf("Lungimea cuvantului este %d\n", strlen(cuv));
	int r;
	for (int i = 0; i < 3; i++) {
		if (i > 0) {
			do {
				r = rand() % strlen(cuv);
				poz[i] = r;
			} while (poz[i] == poz[i - 1]);
		}
		else {
			r = rand() % strlen(cuv);
			poz[i] = r;
		}
	}
	int s = 0;
	for (int i = 0; i < 3; i++) {
		s += (int)cuv[poz[i]];
	}
	printf("%d\n",s);
	int ghicit;
	char mesaj1[100], mesaj2[100], rasp[5];
	strcpy(mesaj2, "Doriti sa mai incercati?");
	for (int i = 0; i < 5; i++) {
		recv(c, &ghicit, sizeof(ghicit), MSG_WAITALL);
		if (ghicit == s) {
			sprintf(mesaj1, "Ati ghicit din %d incercari.", i+1);
			send(c, &mesaj1, sizeof(mesaj1), 0);
			break;
		}
		else {
			send(c, &mesaj2, sizeof(mesaj2), 0);
			recv(c, &rasp, sizeof(rasp), MSG_WAITALL);
			printf("Serverul a primit raspunsul %s\n", &rasp);
			if (rasp[0] == 'n') {
				sprintf(mesaj1, "Ati avut %d incercari.", i+1);
				send(c, &mesaj1, sizeof(mesaj1), 0);
				break;
			}
		}
	}
	close(c);
}

int main() {
	int s, c;
	struct sockaddr_in serverAddr;
	struct sockaddr_in clientAddr;
	socklen_t addr_size;

	s = socket(AF_INET, SOCK_STREAM, 0);
	memset(&serverAddr, 0, sizeof(serverAddr));
	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(8888);
	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

	if (bind(s, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
		printf("Eroare la bind\n");
		return 1;
	}
	listen(s, 5);
	addr_size = sizeof(clientAddr);
	memset(&clientAddr, 0, sizeof(clientAddr));
	srand(time(NULL));
	while (1) {
		c = accept(s, (struct sockaddr*)&clientAddr, &addr_size);
		//signal(SIGCHLD, SIG_IGN); //nu vor exista zombie, se ignora codul de exit al copilului
		if (fork() == 0) {
			deservire_client(c);
			return(0);
		}
	}
}