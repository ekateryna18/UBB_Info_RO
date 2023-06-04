/*Un client trimite unui server un sir de caractere.
Serverul va returna clientului numarul de caractere spatiu din sir.
gcc server1a_2.c -o server1a_2
gcc client1a_2.c -o client1a_2
*/

#include <stdio.h>
#include <sys/types.h>
#include <netinet/ip.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

int main() {
	int welcomeSocket, newSocket;
	//char buffer[1024];
	char sir[100];
	struct sockaddr_in serverAddr;
	struct sockaddr_storage serverStorage;
	socklen_t addr_size;

	welcomeSocket = socket(AF_INET, SOCK_STREAM, 0);

	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(8888);
	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

	if (bind(welcomeSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) 
	{
		perror("bind failed. ERROR");
		return 1;
	}

	listen(welcomeSocket, 3);
	addr_size = sizeof(serverStorage);
	while (1)
	{
		int nr_spatii = 0;
		newSocket = accept(welcomeSocket, (struct sockaddr*)&serverStorage, &addr_size);
		printf("waiting for clients...\n");
		recv(newSocket, sir, sizeof(sir), 0);
		printf("am primit: %s ", sir);

		for (int i = 0; i < strlen(sir); i++)
			if (sir[i] == ' ')
				nr_spatii++;
		printf("Trimit: %d\n", nr_spatii);
		send(newSocket, &nr_spatii, sizeof(int), 0);
	}
	close(newSocket);
	close(welcomeSocket);
}