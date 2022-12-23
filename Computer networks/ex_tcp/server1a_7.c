/*Un client trimite unui server un sir de caractere si doua numere(fie acestea s, i, l).
Serverul va returna clientului subsirul de lungime l a lui s care incepe la pozitia i.*/

#include <stdio.h>
#include <sys/types.h>
#include <netinet/ip.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

int main() {
	int welcomeSocket, newSocket;
	char sir[100], subsir[100];
	struct sockaddr_in serverAddr, serverStorage;
	//struct sockaddr_storage serverStorage;
	//socklen_t addr_size;
	int addr_size;

	welcomeSocket = socket(AF_INET, SOCK_STREAM, 0);

	memset(&serverAddr, 0, sizeof(serverAddr));

	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(8888);
	serverAddr.sin_addr.s_addr = INADDR_ANY;

	if (bind(welcomeSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) < 0)
	{
		perror("bind failed. ERROR");
		return 1;
	}

	listen(welcomeSocket, 5);
	addr_size = sizeof(serverStorage);
	memset(&serverStorage, 0, sizeof(serverStorage));

	while (1)
	{
		uint16_t l, poz, suma;
		newSocket = accept(welcomeSocket, (struct sockaddr*)&serverStorage, &addr_size);
		printf("S-a conectat un client\n");

		recv(newSocket, sir, sizeof(sir), MSG_WAITALL);
		recv(newSocket, &l, sizeof(l), MSG_WAITALL);
		recv(newSocket, &poz, sizeof(poz), MSG_WAITALL);
		
		l = ntohs(l);
		poz = ntohs(poz);

		strcpy(sir, sir+poz);
		strncpy(subsir, sir, l);
		send(newSocket, subsir, sizeof(subsir), 0);
	}
	close(welcomeSocket);
}