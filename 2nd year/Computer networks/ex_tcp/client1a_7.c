/*Un client trimite unui server un sir de caractere si doua numere(fie acestea s, i, l).
Serverul va returna clientului subsirul de lungime l a lui s care incepe la pozitia i.*/

#include <stdio.h>
#include <sys/types.h>
#include <netinet/ip.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

int main() {
	int clientSocket;
	uint16_t l, poz, suma;
	char sir[100], subsir[100];
	struct sockaddr_in serverAddr;

	clientSocket = socket(AF_INET, SOCK_STREAM, 0);

	memset(&serverAddr, 0, sizeof(serverAddr));

	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(8888);
	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

	if (connect(clientSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) < 0)
	{
		perror("connect failed. Error");
		return 1;
	}

	printf("Dati un sir de caractere: ");
	fgets(sir, 100, stdin);
	printf("\nlungimea este? - ");
	scanf("%hu", &l);
	printf("\npozitia este? - ");
	scanf("%hu", &poz);

	l = htons(l);
	poz = htons(poz);

	send(clientSocket, sir, sizeof(sir), 0);
	send(clientSocket, &l, sizeof(l), 0);
	send(clientSocket, &poz, sizeof(poz), 0);

	recv(clientSocket, subsir, sizeof(subsir), 0);
	printf("Data received: %s\n", subsir);
	close(clientSocket);
	return 0;
}