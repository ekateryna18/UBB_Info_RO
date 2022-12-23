#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

int main() {
	int clientSocket, nr_spatii;
	//char buffer[1024];
	char sir[100];
	struct sockaddr_in serverAddr;

	clientSocket = socket(AF_INET, SOCK_STREAM, 0);

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
	printf("Trimit: %s ", sir);
	send(clientSocket, sir, strlen(sir), 0);

	recv(clientSocket, &nr_spatii, sizeof(int), 0);
	printf("Data received: %d\n", nr_spatii);
	close(clientSocket);
	return 0;
}
