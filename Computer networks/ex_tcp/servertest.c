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

void deservire_client(int c, uint16_t n, uint16_t x) {
	printf("S-a conectat un client.\n");
	


		printf("Trimit idjoc %d \n", n);
		printf("Trimit id %d \n", x);
		//trimit id joc
		send(c, &n, sizeof(n), 0);
		//trim nr client
		send(c, &x, sizeof(x), 0);
		char l = (rand() % (122 - 97)) + 97;
		printf("Am generat litera %c \n", l);
		send(c, &l, sizeof(l), 0);
	
	char l_nou, cuv[100];
	recv(c, &l_nou, sizeof(l_nou), 0);
	recv(c, &cuv, sizeof(cuv), 0);
	printf("am primit de la client %s %c \n", cuv, l_nou);
	int status = 1;
	while (status)
	{

		int ok = 1;
		for (int i = 0; i < strlen(cuv) && ok == 1; i++)
		{
			if (cuv[i] == l_nou)
				ok = 0;
		}
		if (ok == 0 && x % 2 == 1)
		{
			printf(" CONTINUAM jocul cu clientul pereche \n");
			send(c, &l_nou, sizeof(l_nou), 0);
			send(c, &cuv, sizeof(cuv), 0);

			recv(c, &l_nou, sizeof(l_nou), 0);
			recv(c, &cuv, sizeof(cuv), 0);
			printf("am primit de la client %s %c \n", cuv, l_nou);
			int ok1 = 1;
			for (int i = 0; i < strlen(cuv) && ok1 == 1; i++)
			{
				if (cuv[i] == l_nou)
					ok1 = 0;
			}
			if (ok1 = 0)
			{
				printf("Doriti sa continuati? (y/n)");
				char c;
				scanf("%c", &c);
				if (c == 'n')
					status = 0;
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
	uint16_t n = 1, x = 0;
	while (1) {
		c = accept(s, (struct sockaddr*)&clientAddr, &addr_size);
		x++;
		if (x % 2 == 0)
			n++;
		//signal(SIGCHLD, SIG_IGN); //nu vor exista zombie, se ignora codul de exit al copilului
		if (fork() == 0) {
			deservire_client(c, n, x);
			return(0);
		}
	}
}